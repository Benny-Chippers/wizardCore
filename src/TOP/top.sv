//(* keep_hierarchy = "yes" *)
//(* max_fanout = 20 *)
module top (
    `ifdef SIMULATION
    input logic clk,      // System/CPU Clock
    input logic vga_clk,  // Clock for vga circuit
    input logic spi_clk,
    `else
    input logic osc_clk,
    `endif
    input logic reset_n,  // Synchronous reset active low
    output macro_pkg::vga_out_t vgaData,
    inout wire [5:0] spi,
    inout wire [31:0] gpio
);

    `ifndef SIMULATION
    logic osc_reset_n;


    initial begin
        #0 osc_reset_n = 0;
        #50ns osc_reset_n = 1;
    end

    // VIVADO CLOCKING
    clk_wiz_0 instance_name
   (
        // Clock out ports
        .clk_cpu(clk),     // output clk_cpu
        .clk_vga(vga_clk),     // output clk_vga
        .clk_spi(spi_clk),     // output clk_spi
        // Status and control signals
        .resetn(osc_reset_n), // input resetn
       // Clock in ports
        .clk_in(osc_clk)      // input clk_in
    );
    `endif

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
    logic [31:0] readMEM;
    logic [31:0] readXMEM;
    logic [31:0] readSPCL;


    // Control Signals
    macro_pkg::ex_ctrl_t ex;
    macro_pkg::wb_ctrl_t wb;

    // Memory Routing Signals
    macro_pkg::mem_ctrl_t mem;
    macro_pkg::mem_ctrl_t ctrlMEM;
    macro_pkg::mem_ctrl_t ctrlXMEM;
    macro_pkg::mem_ctrl_t ctrlSPCL;
    macro_pkg::mem_ctrl_t ctrlVGA;


    // Clocking
    (* max_fanout = 20 *)
    logic en_IF, en_ID, en_EX, en_MEM, en_WB;
    logic stall_IF, stall_ID, stall_EX, stall_MEM, stall_WB;


    initial begin
        stall_IF = 0;
        stall_ID = 0;
        stall_EX = 0;
        stall_MEM = 0;
        stall_WB = 0;
    end


    top_en enable
        (
            .i_clk    	(clk),
            .i_reset_n	(reset_n),
            .stall_IF   (stall_IF),
            .stall_ID   (stall_ID),
            .stall_EX   (stall_EX),
            .stall_MEM  (stall_MEM),
            .stall_WB   (stall_WB),
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
            .stall_EX       (stall_EX),
            .o_outAddr     	(outAddr),
            .o_zero        	(zero),
            .o_resultALU   	(resultALU),
            .o_ctrlMEM      (ctrlMEM),
            .o_ctrlVGA      (ctrlVGA),
            .o_ctrlSPCL     (ctrlSPCL),
            .o_ctrlXMEM     (ctrlXMEM)
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
            .o_readData     (readMEM),
            .o_if_instr     (mem_instr),
            .o_PCSrc        (PCSrc)
        );

    xmem_top XMEM
        (
            .i_clk_cpu    (clk),
            .i_reset_n    (reset_n),
            .i_clk_spi    (spi_clk),
            .i_address    (resultALU),
            .i_dataWrite  (regData2),
            .i_mem_ctrl   (ctrlXMEM),
            .en_SPI       (en_MEM),
            .o_stall      (stall_MEM),
            .o_dataRead   (readXMEM),
            .o_clk_QSPI   (spi[5]),
            .o_select_QSPI(spi[4]),
            .o_MOSI       (spi[0]),
            .i_MISO       (spi[1]),
            .o_cmd_rdy    (spi[2]),
            .i_d_rdy      (spi[3])
        );

    special_top SPECIAL
        (
            .i_clk      (clk),
            .i_reset_n  (reset_n),
            .i_address  (resultALU),
            .i_dataWrite(regData2),
            .i_ctrlMEM  (ctrlSPCL),
            .en_SPC     (en_MEM),
            .o_dataRead (readSPCL),
            .io_gpio    (gpio)
        );

    always_comb begin
        if (ctrlMEM.memRead) begin
            readData = readMEM;
        end else if (ctrlXMEM.memRead) begin
            readData = readXMEM;
        end else if (ctrlSPCL.memRead) begin
            readData = readSPCL;
        end else begin
            readData = '0;
        end
    end

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

    wb_top WB
        (
            .i_ctrlWB     (wb.memToReg),
            .i_readData   (readData),
            .i_resultALU  (resultALU),
            .o_wrData     (wrData)
        );

endmodule : top
