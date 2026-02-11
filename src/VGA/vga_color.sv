module vga_color (
	i_clk, i_vga_clk,
	i_pxlAddr, i_pxlData, i_ctrlVGA,
	i_pxlX, i_pxlY,
	o_value
);

	// Inputs
	input logic i_clk;
	input logic i_vga_clk;
	input logic [31:0] i_pxlAddr;
	input logic [31:0] i_pxlData;
	input mem_ctrl_t i_ctrlVGA;
	input logic [7:0] i_pxlX;
	input logic [7:0] i_pxlY;

	// Output
	output [3:0] o_value;

endmodule
