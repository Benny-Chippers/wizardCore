module if_top (i_clk, i_reset_n, i_PCSrc, i_inAddr, i_mem_instr,
                en_WB,
                o_outAddr, o_instruction, o_mem_instrAddr);
    // I/O
    input logic i_clk;
    input logic i_reset_n;
    input logic i_PCSrc;
    input logic [31:0] i_inAddr;
    input logic [31:0] i_mem_instr;
    input logic en_WB;
    output logic [31:0] o_outAddr;
    output logic [31:0] o_instruction;
    output logic [31:0] o_mem_instrAddr;


    // Internal wires
    logic [31:0] PCin;
    logic [31:0] PCout;

    // /////////////////////
    // // Program Counter //
    // /////////////////////
    // Uses write back signal to identify end of previous instruction
    always_ff @(posedge i_clk) begin
        if(~i_reset_n) begin
            PCout <= 0;
        end else begin
            if(en_WB) begin
                PCout <= PCin;
            end
        end
    end

    ////////////////////////
    // Instruction Memory //
    ////////////////////////
    // to let PCout propagate,takes PCout at clk falling edge
    // insturction fetch starts then and outputs to o_instruction[31:0]
    // Data Path buffering is in MEM block at instruction mem stage
    if_instrMem IM
        (
            .i_clk    (i_clk),
            .i_addr   (PCout),
            .i_mem_instr (i_mem_instr),
            .o_instr  (o_instruction),
            .o_mem_instrAddr (o_mem_instrAddr)
        );

    /////////////////////
    //  Internal Logic //
    /////////////////////
    // assign to connect PCout and o_outAddr
    // MUX switches between internal incrementing or outside address computation
    always_comb
    begin
        o_outAddr = PCout;

        // MUX
        if (i_PCSrc == 0) begin
            PCin = PCout + 4;
        end else begin
            PCin = i_inAddr;
        end
    end

endmodule : if_top
