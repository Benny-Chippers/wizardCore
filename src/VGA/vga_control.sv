module vga_control (
	i_vga_clk, i_reset_n,
	o_pxlX, o_pxlY,
	o_vSync , o_hSync
);

	// Inputs
	input logic i_vga_clk;
	input logic i_reset_n;

	// Outputs
	output logic [7:0] o_pxlX;
	output logic [7:0] o_pxlY;
	output logic o_vSync;
	output logic o_hSync;


endmodule
