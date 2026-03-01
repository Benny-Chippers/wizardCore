module top_en (
	i_clk, i_reset_n,
	o_en_IF, o_en_ID, o_en_EX,
	o_en_MEM, o_en_WB
);

	//I/O
	input logic i_clk;
	input logic i_reset_n;

	output logic o_en_IF;
	output logic o_en_ID;
	output logic o_en_EX;
	output logic o_en_MEM;
	output logic o_en_WB;

	//FSM
	logic [2:0] current_state;
	logic [2:0] next_state;
	logic [3:0] count, count_inc;
	logic count_rst;

	// Local Params
	localparam IF_CYCLES = 1;
	localparam ID_CYCLES = 1;
	localparam EX_CYCLES = 1;
	localparam MEM_CYCLES = 1;
	localparam WB_CYCLES = 1;

	localparam IF_STATE = 3'b001;
	localparam ID_STATE = 3'b010;
	localparam EX_STATE = 3'b011;
	localparam MEM_STATE = 3'b100;
	localparam WB_STATE = 3'b101;

	initial begin
		current_state = 0;
	end

	always_ff @(posedge i_clk) begin
		current_state <= next_state;
		count <= (count_rst) ? 0 : count_inc;
	end

	always_comb begin
		count_inc = count + 1;
		o_en_IF = 0;
		o_en_ID = 0;
		o_en_EX = 0;
		o_en_MEM = 0;
		o_en_WB = 0;

		if(~i_reset_n) begin
			count_rst = 1;
			next_state = 0;
		end else begin
			case (current_state)
				0: begin
					next_state = IF_STATE;
					count_rst = 1;
				end
				IF_STATE: begin
					o_en_IF = 1;
					if (count_inc >= IF_CYCLES) begin
						next_state = ID_STATE;
						count_rst = 1;
					end else begin
						next_state = IF_STATE;
						count_rst = 0;
					end
				end
				ID_STATE: begin
					o_en_ID = 1;
					if (count_inc >= ID_CYCLES) begin
						next_state = EX_STATE;
						count_rst = 1;
					end else begin
						next_state = ID_STATE;
						count_rst = 0;
					end
				end
				EX_STATE: begin
					o_en_EX = 1;
					if (count_inc >= EX_CYCLES) begin
						next_state = MEM_STATE;
						count_rst = 1;
					end else begin
						next_state = EX_STATE;
						count_rst = 0;
					end
				end
				MEM_STATE: begin
					o_en_MEM = 1;
					if (count_inc >= MEM_CYCLES) begin
						next_state = WB_STATE;
						count_rst = 1;
					end else begin
						next_state = MEM_STATE;
						count_rst = 0;
					end
				end
				WB_STATE: begin
					o_en_WB = 1;
					if (count_inc >= WB_CYCLES) begin
						next_state = IF_STATE;
						count_rst = 1;
					end else begin
						next_state = WB_STATE;
						count_rst = 0;
					end
				end
				default : begin
					next_state = IF_STATE;
					count_rst = 1;
				end
			endcase
		end
	end

endmodule : top_en
