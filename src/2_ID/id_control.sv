module id_control (
    i_instr,
    o_rdReg1, o_rdReg2,
    o_ctrlEX, o_ctrlMEM, o_ctrlWB
);
    input logic [31:0] i_instr;
    output logic [4:0] o_rdReg1;
    output logic [4:0] o_rdReg2;
    output logic [12:0] o_ctrlEX;       // ALUop(2), ALUSrc, func3, func7
    output logic [2:0] o_ctrlMEM;       // Branch, Mem-Read, mem-Write
    output logic [6:0] o_ctrlWB;        // Reg-Write, Memto-Reg, Write Register

    always_comb begin
        unique case (i_instr[6:0])
            7'b0110011: begin
                // R-Type Instruction (OP)
                // Register Reads
                o_rdReg1[4:0] = i_instr[19:15];
                o_rdReg2[4:0] = i_instr[24:20];
                // EX Control
                o_ctrlEX[12:11] = 2'b10;
                o_ctrlEX[10] = 1'b0;
                o_ctrlEX[9:7] = i_instr[14:12];
                o_ctrlEX[6:0] = i_instr[31:25];
                // MEM Control
                o_ctrlMEM[2:0] = 3'b000;
                // WB Control
                o_ctrlWB[6:5] = 2'b10;
                o_ctrlWB[4:0] = i_instr[11:7];
            end

            7'b0010011: begin
                // I-Type Instruction (OP IMM)
                // Register Reads
                o_rdReg1[4:0] = i_instr[19:15];
                o_rdReg2[4:0] = 5'b00000;
                // EX Control
                o_ctrlEX[12:11] = 2'b10;
                o_ctrlEX[10] = 1'b1;
                o_ctrlEX[9:7] = i_instr[14:12];
                o_ctrlEX[6:0] = 7'b000_0000;
                // MEM Control
                o_ctrlMEM[2:0] = 3'b000;
                // WB Control
                o_ctrlWB[6:5] = 2'b10;
                o_ctrlWB[4:0] = i_instr[11:7];
            end

            7'b0000011: begin
                // I-Type Instruction (LOAD)
                // Register Reads
                o_rdReg1[4:0] = i_instr[19:15];
                o_rdReg2[4:0] = 5'b00000;
                // EX Control
                o_ctrlEX[12:11] = 2'b00;
                o_ctrlEX[10] = 1'b1;
                o_ctrlEX[9:7] = i_instr[14:12];
                o_ctrlEX[6:0] = 7'b000_0000;
                // MEM Control
                o_ctrlMEM[2:0] = 3'b010;
                // WB Control
                o_ctrlWB[6:5] = 2'b11;
                o_ctrlWB[4:0] = i_instr[11:7];
            end

            7'b0100011: begin
                // S-Type Instruction (STORE)
                // Register Reads
                o_rdReg1[4:0] = i_instr[19:15];
                o_rdReg2[4:0] = i_instr[24:20];
                // EX Control
                o_ctrlEX[12:11] = 2'b00;
                o_ctrlEX[10] = 1'b1;
                o_ctrlEX[9:7] = i_instr[14:12];
                o_ctrlEX[6:0] = 7'b000_0000;
                // MEM Control
                o_ctrlMEM[2:0] = 3'b001;
                // WB Control
                o_ctrlWB[6:5] = 2'b00;
                o_ctrlWB[4:0] = 5'b00000;
            end

            7'b01100011: begin
                // B-Type Instruction (Branch)
                // Register Reads
                o_rdReg1[4:0] = i_instr[19:15];
                o_rdReg2[4:0] = i_instr[24:20];
                // EX Control
                o_ctrlEX[12:11] = 2'b01;
                o_ctrlEX[10] = 1'b0;
                o_ctrlEX[9:7] = i_instr[14:12];
                o_ctrlEX[6:0] = 7'b000_0000;
                // MEM Control
                o_ctrlMEM[2:0] = 3'b100;
                // WB Control
                o_ctrlWB[6:5] = 2'b00;
                o_ctrlWB[4:0] = 5'b00000;
            end

            7'b0110111: begin
                // U-Type Instruction (LUI)
                // Register Reads
                o_rdReg1[4:0] = 5'b00000;
                o_rdReg2[4:0] = 5'b00000;
                // EX Control
                o_ctrlEX[12:11] = 2'b00;
                o_ctrlEX[10] = 1'b1;
                o_ctrlEX[9:7] = 3'b000;
                o_ctrlEX[6:0] = 7'b000_0000;
                // MEM Control
                o_ctrlMEM[2:0] = 3'b000;
                // WB Control
                o_ctrlWB[6:5] = 2'b10;
                o_ctrlWB[4:0] = i_instr[11:7];
            end

            default: begin
                // R-Type Instruction (NOP)
                // Register Reads
                o_rdReg1[4:0] = 5'b00000;
                o_rdReg2[4:0] = 5'b00000;
                // EX Control
                o_ctrlEX[12:11] = 2'b10;
                o_ctrlEX[10] = 1'b0;
                o_ctrlEX[9:7] = i_instr[14:12];
                o_ctrlEX[6:0] = i_instr[31:25];
                // MEM Control
                o_ctrlMEM[2:0] = 3'b000;
                // WB Control
                o_ctrlWB[6:5] = 2'b00;
                o_ctrlWB[4:0] = 5'b00000;
            end
        endcase
    end


endmodule : id_control
