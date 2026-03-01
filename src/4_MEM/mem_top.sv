module mem_top (
    i_clk, i_reset_n,
    i_memAddr, i_if_instrAddr, i_wrData, i_ctrlMEM, i_zero,
    en_IF, en_MEM, en_WB,
    o_readData, o_if_instr, o_PCSrc
);
    // I/O
    input logic i_clk;
    input logic i_reset_n;
    input logic [31:0] i_memAddr;
    input logic [31:0] i_if_instrAddr;
    input logic [31:0] i_wrData;
    input mem_ctrl_t i_ctrlMEM;
    input logic i_zero;

    input logic en_IF;
    input logic en_MEM;
    input logic en_WB; // for mem logging

    output logic [31:0] o_readData;
    output logic [31:0] o_if_instr;
    output logic o_PCSrc;

    //Stagin
    logic oB_PCSrc;

    mem_memory #(
        .INIT_FILENAME("test_rv32i.bin")
    ) Memory (
        .i_clk       (i_clk),
        .i_reset_n   (1),
        .i_memAddr   (i_memAddr),
        .i_instrAddr (i_if_instrAddr),
        .i_writeData (i_wrData),
        .i_ctrlMEM   (i_ctrlMEM),
        .en_IF      (en_IF),
        .en_MEM     (en_MEM),
        .en_WB      (en_WB),
        .o_readData  (o_readData),
        .o_instr      (o_if_instr)
    );

    // Combinational Logic
    always_comb begin
        // Conditional Branch
        oB_PCSrc = (i_ctrlMEM.Branch & i_zero) | (i_ctrlMEM.Jump);
    end

    // Output Buffering
    always_ff @(posedge i_clk) begin
        if(~i_reset_n) begin
            o_PCSrc <= 0;
        end else begin
            if (en_MEM) begin
                o_PCSrc <= oB_PCSrc;
            end
        end
    end



endmodule : mem_top
