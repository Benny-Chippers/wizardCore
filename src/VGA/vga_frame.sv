module vga_frame (
	i_active, i_clk, i_vga_clk,
	i_pxlAddr, i_pxlData, i_ctrlVGA,
	i_pxlX, i_pxlY,
	o_color
);

	// Inputs
	input logic i_active;				// 1 (Active) means being used to display
										// 0 (Inactive) means is modifiable
    input logic i_clk;
    input logic i_vga_clk;
	input logic [31:0] i_pxlAddr;		// [23:16] selects color, [15:8] selects Y, [7:0] selects X
	input logic [31:0] i_pxlData;
	input mem_ctrl_t i_ctrlVGA;
	input logic [7:0] i_pxlX;
	input logic [7:0] i_pxlY;

	// Output
	output vga_color_t o_color;

endmodule
