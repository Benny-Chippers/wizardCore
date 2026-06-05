module xmem_fsm	(
	// Input
	input logic i_clk,
	input logic i_reset_n,
	input logic i_memRead,
	input logic i_memWrite,

	input logic i_compareHit,
	input logic i_dRdy_fall,

	input logic i_req_CtQ,
	input logic i_recv_QtC,

	// Output
	output macro_pkg::xmem_ctrl_t o_spi_ctrl,
	output logic [7:0] o_compareByte,
	output logic o_saveData,

	output logic o_send_QtC
);
	// FSM States
	typedef enum {
		IDLE_STATE,
		PRIME_RX_STATE,
		SEND_CMD_STATE,
		SEND_ADDR_STATE,
		SEND_ADDR_DATA_STATE,
		RCV_DATA_STATE,
		DONE_STATE
	} spi_state_e;

	// FSM
	spi_state_e current_state, next_state;
	logic [7:0] count, count_inc;
	logic count_rst;

	// Output Buffers
	macro_pkg::xmem_ctrl_t wB_spi_ctrl;
	logic wB_send_QtC;


	//POSSIBLE SEND CMD STATE

	// Send Data Selction
	localparam logic [1:0] NOTHING 	= 2'b00;
	localparam logic [1:0] COMMAND 	= 2'b01;
	localparam logic [1:0] ADDRESS 	= 2'b10;
	localparam logic [1:0] DATA 	= 2'b11;

	// Control Path Params
	localparam logic [7:0] WAIT_CYCLE = 8'd200;	// Keep more than 0

	// Compare Bytes
	localparam logic [7:0] IDLE = 	8'hFF;
	localparam logic [7:0] READY = 	8'h90;		// Since Pull down pins, good idea
	localparam logic [7:0] DONE = 	8'h60;		// to make first byte 0


	initial begin
		current_state = IDLE_STATE;
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
			next_state = IDLE_STATE;
			o_spi_ctrl = 0;
			o_spi_ctrl.select = 1;
			o_spi_ctrl.cmdRdy = 1;
			o_saveData = 0;
			o_send_QtC = 0;
		end else begin
			case (current_state)
				IDLE_STATE: begin
					count_rst = 1;
					o_spi_ctrl.select = 1;
					if(i_req_CtQ) begin
						next_state = PRIME_RX_STATE;
					end
				end
				PRIME_RX_STATE: begin
					if (count + 1 >= 2) begin
						// Wait for D_RDY Release
						// count_inc = count;
						o_spi_ctrl.cmdRdy = 1;
						if (i_dRdy_fall == 1) begin
							next_state = SEND_CMD_STATE;
							count_rst = 1;
						end
						// Resend CMD READY if no response
						if (count + 1 >= 255) begin
							count_rst = 1;
						end
					end else if (count + 1 == 1) begin
						// Entry cycle, Send CMD READY
						o_spi_ctrl.cmdRdy = 0;
					end
				end
				SEND_CMD_STATE: begin
					o_spi_ctrl.sendSelect = COMMAND;

					if (count + 1 >= 38) begin
						// Wait for D_RDY Release
						count_inc = count;
						o_spi_ctrl.cmdRdy = 1;
						if (i_dRdy_fall == 1) begin
							o_spi_ctrl.cmdRdy = 1;
							if (i_memWrite) begin
								next_state = SEND_ADDR_DATA_STATE;
							end else if (i_memRead) begin
								next_state = SEND_ADDR_STATE;
							end
							count_rst = 1;
						end

					end else if (count + 1 == 36) begin
						// send CMD READY
						o_spi_ctrl.cmdRdy = 0;

					end else if (count + 1 == 35) begin 		// 3 cycl for Latency, 8 cycl for CMD
						// Transaction end
						o_spi_ctrl.enable = 0;
						o_spi_ctrl.select = 1;

					end else if (count + 1 == 3) begin
						// Pull down CS at start of data
						o_spi_ctrl.select = 0;

					end else if (count + 1 == 2) begin
						// Begin Shifting
						o_spi_ctrl.enable = 1;

					end else if (count + 1 == 1) begin
						// Entry cycle
						o_spi_ctrl.readWrite = 1;
					end
				end
				SEND_ADDR_STATE: begin
					o_spi_ctrl.sendSelect = ADDRESS;

					if (count + 1 >= 38) begin
						// Wait for D_RDY Release
						count_inc = count;
						o_spi_ctrl.cmdRdy = 1;
						if (i_dRdy_fall == 1) begin
							next_state = RCV_DATA_STATE;
							count_rst = 1;
						end

					end else if (count + 1 == 36) begin
						// send CMD READY
						o_spi_ctrl.cmdRdy = 0;

					end else if (count + 1 == 35) begin 		// 3 cycl for Latency, 32 cycl for CMD
						// Transaction end
						o_spi_ctrl.enable = 0;
						o_spi_ctrl.select = 1;

					end else if (count + 1 == 3) begin
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
				SEND_ADDR_DATA_STATE: begin
					o_spi_ctrl.sendSelect = DATA;

					if (count + 1 >= 70) begin
						// Wait for D_RDY Release
						count_inc = count;
						o_spi_ctrl.cmdRdy = 1;
						if (i_dRdy_fall == 1) begin
							next_state = DONE_STATE;
							count_rst = 1;
						end

					end else if (count + 1 == 68) begin
						// send CMD READY
						o_spi_ctrl.cmdRdy = 0;

					end else if (count + 1 == 67) begin 		// 3 cycl for Latency, 64 cycl for CMD
						// Transaction end
						o_spi_ctrl.enable = 0;
						o_spi_ctrl.select = 1;
						o_spi_ctrl.dbl = 0;

					end else if (count + 1 == 3) begin
						// Pull down CS at start of data
						o_spi_ctrl.select = 0;

					end else if (count + 1 == 2) begin
						// Begin Shifting
						o_spi_ctrl.enable = 1;

					end else if (count + 1 == 1) begin
						// Entry cycle
						o_spi_ctrl.readWrite = 1;
						o_spi_ctrl.dbl = 1;
					end
				end
				RCV_DATA_STATE: begin
					if (count + 1 >= 34) begin 	// 32 cycles for Data, 2 cycle latency, 1 cycle save data
						// Data Received
						next_state = DONE_STATE;
						count_rst = 1;

						o_saveData = 1;

					end else if (count + 1 >= 33) begin 	// 1 cycl for pause, 32 cycles for Data, 1 cycle latency
						// Response Received
						o_spi_ctrl.enable = 0;
						o_spi_ctrl.select = 1;

					end else if (count + 1 == 1) begin
						// Entry Loop
						o_spi_ctrl.enable = 1;
						o_spi_ctrl.select = 0;
						o_spi_ctrl.readWrite = 0;
					end
				end
				DONE_STATE: begin
					count_inc = count;
					// CDC handshake
					o_send_QtC = 1;
					if(i_recv_QtC == 1) begin
						o_send_QtC = 0;
						next_state = IDLE_STATE;
						count_rst = 1;
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
