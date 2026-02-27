module vga_color #(
	parameter string INIT_FILENAME = "test_rv32i.bin"
) (
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
	output logic [3:0] o_value;

	// Memory Array
    (* ram_style = "block" *)
	logic [7:0] color_array [120] [80];	// storing 120x160 4-bit chunks,
										// since byte addressible, width is 80 bytes
	initial begin
        int fd;
        string path = {"../scripts/", INIT_FILENAME};
        $display("Loading color.");
        fd = $fopen(path, "rb");
        if(fd == 0) begin
            $display("Failed to open test.bin, init with zero");
            foreach (color_array[i]) begin
            	foreach (color_array[i][j]) begin
            		color_array[i][j] = 0;
            	end
        	end
            // $finish;
        end
        $display("Opened %s", INIT_FILENAME);

        $fread(color_array, fd);
        $fclose(fd);

        $display("%h",color_array[0][0]);
    end

    // Memory Write
    always_ff @(posedge i_clk) begin
        if (i_ctrlVGA.memWrite) begin
            unique case (i_ctrlVGA.size)
                2'b00: begin
                	color_array[i_pxlAddr[14:8]][i_pxlAddr[6:0]] <= i_pxlData[7:0];
                end
                2'b01: begin
                	color_array[i_pxlAddr[14:8]][{i_pxlAddr[6:1],1'b0}] <= i_pxlData[7:0];
                	color_array[i_pxlAddr[14:8]][{i_pxlAddr[6:1],1'b1}] <= i_pxlData[15:8];
                end
                2'b10: begin
                    color_array[i_pxlAddr[14:8]][{i_pxlAddr[6:2],2'b00}] <= i_pxlData[7:0];
                	color_array[i_pxlAddr[14:8]][{i_pxlAddr[6:2],2'b01}] <= i_pxlData[15:8];
                	color_array[i_pxlAddr[14:8]][{i_pxlAddr[6:2],2'b10}] <= i_pxlData[23:16];
                	color_array[i_pxlAddr[14:8]][{i_pxlAddr[6:2],2'b11}] <= i_pxlData[31:24];
                end
                default: begin
                    //nothing
                end
            endcase
        end
    end

    // Color Read
    always_ff @(posedge i_vga_clk) begin
    	o_value <= (i_pxlX[0])?color_array[i_pxlY[6:0]][i_pxlX[7:1]][7:4]:
    						   color_array[i_pxlY[6:0]][i_pxlX[7:1]][3:0];
    end

endmodule
