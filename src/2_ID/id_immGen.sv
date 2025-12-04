module id_immGen (
    i_instr,
    o_imm
);
    // I/O
    input logic [31:0] i_instr;
    output logic [31:0] o_imm;

    always_comb begin
        unique case (i_instr[6:0])
            7'b0010011: begin
                // I-Type Instruction (OP IMM)
                o_imm = {20'b0, i_instr[31:20]};

            end

            7'b0000011: begin
                // I-Type Instruction (LOAD)
                o_imm = {20'b0, i_instr[31:20]};

            end

            7'b0100011: begin
                // S-Type Instruction (STORE)
                o_imm = {20'b0, i_instr[31:25], i_instr[11:7]};

            end

            7'b01100011: begin
                // B-Type Instruction (Branch)
                o_imm = {19'b0, i_instr[31], i_instr[7], i_instr[30:25], i_instr[11:8], 1'b0};

            end

            default: begin
                // R-Type Instruction (NOP)
                if(i_instr[0] == 1) begin
                    o_imm = 32'b0;
                end else begin
                    o_imm = i_instr;
                end

            end
        endcase
    end

endmodule : id_immGen
