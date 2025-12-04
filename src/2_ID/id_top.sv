module id_top (
        i_clk, i_reset_n, i_instr, i_wrSig, i_wrReg, i_wrData,
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
    output logic [31:0] o_rdData1;
    output logic [31:0] o_rdData2;
    output logic [31:0] o_immediate;
    output logic [12:0] o_ctrlEX;       // ALUop(2), func3, func7
    output logic [2:0] o_ctrlMEM;       // Branch, Mem-Read, mem-Write
    output logic [6:0] o_ctrlWB;        // Reg-Write, Memto-Reg

    // Internal wires
    logic [4:0] w_rdReg1;
    logic [4:0] w_rdReg2;

    id_control Ctrl (
        .i_instr (i_instr),
        .o_rdReg1 (w_rdReg1),
        .o_rdReg2 (w_rdReg2),
        .o_ctrlEX (o_ctrlEX),
        .o_ctrlMEM (o_ctrlMEM),
        .o_ctrlWB (o_ctrlWB)
    );
    id_immGen ImmGen (
        .i_instr(i_instr),
        .o_imm  (o_immediate)
    );
    id_reg Reg (
        .i_clk    (i_clk),
        .i_reset_n(i_reset_n),
        .i_rdReg1 (w_rdReg1),
        .i_rdReg2 (w_rdReg2),
        .i_wrSig  (i_wrSig),
        .i_wrReg  (i_wrReg),
        .i_wrData (i_wrData),
        .o_rdData1(o_rdData1),
        .o_rdData2(o_rdData2)
    );


endmodule : id_top
