module testBench
    (
    wb,
    outAddr,
    resultALU,
    readData
    );

    reg clk;
    reg reset_n;
    reg hit_reset;

    logic PCSrc;
    logic [31:0] inAddr;
    logic [31:0] instruction;
    logic [31:0] immediate;
    logic [31:0] regData1;
    logic [31:0] regData2;
    logic zero;
    output logic [31:0] readData;
    logic [31:0] wrData;
    logic [12:0] ex;
    logic [2:0] mem;
    output logic [6:0] wb;
    output logic [31:0] outAddr;
    output logic [31:0] resultALU;

    logic clk_if;
    logic clk_id;
    logic clk_mem;




    initial
     begin
        clk = 0;
        reset_n = 0;
        hit_reset = 0;
     end

    always
     begin
        #5 clk <= ~clk;
     end

    always @(posedge clk)
    begin
        if(hit_reset === 1'b1) begin
            reset_n <= 0;
        end
        else begin
            reset_n <= 1;
        end
    end

    // always
    // begin
    //     b[15:0] = instruction[31:16] | instruction[15:0] | immediate[31:16] | immediate[15:0];
    //     c_o[15:8] = c_i[7:0];
    //     c_o[7:0] = c_i[15:8];
    // end

    initial
     begin
         $display("[%0t] Tracing to dump.vcd...\n",$time);
         $dumpfile("dump.vcd");
         $dumpvars();
         $display("[%0t] Model running...\n",$time);
     end

    initial
     begin
         #3000 $dumpflush;
         $finish;
     end

    top top_instance
        (
            .clk        (clk),
            .reset_n    (reset_n)
        );

    // top_clk CLK_GEN
    //     (
    //         .i_clk      (clk),
    //         .i_reset_n  (reset_n),
    //         .o_clk_if   (clk_if),
    //         .o_clk_id   (clk_id),
    //         .o_clk_mem  (clk_mem)
    //     );

    // if_top IF
    //     (
    //         .i_clk        (clk_if),
    //         .i_reset_n    (reset_n),
    //         .i_PCSrc      (PCSrc),
    //         .i_inAddr     (outAddr),
    //         .o_outAddr    (inAddr),
    //         .o_instruction(instruction)
    //     );

    // id_top ID
    //     (
    //         .i_clk          (clk_id),
    //         .i_reset_n      (reset_n),
    //         .i_instr        (instruction),
    //         .i_wrSig        (wb[6]),
    //         .i_wrReg        (wb[4:0]),
    //         .i_wrData       (wrData),
    //         .o_rdData1      (regData1),
    //         .o_rdData2      (regData2),
    //         .o_immediate    (immediate),
    //         .o_ctrlEX       (ex),
    //         .o_ctrlMEM      (mem),
    //         .o_ctrlWB       (wb)
    //     );

    // ex_top EX
    //     (
    //         .i_inAddr       (inAddr),
    //         .i_regData1    (regData1),
    //         .i_regData2    (regData2),
    //         .i_immediate   (immediate),
    //         .i_ctrlEX      (ex),
    //         .o_outAddr     (outAddr),
    //         .o_zero        (zero),
    //         .o_resultALU   (resultALU)
    //     );

    // mem_top MEM
    //     (
    //         .i_clk        (clk_mem),
    //         .i_reset_n    (reset_n),
    //         .i_memAddr    (resultALU),
    //         .i_wrData     (regData2),
    //         .i_ctrlMEM    (mem),
    //         .i_zero       (zero),
    //         .o_readData   (readData),
    //         .o_PCSrc      (PCSrc)
    //     );

    // wb_top WB
    //     (
    //         .i_ctrlWB     (wb[5]),
    //         .i_readData   (readData),
    //         .i_resultALU  (resultALU),
    //         .o_wrData     (wrData)
    //     );




endmodule
