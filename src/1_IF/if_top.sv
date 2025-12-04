module if_top (i_clk, i_reset_n, i_PCSrc, i_inAddr, o_outAddr, o_instruction);
    // I/O
    input logic i_clk;
    input logic i_reset_n;
    input logic i_PCSrc;
    input logic [31:0] i_inAddr;
    output logic [31:0] o_outAddr;
    output logic [31:0] o_instruction;

    // Internal wires
    logic [31:0] PCin;
    logic [31:0] PCout;

    /////////////////////
    // Program Counter //
    /////////////////////
    // resets to zero i_reset_n falling edge
    // latches PCin address on clk rising edge
    // outputs to PCout
    d_ff32 PC
        (
            .clk    (i_clk),
            .reset_n(i_reset_n),
            .d      (PCin),
            .q      (PCout)
        );

    ////////////////////////
    // Instruction Memory //
    ////////////////////////
    // to let PCout propagate,takes PCout at clk falling edge
    // insturction fetch starts then and outputs to o_instruction[31:0]
    if_instrMem IM
        (
            .i_clk    (i_clk),
            .i_addr   (PCout),
            .o_instr  (o_instruction)
        );

    /////////////////////
    //  Internal Logic //
    /////////////////////
    // assign to connect PCout and o_outAddr
    // MUX switches between internal incrementing or outside address computation
    always begin
        o_outAddr = PCout;

        // MUX
        if (i_PCSrc == 0) begin
            PCin = PCout + 4;
        end else begin
            PCin = i_inAddr;
        end
    end

endmodule : if_top
