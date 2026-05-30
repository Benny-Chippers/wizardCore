module sp_counter (
	// Input
	input logic i_clk,
	input logic i_reset_n,

	// Output
	output logic [31:0] o_count
);

	always_ff @(posedge i_clk) begin : proc_
		if(~i_reset_n) begin
			o_count <= 0;
		end else begin
			o_count <= o_count + 1;;
		end
	end

endmodule : sp_counter
