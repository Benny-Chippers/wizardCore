module vga_memory (
	i_clk, i_vga_clk, i_reset_n,
	i_pxlAddr, i_pxlData, i_ctrlVGA,
	i_pxlX, i_pxlY,
	o_color
);

	// Inputs
	input logic i_clk;
	input logic i_vga_clk;
	input logic i_reset_n;
	input logic [31:0] i_pxlAddr;
	input logic [31:0] i_pxlData;
	input mem_ctrl_t i_ctrlVGA;
	input logic [7:0] i_pxlX;
	input logic [7:0] i_pxlY;

	// Output
	output vga_color_t o_color;

	// Internal Signals
	reg buffer_select;

	logic [31:0] w_pxlAddr_0;
	logic [31:0] w_pxlData_0;
	mem_ctrl_t w_ctrlVGA_0;
	logic [7:0] w_pxlX_0;
	logic [7:0] w_pxlY_0;
	vga_color_t w_color_0;

	logic [31:0] w_pxlAddr_1;
	logic [31:0] w_pxlData_1;
	mem_ctrl_t w_ctrlVGA_1;
	logic [7:0] w_pxlX_1;
	logic [7:0] w_pxlY_1;
	vga_color_t w_color_1;


	// Buffer Select
	initial buffer_select = 0;

	always_ff @(posedge i_clk) begin
		if(i_reset_n) begin
			if(i_pxlAddr == 32'h1003_0000 && i_ctrlVGA.memWrite)
			buffer_select <= ~buffer_select;
		end else begin
			buffer_select <= 0;
		end
	end

	// Muxes
	always @(*) begin
		w_pxlAddr_0 = 0;
		w_pxlData_0 = 0;
		w_ctrlVGA_0 = 0;
		w_pxlX_0 = 0;
		w_pxlY_0 = 0;

		w_pxlAddr_1 = 0;
		w_pxlData_1 = 0;
		w_ctrlVGA_1 = 0;
		w_pxlX_1 = 0;
		w_pxlY_1 = 0;

		o_color = 0;

		case (buffer_select)
			0 : begin
				w_pxlAddr_0 = i_pxlAddr;
				w_pxlData_0 = i_pxlData;
				w_ctrlVGA_0 = i_ctrlVGA;
				w_pxlX_1 = i_pxlX;
				w_pxlY_1 = i_pxlY;
				o_color = w_color_1;
			end
			1 : begin
				w_pxlAddr_1 = i_pxlAddr;
				w_pxlData_1 = i_pxlData;
				w_ctrlVGA_1 = i_ctrlVGA;
				w_pxlX_0 = i_pxlX;
				w_pxlY_0 = i_pxlY;
				o_color = w_color_0;
			end
			default : /* Nothing */;
		endcase
	end

	// Frames
	vga_frame VGA_F0 (
			.i_clk 		(i_clk),
			.i_vga_clk 	(i_vga_clk),
			.i_pxlAddr 	(w_pxlAddr_0),
			.i_pxlData 	(w_pxlData_0),
			.i_ctrlVGA 	(w_ctrlVGA_0),
			.i_pxlX   	(w_pxlX_0),
			.i_pxlY   	(w_pxlY_0),
			.o_color  	(w_color_0)
		);

	vga_frame VGA_F1 (
			.i_clk 		(i_clk),
			.i_vga_clk 	(i_vga_clk),
			.i_pxlAddr 	(w_pxlAddr_1),
			.i_pxlData 	(w_pxlData_1),
			.i_ctrlVGA 	(w_ctrlVGA_1),
			.i_pxlX   	(w_pxlX_1),
			.i_pxlY   	(w_pxlY_1),
			.o_color  	(w_color_1)
		);


	// Logging
	`ifdef SIMULATION
	mem_memlog #(
		.LOG_FILENAME("vga_mem.log")
	) mm_vga (
            .i_clk      (i_clk),
            .i_memAddr  ({buffer_select,i_pxlAddr[30:0]}),
            .i_writeData(i_pxlData),
            .i_ctrlMEM  (i_ctrlVGA),
            .i_readData (0)
        );
    
    `endif
endmodule
