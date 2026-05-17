module ex_alu_fsm (
	// Input
	input logic i_clk,
	input logic i_reset_n,
	input logic en_ALU,
	input macro_pkg::alu_ctrl_t i_ctrlALU,
	input logic i_dspDone,

	// Output
	output logic o_stall,
	output logic o_dspEn
);

	// FSM States
	typedef enum {
		IDLE_STATE,
		MULT_STATE,
		DIV_STATE
	} spi_state_e;

	// FSM
	spi_state_e current_state, next_state;
	logic [7:0] count, count_inc;
	logic count_rst;

	// Internal Signals
	logic w_done;


	always_ff @(posedge i_clk) begin
		if(~i_reset_n) begin
			current_state <= IDLE_STATE;
			count <= 0;
		end else begin
			current_state <= next_state;
			if (~count_rst) begin
				count <= count_inc;
			end else begin
				count <= 0;
			end
		end
	end

	always_comb begin
		// state machine
		count_inc = count + 1;
		count_rst = 0;
		next_state = current_state;
		o_dspEn = 0;
		w_done = 0;

		unique case (current_state)
			IDLE_STATE:begin
				count_rst = 1;
				if (i_ctrlALU.func7 == 7'b000_0001 && en_ALU == 1) begin
					o_dspEn = 1;
					if(i_ctrlALU.func3[2] == 0) begin 	// MULT
						next_state = MULT_STATE;
					end else begin
						next_state = DIV_STATE;
					end
				end
			end
			MULT_STATE: begin
				o_dspEn = 1;
				if (count_inc >= 6) begin
					w_done = 1;
					next_state = IDLE_STATE;
				end
			end
			DIV_STATE: begin
				count_rst = 1;
				if (i_dspDone == 1) begin
					w_done = 1;
					next_state = IDLE_STATE;
				end
			end
			default : next_state = IDLE_STATE;
		endcase

		// stall logic
		o_stall = 0;
		if (i_ctrlALU.func7 == 7'b000_0001) begin
			o_stall = en_ALU & ~w_done;
		end
	end

endmodule : ex_alu_fsm
