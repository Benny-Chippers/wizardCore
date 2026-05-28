module vga_frame (
	// Inputs
    input logic i_clk,
    input logic i_vga_clk,
	// Cpu addr bit[15]: 0=vga_color frame FB, 1=vga_palette (see memory_Map.md).
	// Frame store byte addr fields: Addr[14:8] row Y, Addr[7:0] col X within 160x120.
	input logic [31:0] i_pxlAddr,
	input logic [31:0] i_pxlData,
	input macro_pkg::mem_ctrl_t i_ctrlVGA,
	input logic [7:0] i_pxlX,			// Scan-out raster X (active image coords)
	input logic [7:0] i_pxlY,			// Scan-out raster Y (active image coords)

	// Enables
    input logic en_MEM,

	// Output
	output macro_pkg::vga_color_t o_color
);

	// Route LSU to framebuffer or palette; FRAME_DATA feeds palette idx + valid to VGA_PALETTE

	// Internal signals
	logic [31:0] w_frameAddr;
	logic [31:0] w_palAddr;
	logic [31:0] w_frameData;
	logic [31:0] w_palData;
	macro_pkg::mem_ctrl_t w_frameCtrl;
	macro_pkg::mem_ctrl_t w_palCtrl;

	logic [7:0] w_palIdx;
	logic w_validRD;


	always_comb begin
		w_frameAddr = 0;
		w_palAddr = 0;
		w_frameData = 0;
		w_palData = 0;
		w_frameCtrl = 0;
		w_palCtrl = 0;
		if(i_pxlAddr[31:16] == 16'h1000) begin
			case (i_pxlAddr[15])
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
		.o_value  (w_palIdx),
		.o_validRD(w_validRD)
	);

	vga_palette VGA_PALETTE (
		.i_clk    (i_clk),
		.i_vga_clk(i_vga_clk),
		.i_palAddr(w_palAddr),
		.i_palData(w_palData),
		.i_ctrlVGA(w_palCtrl),
		.en_MEM   (en_MEM),
		.i_palIdx (w_palIdx),
		.i_validRD(w_validRD),
		.o_color  (o_color)
	);

endmodule
