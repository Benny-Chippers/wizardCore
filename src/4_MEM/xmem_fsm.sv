module xmem_fsm	(
	// Input
	input logic i_clk,
	input logic i_reset_n,
	input macro_pkg::mem_ctrl_t i_ctrlMEM,
	input logic [7:0] i_shift_reg,

	// Output
	output macro_pkg::xmem_ctrl_t o_spi_ctrl
);


	// FSM
	logic [2:0] current_state, next_state;
	logic [3:0] count, count_inc;
	logic count_rst;

	// FSM States
	localparam logic [2:0] IDLE_STATE = 3'b001;
	localparam logic [2:0] SEND_ADDR_STATE = 3'b010;
	localparam logic [2:0] SEND_DATA_STATE = 3'b011;
	localparam logic [2:0] RCV_RESP_STATE = 3'b100;
	localparam logic [2:0] RCV_DATA_STATE = 3'b101;
	localparam logic [2:0] DONE_STATE = 3'b110;


	initial begin
		current_state = 0;
	end

	always_ff @(posedge i_clk) begin
		current_state <= next_state;
		count <= (count_rst) ? 0 : count_inc;
	end

	always_comb begin
		count_inc = count + 1;
		count_rst = 1;


		if(~i_reset_n) begin
			count_rst = 1;
			next_state = 0;
		end else begin
			case (current_state)
				0: begin
					next_state = IDLE_STATE;
					count_rst = 1;
				end
				IDLE_STATE: begin
					// o_en_IF = 1;
					// if (count_inc >= IF_CYCLES && !stall_IF) begin
					// 	next_state = ID_STATE;
					// 	count_rst = 1;
					// end else begin
					// 	next_state = IF_STATE;
					// 	count_rst = 0;
					// end
				end
				SEND_ADDR_STATE: begin
					if (count_inc >= 8) begin 		// 4 cycl for Addr, 4 cycl wait
						next_state = SEND_DATA_STATE;
					end
				end
				SEND_DATA_STATE: begin
					next_state = IDLE_STATE;
				end
				RCV_RESP_STATE: begin
					next_state = IDLE_STATE;
				end
				RCV_DATA_STATE: begin
					next_state = IDLE_STATE;
				end
				RCV_DATA_STATE: begin
					next_state = IDLE_STATE;
				end
				default : begin
					next_state = IDLE_STATE;
					count_rst = 1;
				end
			endcase
		end
	end


endmodule
