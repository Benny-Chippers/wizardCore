module ex_top (
    i_clk, i_reset_n,
    i_inAddr, i_regData1, i_regData2, i_immediate, i_ctrlEX, i_ctrlMEM,
    en_EX,
    o_outAddr, o_zero, o_resultALU
);
    // I/O
    input logic i_clk;
    input logic i_reset_n;
    input logic [31:0] i_inAddr;
    input logic [31:0] i_regData1;
    input logic [31:0] i_regData2;
    input logic [31:0] i_immediate;
    input ex_ctrl_t i_ctrlEX;
    input logic [1:0] i_ctrlMEM;

    input logic en_EX;

    output logic [31:0] o_outAddr;
    output logic o_zero;
    output logic [31:0] o_resultALU;

    // Internal Wires
    logic [31:0] w_A;
    logic [31:0] w_B;

    // Staging
    logic [31:0] oB_outAddr;
    logic oB_zero;
    logic [31:0] oB_resultALU;

    // ALU
    ex_alu ALU (
        .i_A       (w_A),
        .i_B       (w_B),
        .i_ctrlALU ({i_ctrlEX.aluOp,i_ctrlEX.func3,i_ctrlEX.func7}),
        .o_result  (oB_resultALU),
        .o_zero    (oB_zero)
    );

    // Combinational Logic
    always_comb begin
        // PC + Immediate (+ regData1 for JALR)
        if(i_ctrlMEM == 2'b11) begin
            oB_outAddr =  (i_regData1 + i_immediate) & ~1; // JALR
        end else begin
            oB_outAddr = i_inAddr + i_immediate;    // JAL, and branches
        end


        // ALU Src
        if(i_ctrlEX[11] == 0) begin
            w_A = i_regData1;

            if(i_ctrlEX[10] == 0) begin
                w_B = i_regData2;   // R-Type
            end else begin
                w_B = i_immediate;  // I-Type
            end
        end else begin
            w_A = i_inAddr;

            if(i_ctrlEX[10] == 0) begin
                w_B = 32'd4;        // JAL, JALR
            end else begin
                w_B = i_immediate;  // AUIPC
            end
        end
    end

    // Output Buffering
    always_ff @(posedge i_clk) begin
        if(~i_reset_n) begin
            o_outAddr <= 0;
            o_zero <= 0;
            o_resultALU <= 0;
        end else begin
            if (en_EX) begin
                o_outAddr <= oB_outAddr;
                o_zero <= oB_zero;
                o_resultALU <= oB_resultALU;
            end
        end
    end

endmodule : ex_top
