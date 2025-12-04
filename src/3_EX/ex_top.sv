module ex_top (
    i_inAddr, i_regData1, i_regData2, i_immediate, i_ctrlEX,
    o_outAddr, o_zero, o_resultALU
);
    // I/O
    input logic [31:0] i_inAddr;
    input logic [31:0] i_regData1;
    input logic [31:0] i_regData2;
    input logic [31:0] i_immediate;
    input logic [12:0] i_ctrlEX;
    output logic [31:0] o_outAddr;
    output logic o_zero;
    output logic [31:0] o_resultALU;

    // Internal Wires
    logic [31:0] w_A;
    logic [31:0] w_B;
    logic [31:0] w_addrOffset;

    // ALU
    ex_alu ALU (
        .i_A       (w_A),
        .i_B       (w_B),
        .i_ctrlALU ({i_ctrlEX[12:11],i_ctrlEX[9:0]}),
        .o_result  (o_resultALU),
        .o_zero    (o_zero)
    );

    // Combinational Logic
    always_comb begin
        // Address Compute
        if(i_immediate[12] == 1) begin
            w_addrOffset[12:0] = i_immediate[12:0];
            w_addrOffset[31:13] = 19'b1111111111111111111;
        end else begin
            w_addrOffset = i_immediate;
        end
        o_outAddr = i_inAddr + w_addrOffset;

        // ALU Src
        w_A = i_regData1;
        if(i_ctrlEX[10] == 0) begin
            w_B = i_regData2;
        end else begin
            w_B = i_immediate;
        end

    end

endmodule : ex_top
