module sp_counter (
	// Input
	input logic i_clk,
	input logic i_reset_n,
	input logic	i_clear,

	// Output
	output logic [31:0] o_count
);

	always_ff @(posedge i_clk) begin
		if (~i_reset_n) begin
			o_count <= 32'b0;
		end else if (i_clear) begin
			o_count <= 32'b0;
		end else begin
			o_count <= o_count + 32'b1;
		end
	end

endmodule : sp_counter
