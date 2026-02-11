module vga_top (
	i_clk, i_vga_clk, i_reset_n,
	i_pxlAddr, i_pxlData, i_ctrlVGA,
	o_vgaData
);

	// Inputs
	input logic i_clk;				// Memory Writing Clock
	input logic i_vga_clk;			// VGA display
	input logic i_reset_n;			// Asynchronous reset active low
	input [31:0] i_pxlAddr;
	input [31:0] i_pxlData;
	input mem_ctrl_t i_ctrlVGA;		// Pixel writing signals

	// Outputs
	output vga_out_t o_vgaData;

endmodule
