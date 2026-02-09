module mem_top (
    i_clk, i_clk_if, i_reset_n,
    i_memAddr, i_if_instrAddr, i_wrData, i_ctrlMEM, i_zero,
    o_readData, o_if_instr, o_PCSrc,
    mem_addr, mem_data
);
    // I/O
    input logic i_clk;
    input logic i_clk_if;
    input logic i_reset_n;
    input logic [31:0] i_memAddr;
    input logic [31:0] i_if_instrAddr;
    input logic [31:0] i_wrData;
    input mem_ctrl_t i_ctrlMEM;
    input logic i_zero;
    output logic [31:0] o_readData;
    output logic [31:0] o_if_instr;
    output logic o_PCSrc;


    // Simulation Memory
    `ifdef SIMULATION
    mem_memory Memory (
        .i_clk       (i_clk),
        .i_clk_if    (i_clk_if),
        .i_reset_n   (1),
        .i_memAddr   (i_memAddr),
        .i_instrAddr (i_if_instrAddr),
        .i_writeData (i_wrData),
        .i_ctrlMEM   (i_ctrlMEM),
        .o_readData  (o_readData),
        .o_instr      (o_if_instr)
    );
    `endif

    // Real Memory
    `ifndef SIMULATION

    `endif

    // Combinational Logic
    always_comb begin
        // Conditional Branch
        o_PCSrc = (i_ctrlMEM.Branch & i_zero) | (i_ctrlMEM.Jump);
    end



endmodule : mem_top
