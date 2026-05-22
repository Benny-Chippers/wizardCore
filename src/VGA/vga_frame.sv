module vga_frame (
	// Inputs
    input logic i_clk,
    input logic i_vga_clk,
	input logic [31:0] i_pxlAddr,		// [23:16] selects color, [15:8] selects Y, [7:0] selects X
	input logic [31:0] i_pxlData,
	input macro_pkg::mem_ctrl_t i_ctrlVGA,
	input logic [7:0] i_pxlX,			// Controls output
	input logic [7:0] i_pxlY,			//

	// Enables
    input logic en_MEM,

	// Output
	output macro_pkg::vga_color_t o_color
);


	// Internal signals
	logic [31:0] w_frameAddr;
	logic [31:0] w_palAddr;
	logic [31:0] w_frameData;
	logic [31:0] w_palData;
	macro_pkg::mem_ctrl_t w_frameCtrl;
	macro_pkg::mem_ctrl_t w_palCtrl;

	logic [7:0] w_palIdx;


	always_comb begin
		w_frameAddr = 0;
		w_palAddr = 0;
		w_frameData = 0;
		w_palData = 0;
		w_frameCtrl = 0;
		w_palCtrl = 0;
		case (i_pxlAddr[11])
			0: begin
				w_frameAddr = i_pxlAddr;
				w_frameData = i_pxlData;
				w_frameCtrl = i_ctrlVGA;
			end
			1: begin
				w_palAddr = i_pxlAddr;
				w_palData = i_pxlData;
				w_palCtrl = i_ctrlVGA;
			end
			default : /* Nothing */;
		endcase
	end

	vga_color FRAME_DATA (
		.i_clk    (i_clk),
		.i_vga_clk(i_vga_clk),
		.i_pxlAddr(w_frameAddr),
		.i_pxlData(w_frameData),
		.i_ctrlVGA(w_frameCtrl),
		.en_MEM   (en_MEM),
		.i_pxlX   (i_pxlX),
		.i_pxlY   (i_pxlY),
		.o_value  (w_palIdx)
	);

	vga_palette VGA_PALETTE (
		.i_clk    (i_clk),
		.i_vga_clk(i_vga_clk),
		.i_palAddr(w_palAddr),
		.i_palData(w_palData),
		.i_ctrlVGA(w_palCtrl),
		.en_MEM   (en_MEM),
		.i_palIdx (w_palIdx),
		.o_color  (o_color)
	);

endmodule
