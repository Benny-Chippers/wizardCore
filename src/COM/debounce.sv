// `include "macro_def.sv"

module debounce (
	// Input
	input logic i_clk,
	input logic i_reset_n,
	input logic i_pin,

	// Output
	output logic o_pin
);
	// Params
	localparam MS_WAIT = 2;
	localparam CYCLES_WAIT = MS_WAIT * `CPU_FREQ / 1000;
	localparam COUNT_WDITH = $clog2(CYCLES_WAIT);

	// Internal Signals
	logic [COUNT_WDITH-1:0] counter;

	always_ff @(posedge i_clk) begin
		if (~i_reset_n) begin
			o_pin   <= 1'b1;
			counter <= '0;
		end else begin
			if (i_pin == o_pin) begin
				counter <= '0;
			end else begin
				counter <= counter + 1'b1;

				if (counter >= COUNT_WDITH'(CYCLES_WAIT - 1)) begin
					o_pin   <= i_pin;
					counter <= '0;
				end
			end
		end
	end

endmodule : debounce