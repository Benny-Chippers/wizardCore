module mem_top (
    i_clk, i_reset_n,
    i_memAddr, i_wrData, i_ctrlMEM, i_zero,
    o_readData, o_PCSrc
);
    // I/O
    input logic i_clk;
    input logic i_reset_n;
    input logic [31:0] i_memAddr;
    input logic [31:0] i_wrData;
    input logic [2:0] i_ctrlMEM;
    input logic i_zero;
    output logic [31:0] o_readData;
    output logic o_PCSrc;

    // Memory
    mem_memory Memory (
        .i_clk       (i_clk),
        .i_reset_n   (i_reset_n),
        .i_memAddr   (i_memAddr),
        .i_writeData (i_wrData),
        .i_ctrlMEM   (i_ctrlMEM[1:0]),
        .o_readData  (o_readData)
    );

    // Combinational Logic
    always_comb begin
        // Conditional Branch
        o_PCSrc = i_ctrlMEM[2] & i_zero;
    end



endmodule : mem_top
