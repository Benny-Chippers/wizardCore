//(* keep_hierarchy = "yes" *)
//(* max_fanout = 20 *)
module top (
    (* max_fanout = 20 *)
    input clk,      // Clock
    input vga_clk,  // Clock for vga circuit
    input reset_n_out,  // Asynchronous reset active low
    output vga_out_t vgaData
);

    // Internal signals
    logic PCSrc;
    logic [31:0] mem_instr;
    logic [31:0] mem_instrAddr;

    logic [31:0] inAddr;
    logic [31:0] instruction;
    logic [31:0] immediate;
    logic [31:0] regData1;
    logic [31:0] regData2;

    logic zero;
    logic [31:0] wrData;
    logic [31:0] outAddr;

    logic [31:0] resultALU;
    logic [31:0] readData;

    // Control Signals
    ex_ctrl_t ex;
    wb_ctrl_t wb;

    // Memory Routing Signals
    mem_ctrl_t mem;
    mem_ctrl_t ctrlMEM;
    mem_ctrl_t ctrlVGA;


    // Clocking
    (* max_fanout = 20 *)
    reg en_IF, en_ID, en_EX, en_MEM, en_WB;

    logic clk_if;
    logic clk_id;
    logic clk_mem;

    logic reset_n;
    always @(posedge clk) begin
        reset_n <= reset_n_out;
    end


    top_clk CLK_GEN
        (
            .i_clk      (clk),
            .i_reset_n  (reset_n),
            .o_clk_if   (clk_if),
            .o_clk_id   (clk_id),
            .o_clk_mem  (clk_mem)
        );

    top_en enable
        (
            .i_clk    	(clk),
            .i_reset_n	(reset_n),
            .o_en_IF  	(en_IF),
            .o_en_ID  	(en_ID),
            .o_en_EX  	(en_EX),
            .o_en_MEM  	(en_MEM),
            .o_en_WB  	(en_WB)
        );

    if_top IF
        (
            .i_clk        		(clk),
            .i_reset_n    		(reset_n),
            .i_PCSrc      		(PCSrc),
            .i_inAddr     		(outAddr),
            .i_mem_instr  		(mem_instr),
            .en_WB        		(en_WB),
            .o_outAddr    		(inAddr),
            .o_instruction		(instruction),
            .o_mem_instrAddr	(mem_instrAddr)
        );

    id_top ID
        (
            .i_clk          (clk),
            .i_reset_n      (reset_n),
            .i_instr        (instruction),
            .i_wrSig        (wb.regWrite),
            .i_wrReg        (wb.writeReg),
            .i_wrData       (wrData),
            .en_ID 			(en_ID),
            .en_WB        	(en_WB),
            .o_rdData1      (regData1),
            .o_rdData2      (regData2),
            .o_immediate    (immediate),
            .o_ctrlEX       (ex),
            .o_ctrlMEM      (mem),
            .o_ctrlWB       (wb)
        );

    ex_top EX
        (
        	.i_clk		   	(clk),
        	.i_reset_n		(reset_n),
            .i_inAddr      	(inAddr),
            .i_regData1    	(regData1),
            .i_regData2    	(regData2),
            .i_immediate   	(immediate),
            .i_ctrlEX      	(ex),
            .i_ctrlMEM     	(mem),
            .en_EX      	(en_EX),
            .o_outAddr     	(outAddr),
            .o_zero        	(zero),
            .o_resultALU   	(resultALU),
            .o_ctrlMEM      (ctrlMEM),
            .o_ctrlVGA      (ctrlVGA)
        );

    mem_top MEM
        (
            .i_clk          (clk),
            .i_reset_n      (reset_n),
            .i_memAddr      (resultALU),
            .i_if_instrAddr (mem_instrAddr),
            .i_wrData       (regData2),
            .i_ctrlMEM      (ctrlMEM),
            .i_zero         (zero),
            .en_IF          (en_IF),
            .en_MEM         (en_MEM),
            .en_WB          (en_WB),
            .o_readData     (readData),
            .o_if_instr     (mem_instr),
            .o_PCSrc        (PCSrc)
        );

    wb_top WB
        (
            .i_ctrlWB     (wb.memToReg),
            .i_readData   (readData),
            .i_resultALU  (resultALU),
            .o_wrData     (wrData)
        );



    // VGA output circuit
    vga_top VGA
        (
            .i_clk          (clk),
            .i_vga_clk      (vga_clk),
            .i_reset_n      (reset_n),
            .i_pxlAddr      (resultALU),
            .i_pxlData      (regData2),
            .i_ctrlVGA      (ctrlVGA),
            .en_MEM   		(en_MEM),
            .o_vgaData      (vgaData)
        );

endmodule : top
