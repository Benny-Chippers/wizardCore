module vga_memory (
	// Inputs
	input logic i_clk,
	input logic i_vga_clk,
	input logic i_reset_n_CPU,
	input logic [31:0] i_pxlAddr,
	input logic [31:0] i_pxlData,
	input macro_pkg::mem_ctrl_t i_ctrlVGA,
	input logic [7:0] i_pxlX,
	input logic [7:0] i_pxlY,

	// Enables
	input logic en_MEM,

	// Output
	output macro_pkg::vga_color_t o_color
);


	// Internal Signals
	logic buffer_select_cpu;
	logic buffer_select_vga;

	logic [31:0] w_pxlAddr_0;
	logic [31:0] w_pxlData_0;
	macro_pkg::mem_ctrl_t w_ctrlVGA_0;
	logic [7:0] w_pxlX_0;
	logic [7:0] w_pxlY_0;
	macro_pkg::vga_color_t w_color_0;

	logic [31:0] w_pxlAddr_1;
	logic [31:0] w_pxlData_1;
	macro_pkg::mem_ctrl_t w_ctrlVGA_1;
	logic [7:0] w_pxlX_1;
	logic [7:0] w_pxlY_1;
	macro_pkg::vga_color_t w_color_1;


	// Buffer Select
	initial buffer_select_cpu = 0;
	initial buffer_select_vga = 0;

	always_ff @(posedge i_clk) begin
		if(i_reset_n_CPU) begin
			if(i_pxlAddr == 32'h1003_0000 && i_ctrlVGA.memWrite)
			buffer_select_cpu <= ~buffer_select_cpu;
		end else begin
			buffer_select_cpu <= 0;
		end
	end

	`ifdef SIMULATION
	sig_sync SS1 (
		.i_clkA   (i_clk),
		.i_clkB   (i_vga_clk),
		.i_reset_n(i_reset_n_CPU),
		.i_sigIn  (buffer_select_cpu),
		.o_sigOut (buffer_select_vga)
		);
	`else
	xpm_cdc_single #(
	   .DEST_SYNC_FF(2),   // DECIMAL; range: 2-10
	   .INIT_SYNC_FF(0),   // DECIMAL; 0=disable simulation init values, 1=enable simulation init values
	   .SIM_ASSERT_CHK(1), // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
	   .SRC_INPUT_REG(1)   // DECIMAL; 0=do not register input, 1=register input
	)
	xpm_cdc_single_inst (
	   .src_clk(i_clk),   // 1-bit input: optional; required when SRC_INPUT_REG = 1
	   .src_in(buffer_select_cpu),     // 1-bit input: Input signal to be synchronized to dest_clk domain.

	   .dest_clk(i_vga_clk), // 1-bit input: Clock signal for the destination clock domain.
	   .dest_out(buffer_select_vga)  // 1-bit output: src_in synchronized to the destination clock domain. This output is registered.
	);
	`endif

	// Muxes
	// CPU clk mux
	always_comb begin
		w_pxlAddr_0 = 0;
		w_pxlData_0 = 0;
		w_ctrlVGA_0 = 0;

		w_pxlAddr_1 = 0;
		w_pxlData_1 = 0;
		w_ctrlVGA_1 = 0;

		case (buffer_select_cpu)
			0 : begin
				w_pxlAddr_0 = i_pxlAddr;
				w_pxlData_0 = i_pxlData;
				w_ctrlVGA_0 = i_ctrlVGA;
			end
			1 : begin
				w_pxlAddr_1 = i_pxlAddr;
				w_pxlData_1 = i_pxlData;
				w_ctrlVGA_1 = i_ctrlVGA;
			end
			default : /* Nothing */;
		endcase
	end
	// VGA clk mux
	always_comb begin
		w_pxlX_0 = 0;
		w_pxlY_0 = 0;

		w_pxlX_1 = 0;
		w_pxlY_1 = 0;

		o_color = 0;

		case (buffer_select_vga)
			0 : begin
				w_pxlX_1 = i_pxlX;
				w_pxlY_1 = i_pxlY;
				o_color = w_color_1;
			end
			1 : begin
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
			.en_MEM   	(en_MEM),
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
			.en_MEM   	(en_MEM),
			.o_color  	(w_color_1)
		);


	// Logging
	`ifdef SIMULATION
	mem_memlog #(
		.LOG_FILENAME("vga_mem.log")
	) mm_vga (
            .i_clk      (i_clk),
            .en_MEM     (en_MEM),
            .en_WB 		(0),
            .i_memAddr  ({buffer_select_vga,i_pxlAddr[30:0]}),
            .i_writeData(i_pxlData),
            .i_ctrlMEM  (i_ctrlVGA),
            .i_readData (0)
        );
    
    `endif
endmodule
