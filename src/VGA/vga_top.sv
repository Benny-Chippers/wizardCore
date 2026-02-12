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

	// Wires
	mem_ctrl_t w_ctrlVGA;

	logic [7:0] w_pxlX;
	logic [7:0] w_pxlY;


	vga_memory VGA_MEM (
		.i_clk    (i_clk),
		.i_vga_clk(i_vga_clk),
		.i_reset_n(i_reset_n),
		.i_pxlAddr(i_pxlAddr),
		.i_pxlData(i_pxlData),
		.i_ctrlVGA(w_ctrlVGA),
		.i_pxlX   (w_pxlX),
		.i_pxlY   (w_pxlY),
		.o_color  (o_vgaData[11:0])
		);

	vga_compCount #(
		.COMPARE(96),
		.RESET(800),
		.OUTPUT_SHIFT(2),
		.OUTPUT_OFFSET(144)
	) VGA_X (
		.i_clk    (i_vga_clk),
		.i_reset_n(i_reset_n),
		.o_comp   (o_vgaData.hSync),
		.o_value  (w_pxlX)
	);

	vga_compCount #(
		.COMPARE(2),
		.RESET(521),
		.OUTPUT_SHIFT(2),
		.OUTPUT_OFFSET(31)
	) VGA_Y (
		.i_clk    (o_vgaData.hSync),
		.i_reset_n(i_reset_n),
		.o_comp   (o_vgaData.vSync),
		.o_value  (w_pxlY)
	);

endmodule
