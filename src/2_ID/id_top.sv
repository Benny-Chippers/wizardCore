module id_top (
        i_clk, i_reset_n, i_instr, i_wrSig, i_wrReg, i_wrData,
        en_ID, en_WB,
        o_rdData1, o_rdData2, o_immediate,
        o_ctrlEX, o_ctrlMEM, o_ctrlWB
    );

    // I/O
    input logic i_clk;
    input logic i_reset_n;
    input logic [31:0] i_instr;
    input logic i_wrSig;
    input logic [4:0] i_wrReg;
    input logic [31:0] i_wrData;

    input logic en_ID;
    input logic en_WB;

    output logic [31:0] o_rdData1;
    output logic [31:0] o_rdData2;
    output logic [31:0] o_immediate;
    output ex_ctrl_t o_ctrlEX;       // ALUop(2), ALU src(2), func3, func7
    output mem_ctrl_t o_ctrlMEM;       // Branch, Mem-Read, mem-Write
    output wb_ctrl_t o_ctrlWB;        // Reg-Write, Memto-Reg

    // Internal wires
    logic [4:0] w_rdReg1;
    logic [4:0] w_rdReg2;

    // Staging
    logic [31:0] oB_rdData1;
    logic [31:0] oB_rdData2;
    logic [31:0] oB_immediate;
    ex_ctrl_t oB_ctrlEX;       // ALUop(2), ALU src(2), func3, func7
    mem_ctrl_t oB_ctrlMEM;       // Branch, Mem-Read, mem-Write
    wb_ctrl_t oB_ctrlWB;        // Reg-Write, Memto-Reg

    id_control Ctrl (
        .i_instr (i_instr),
        .o_rdReg1 (w_rdReg1),
        .o_rdReg2 (w_rdReg2),
        .o_ctrlEX (oB_ctrlEX),
        .o_ctrlMEM (oB_ctrlMEM),
        .o_ctrlWB (oB_ctrlWB)
    );
    id_immGen ImmGen (
        .i_instr(i_instr),
        .o_imm  (oB_immediate)
    );
    id_reg Reg (
        .i_clk    (i_clk),
        .i_reset_n(i_reset_n),
        .i_rdReg1 (w_rdReg1),
        .i_rdReg2 (w_rdReg2),
        .i_wrSig  (i_wrSig),
        .i_wrReg  (i_wrReg),
        .i_wrData (i_wrData),
        .en_WB    (en_WB),
        .o_rdData1(oB_rdData1),
        .o_rdData2(oB_rdData2)
    );

    // Output Buffering
    always_ff @(posedge i_clk) begin
        if(~i_reset_n) begin
            o_rdData1 <= 0;
            o_rdData2 <= 0;
            o_immediate <= 0;
            o_ctrlEX <= 0;
            o_ctrlMEM <= 0;
            o_ctrlWB <= 0;
        end else begin
            if (en_ID) begin
                o_rdData1 <= oB_rdData1;
                o_rdData2 <= oB_rdData2;
                o_immediate <= oB_immediate;
                o_ctrlEX <= oB_ctrlEX;
                o_ctrlMEM <= oB_ctrlMEM;
                o_ctrlWB <= oB_ctrlWB;
            end
        end
    end


endmodule : id_top
