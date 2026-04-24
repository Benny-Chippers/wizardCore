module sig_sync (
	// Inputs/Outputs
	input logic i_clkA,
	input logic i_clkB,
	input logic i_reset_n,
	input logic i_sigIn,
	// Output
	output logic o_sigOut
);


	// Internal signals
	logic r_sampleA;
	logic r_sampleB;

	// Clock 1 sampling
	always_ff @(posedge i_clkA) begin
		if(~i_reset_n) begin
			r_sampleA <= 0;
		end else begin
			r_sampleA <= i_sigIn;
		end
	end

	// Clock 2 sampling
	always_ff @(posedge i_clkB) begin
		if(~i_reset_n) begin
			r_sampleB <= 0;
			o_sigOut <= 0;
		end else begin
			r_sampleB <= r_sampleA;
			o_sigOut <= r_sampleB;
		end
	end

endmodule
