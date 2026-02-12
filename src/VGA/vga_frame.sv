module vga_frame (
	i_clk, i_vga_clk,
	i_pxlAddr, i_pxlData, i_ctrlVGA,
	i_pxlX, i_pxlY,
	o_color
);

	// Inputs
    input logic i_clk;
    input logic i_vga_clk;
	input logic [31:0] i_pxlAddr;		// [23:16] selects color, [15:8] selects Y, [7:0] selects X
	input logic [31:0] i_pxlData;
	input mem_ctrl_t i_ctrlVGA;
	input logic [7:0] i_pxlX;			// Controls output
	input logic [7:0] i_pxlY;			//

	// Output
	output vga_color_t o_color;

	// Internal signals
	logic [31:0] w_redAddr;
	logic [31:0] w_greenAddr;
	logic [31:0] w_blueAddr;
	logic [31:0] w_redData;
	logic [31:0] w_greenData;
	logic [31:0] w_blueData;
	mem_ctrl_t w_redCtrl;
	mem_ctrl_t w_greenCtrl;
	mem_ctrl_t w_blueCtrl;

	vga_color_t w_color;

	always_comb begin
		w_redAddr = 0;
		w_greenAddr = 0;
		w_blueAddr = 0;
		w_redData = 0;
		w_greenData = 0;
		w_blueData = 0;
		w_redCtrl = 0;
		w_greenCtrl = 0;
		w_blueCtrl = 0;
		case (i_pxlAddr[17:16])
			2'h0: begin
				w_redAddr = i_pxlAddr;
				w_redData = i_pxlData;
				w_redCtrl = i_ctrlVGA;
			end
			2'h1: begin
				w_greenAddr = i_pxlAddr;
				w_greenData = i_pxlData;
				w_greenCtrl = i_ctrlVGA;
			end
			2'h2: begin
				w_blueAddr = i_pxlAddr;
				w_blueData = i_pxlData;
				w_blueCtrl = i_ctrlVGA;
			end
			default : /* Nothing */;
		endcase
	end

	vga_color redColor (
			.i_clk    (i_clk),
			.i_vga_clk(i_vga_clk),
			.i_pxlAddr(w_redAddr),
			.i_pxlData(w_redData),
			.i_ctrlVGA(w_redCtrl),
			.i_pxlX   (i_pxlX),
			.i_pxlY   (i_pxlY),
			.o_value  (o_color.red)
		);
	vga_color greenColor (
			.i_clk    (i_clk),
			.i_vga_clk(i_vga_clk),
			.i_pxlAddr(w_greenAddr),
			.i_pxlData(w_greenData),
			.i_ctrlVGA(w_greenCtrl),
			.i_pxlX   (i_pxlX),
			.i_pxlY   (i_pxlY),
			.o_value  (o_color.green)
		);
	vga_color #(
			.INIT_FILENAME("test.bin")
		) blueColor (
			.i_clk    (i_clk),
			.i_vga_clk(i_vga_clk),
			.i_pxlAddr(w_blueAddr),
			.i_pxlData(w_blueData),
			.i_ctrlVGA(w_blueCtrl),
			.i_pxlX   (i_pxlX),
			.i_pxlY   (i_pxlY),
			.o_value  (o_color.blue)
		);
endmodule
