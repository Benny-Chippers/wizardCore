module ex_top (
    i_inAddr, i_regData1, i_regData2, i_immediate, i_ctrlEX,
    o_outAddr, o_zero, o_resultALU
);
    // I/O
    input logic [31:0] i_inAddr;
    input logic [31:0] i_regData1;
    input logic [31:0] i_regData2;
    input logic [31:0] i_immediate;
    input logic [13:0] i_ctrlEX;
    output logic [31:0] o_outAddr;
    output logic o_zero;
    output logic [31:0] o_resultALU;

    // Internal Wires
    logic [31:0] w_A;
    logic [31:0] w_B;
    logic w_zero;

    // ALU
    ex_alu ALU (
        .i_A       (w_A),
        .i_B       (w_B),
        .i_ctrlALU ({i_ctrlEX[13:12],i_ctrlEX[9:0]}),
        .o_result  (o_resultALU),
        .o_zero    (w_zero)
    );

    // Combinational Logic
    always_comb begin
        // PC + Immediate
        o_outAddr = i_inAddr + i_immediate;

        // ALU Src, Force PC change
        if(i_ctrlEX[11] == 0) begin
            w_A = i_regData1;
            o_zero = w_zero;

            if(i_ctrlEX[10] == 0) begin
                w_B = i_regData2;   // R-Type
            end else begin
                w_B = i_immediate;  // I-Type
            end
        end else begin
            w_A = i_inAddr;
            o_zero = 1'b1;

            if(i_ctrlEX[10] == 0) begin
                w_B = 32'd4;        // JAL, JALR
            end else begin
                w_B = i_immediate;  // AUIPC
            end
        end


    end

endmodule : ex_top
