(* keep_hierarchy = "yes" *)
(* max_fanout = 20 *)
module top (
    input clk,    // Clock
    input reset_n,  // Asynchronous reset active low
    output logic [31:0] mem_addr,
    output logic [31:0] mem_data
);

    // Internal signals
    logic PCSrc;
    logic [31:0] inAddr;
    logic [31:0] instruction;
    logic [31:0] immediate;
    logic [31:0] regData1;
    logic [31:0] regData2;
    logic zero;
    logic [31:0] readData;
    logic [31:0] wrData;
    ex_ctrl_t ex;
    mem_ctrl_t mem;
    wb_ctrl_t wb;
    logic [31:0] outAddr;
    logic [31:0] resultALU;

    logic clk_if;
    logic clk_id;
    logic clk_mem;


    top_clk CLK_GEN
        (
            .i_clk      (clk),
            .i_reset_n  (reset_n),
            .o_clk_if   (clk_if),
            .o_clk_id   (clk_id),
            .o_clk_mem  (clk_mem)
        );

    if_top IF
        (
            .i_clk        (clk_if),
            .i_reset_n    (reset_n),
            .i_PCSrc      (PCSrc),
            .i_inAddr     (outAddr),
            .o_outAddr    (inAddr),
            .o_instruction(instruction)
        );

    id_top ID
        (
            .i_clk          (clk_id),
            .i_reset_n      (reset_n),
            .i_instr        (instruction),
            .i_wrSig        (wb.regWrite),
            .i_wrReg        (wb.writeReg),
            .i_wrData       (wrData),
            .o_rdData1      (regData1),
            .o_rdData2      (regData2),
            .o_immediate    (immediate),
            .o_ctrlEX       (ex),
            .o_ctrlMEM      (mem),
            .o_ctrlWB       (wb)
        );

    ex_top EX
        (
            .i_inAddr       (inAddr),
            .i_regData1    (regData1),
            .i_regData2    (regData2),
            .i_immediate   (immediate),
            .i_ctrlEX      (ex),
            .i_ctrlMEM     ({mem.Jump,mem.Branch}),
            .o_outAddr     (outAddr),
            .o_zero        (zero),
            .o_resultALU   (resultALU)
        );

    mem_top MEM
        (
            .i_clk        (clk_mem),
            .i_reset_n    (reset_n),
            .i_memAddr    (resultALU),
            .i_wrData     (regData2),
            .i_ctrlMEM    (mem),
            .i_zero       (zero),
            .o_readData   (readData),
            .o_PCSrc      (PCSrc),
            .mem_addr     (mem_addr),
            .mem_data     (mem_data)
        );

    wb_top WB
        (
            .i_ctrlWB     (wb.memToReg),
            .i_readData   (readData),
            .i_resultALU  (resultALU),
            .o_wrData     (wrData)
        );

endmodule : top
