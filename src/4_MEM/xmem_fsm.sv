module xmem_fsm	(
	// Input
	input logic i_clk,
	input logic i_reset_n,
	input logic i_memRead,
	input logic i_memWrite,
	input logic i_compareHit,

	input logic i_req_CtQ,
	input logic i_recv_QtC,

	// Output
	output macro_pkg::xmem_ctrl_t o_spi_ctrl,
	output logic [7:0] o_compareByte,
	output logic o_saveData,

	output logic o_send_QtC
);


	// FSM
	logic [2:0] current_state, next_state;
	logic [7:0] count, count_inc;
	logic count_rst;

	// Output Buffers
	macro_pkg::xmem_ctrl_t wB_spi_ctrl;
	logic wB_send_QtC;

	// FSM States
	localparam logic [2:0] IDLE_STATE 		= 3'b001;
	localparam logic [2:0] SEND_ADDR_STATE 	= 3'b010;
	localparam logic [2:0] SEND_DATA_STATE	= 3'b011;
	localparam logic [2:0] RCV_RESP_STATE 	= 3'b100;
	localparam logic [2:0] RCV_DATA_STATE 	= 3'b101;
	localparam logic [2:0] DONE_STATE 		= 3'b110;
	//POSSIBLE SEND CMD STATE

	// Send Data Selction
	localparam logic [1:0] NOTHING 	= 2'b00;
	localparam logic [1:0] ADDRESS 	= 2'b01;
	localparam logic [1:0] DATA 	= 2'b10;
	localparam logic [1:0] COMPLETE = 2'b11;

	// Control Path Params
	localparam logic [7:0] WAIT_CYCLE = 8'd200;	// Keep more than 0

	// Compare Bytes
	localparam logic [7:0] IDLE = 	8'hFF;
	localparam logic [7:0] READY = 	8'h90;		// Since Pull down pins, good idea
	localparam logic [7:0] DONE = 	8'h60;		// to make first byte 0


	initial begin
		current_state = 0;
	end

	always_ff @(posedge i_clk) begin
		// State Managing
		current_state <= next_state;
		count <= (count_rst) ? 0 : count_inc;

		// Output State saving
		wB_spi_ctrl <= o_spi_ctrl;
		wB_send_QtC <= o_send_QtC;
	end

	always_comb begin
		count_inc = count + 1;
		// Defaults
		o_spi_ctrl = wB_spi_ctrl;
		o_send_QtC = wB_send_QtC;

		count_rst = 0;
		o_spi_ctrl.sendSelect = NOTHING;
		o_compareByte = IDLE;
		o_saveData = 0;

		next_state = current_state;



		if(~i_reset_n) begin
			count_rst = 1;
			next_state = 0;
			o_spi_ctrl = 0;
			o_saveData = 0;
			o_send_QtC = 0;
		end else begin
			case (current_state)
				0: begin
					next_state = IDLE_STATE;
					count_rst = 1;
				end
				IDLE_STATE: begin
					count_rst = 1;
					o_spi_ctrl.select = 1;
					if(i_req_CtQ) begin
						next_state = SEND_ADDR_STATE;
					end
				end
				SEND_ADDR_STATE: begin
					o_spi_ctrl.sendSelect = ADDRESS;
					if (count_inc >= 12) begin 		// 2 cycl for Latency, 8 cycl for Addr, 2 cycl prep/wait
						// Address Sent
						if (i_memWrite) begin
							next_state = SEND_DATA_STATE;
						end else if (i_memRead) begin
							next_state = RCV_RESP_STATE;
						end
						count_rst = 1;

						o_spi_ctrl.enable = 0;

					end else if (count_inc == 4) begin
						// Pull down CS at start of data
						o_spi_ctrl.select = 0;

					end else if (count_inc == 2) begin
						// Begin Shifting
						o_spi_ctrl.enable = 1;

					end else if (count_inc == 1) begin
						// Entry cycle
						o_spi_ctrl.readWrite = 1;
					end
				end
				SEND_DATA_STATE: begin
					o_spi_ctrl.sendSelect = DATA;
					if (count_inc >= 12) begin 		// 2 cycl for Latency, 8 cycl for Addr, 2 cycl prep/wait
						// Address Sent
						next_state = RCV_RESP_STATE;
						count_rst = 1;

						o_spi_ctrl.enable = 0;

					end else if (count_inc == 2) begin
						// Begin Shifting
						o_spi_ctrl.enable = 1;

					end else if (count_inc == 1) begin
						// Entry cycle
						o_spi_ctrl.readWrite = 1;

					end
				end
				RCV_RESP_STATE: begin
					// Which Response Expecting
					if (i_memWrite) begin
						o_compareByte = DONE;
					end else if (i_memRead) begin
						o_compareByte = READY;
					end

					if (count_inc >= WAIT_CYCLE + 2) begin 	// 2 cycl for Latency, wait until macth ready/done
						count_inc = count;		// Pause count so no overflow, won't interfere with reset

						if(i_compareHit) begin
							// Response Received
							if (i_memWrite) begin
								next_state = DONE_STATE;
							end else if (i_memRead) begin
								next_state = RCV_DATA_STATE;
							end
							count_rst = 1;

							o_spi_ctrl.enable = 0;
						end

					end else if (count_inc == WAIT_CYCLE + 1) begin
						// Begin Reading
						o_spi_ctrl.enable = 1;
						o_spi_ctrl.select = 0;
					end else if (count_inc == 1) begin
						// Entry Loop, Give time for NB to processes packet
						o_spi_ctrl.readWrite = 0;
						o_spi_ctrl.select = 1;
					end
				end
				RCV_DATA_STATE: begin
					if (count_inc >= 10) begin 	// 8 cycles for Data, 2 cycle latency, 1 cycle save data
						// Data Received
						next_state = DONE_STATE;
						count_rst = 1;

						o_saveData = 1;

					end else if (count_inc >= 10) begin 	// 1 cycl for pause, 8 cycles for Data, 1 cycle latency
						// Response Received
						o_spi_ctrl.enable = 0;

					end else if (count_inc == 1) begin
						// Entry Loop
						o_spi_ctrl.enable = 1;
						o_spi_ctrl.readWrite = 0;
					end
				end
				DONE_STATE: begin
					o_spi_ctrl.sendSelect = COMPLETE;
					if (count_inc >= 4) begin 		// 2 cycl for Latency, 2 cycl for Done, pause and release stall
						// COMPLETE Sent
						count_inc = count;	// Pause count so no overflow, won't interfere with reset
						o_spi_ctrl.enable = 0;

						// CDC handshake
						o_send_QtC = 1;
						if(i_recv_QtC == 1) begin
							o_send_QtC = 0;
							next_state = IDLE_STATE;
							count_rst = 1;
						end

					end else if (count_inc == 2) begin
						// Begin Shifting
						o_spi_ctrl.enable = 1;

					end else if (count_inc == 1) begin
						// Entry cycle
						o_spi_ctrl.readWrite = 1;

					end
				end
				default : begin
					next_state = IDLE_STATE;
					count_rst = 1;
				end
			endcase
		end
	end


endmodule
