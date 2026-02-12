module vga_compCount #(
	parameter int COMPARE = 2,
	parameter int RESET = 521,
	parameter int OUTPUT_SHIFT = 2,
	parameter int OUTPUT_OFFSET = 31
) (
	i_clk, i_reset_n,
	o_comp, o_value
);

	// Inputs
	input logic i_clk;
	input logic i_reset_n;

	// Outputs
	output logic o_comp;
	output logic [7:0] o_value;

	// Internal
	logic [31:0] w_count;
	logic [31:0] w_inter;

	// Logic

	// Counter
	always_ff @(negedge i_clk or negedge i_reset_n) begin
		if(~i_reset_n) begin
			w_count <= 0;
		end else begin
			if (w_count + 1 < RESET) begin
				w_count <= w_count + 1;
			end else begin
				w_count <= 0;
			end
		end
	end

	// Compare
	always_comb begin
		assign o_comp = (w_count >= COMPARE);

		assign w_inter = ((w_count - OUTPUT_OFFSET) >> OUTPUT_SHIFT);
		assign o_value = w_inter[7:0];
	end

endmodule
