module id_control (
    i_instr,
    o_rdReg1, o_rdReg2,
    o_ctrlEX, o_ctrlMEM, o_ctrlWB
);
    input logic [31:0] i_instr;
    output logic [4:0] o_rdReg1;
    output logic [4:0] o_rdReg2;
    output ex_ctrl_t o_ctrlEX;
    output mem_ctrl_t o_ctrlMEM;       // Jump, Branch, Mem-Read, mem-Write
    output wb_ctrl_t o_ctrlWB;        // Reg-Write, Memto-Reg, Write Register

    always_comb begin
        unique case (i_instr[6:0])
            7'b0110011: begin
                // R-Type Instruction (OP)
                // Register Reads
                o_rdReg1[4:0] = `RS1;
                o_rdReg2[4:0] = `RS2;
                // EX Control
                o_ctrlEX.aluOp = 2'b10;
                o_ctrlEX.aluSrc = 2'b00;
                o_ctrlEX.func3 = `FUNCT3;
                o_ctrlEX.func7 = `FUNCT7;
                // MEM Control
                o_ctrlMEM[3:0] = 4'b0000;
                // WB Control
                o_ctrlWB[6:5] = 2'b10;
                o_ctrlWB.writeReg = `RD;
            end

            7'b0010011: begin
                if(`FUNCT3 == 3'b101 || `FUNCT3 == 3'b001) begin
                    // I-Type Instruction (SLLI, SRLI, SRAI)
                    // Register Reads
                    o_rdReg1[4:0] = `RS1;
                    o_rdReg2[4:0] = 5'b00000;
                    // EX Control
                    o_ctrlEX.aluOp = 2'b10;
                    o_ctrlEX.aluSrc = 2'b01;
                    o_ctrlEX.func3 = `FUNCT3;
                    o_ctrlEX.func7 = `FUNCT7;
                    // MEM Control
                    o_ctrlMEM[3:0] = 4'b0000;
                    // WB Control
                    o_ctrlWB[6:5] = 2'b10;
                    o_ctrlWB.writeReg = `RD;
                end else begin
                    // I-Type Instruction (OP IMM)
                    // Register Reads
                    o_rdReg1[4:0] = `RS1;
                    o_rdReg2[4:0] = 5'b00000;
                    // EX Control
                    o_ctrlEX.aluOp = 2'b10;
                    o_ctrlEX.aluSrc = 2'b01;
                    o_ctrlEX.func3 = `FUNCT3;
                    o_ctrlEX.func7 = 7'b000_0000;
                    // MEM Control
                    o_ctrlMEM[3:0] = 4'b0000;
                    // WB Control
                    o_ctrlWB[6:5] = 2'b10;
                    o_ctrlWB.writeReg = `RD;
                end
            end

            7'b0000011: begin
                // I-Type Instruction (LOAD)
                // Register Reads
                o_rdReg1[4:0] = `RS1;
                o_rdReg2[4:0] = 5'b00000;
                // EX Control
                o_ctrlEX.aluOp = 2'b00;
                o_ctrlEX.aluSrc = 2'b01;
                o_ctrlEX.func3 = `FUNCT3;
                o_ctrlEX.func7 = 7'b000_0000;
                // MEM Control
                o_ctrlMEM[3:0] = 4'b0010;
                // WB Control
                o_ctrlWB[6:5] = 2'b11;
                o_ctrlWB.writeReg = `RD;
            end

            7'b1100111: begin
                // I-Type Instruction (JALR)
                // Register Reads
                o_rdReg1[4:0] = `RS1;
                o_rdReg2[4:0] = 5'b00000;
                // EX Control
                o_ctrlEX.aluOp = 2'b00;
                o_ctrlEX.aluSrc = 2'b10;
                o_ctrlEX.func3 = `FUNCT3;
                o_ctrlEX.func7 = 7'b000_0000;
                // MEM Control
                o_ctrlMEM[3:0] = 4'b1100;
                // WB Control
                o_ctrlWB[6:5] = 2'b10;
                o_ctrlWB.writeReg = `RD;
            end

            7'b0100011: begin
                // S-Type Instruction (STORE)
                // Register Reads
                o_rdReg1[4:0] = `RS1;
                o_rdReg2[4:0] = `RS2;
                // EX Control
                o_ctrlEX.aluOp = 2'b00;
                o_ctrlEX.aluSrc = 2'b01;
                o_ctrlEX.func3 = `FUNCT3;
                o_ctrlEX.func7 = 7'b000_0000;
                // MEM Control
                o_ctrlMEM[3:0] = 4'b0001;
                // WB Control
                o_ctrlWB[6:5] = 2'b00;
                o_ctrlWB.writeReg = 5'b00000;
            end

            7'b01100011: begin
                // B-Type Instruction (Branch)
                // Register Reads
                o_rdReg1[4:0] = `RS1;
                o_rdReg2[4:0] = `RS2;
                // EX Control
                o_ctrlEX.aluOp = 2'b01;
                o_ctrlEX.aluSrc = 2'b00;
                o_ctrlEX.func3 = `FUNCT3;
                o_ctrlEX.func7 = 7'b000_0000;
                // MEM Control
                o_ctrlMEM[3:0] = 4'b0100;
                // WB Control
                o_ctrlWB[6:5] = 2'b00;
                o_ctrlWB.writeReg = 5'b00000;
            end

            7'b0110111: begin
                // U-Type Instruction (LUI)
                // Register Reads
                o_rdReg1[4:0] = 5'b00000;
                o_rdReg2[4:0] = 5'b00000;
                // EX Control
                o_ctrlEX.aluOp = 2'b00;
                o_ctrlEX.aluSrc = 2'b01;
                o_ctrlEX.func3 = 3'b000;
                o_ctrlEX.func7 = 7'b000_0000;
                // MEM Control
                o_ctrlMEM[3:0] = 4'b0000;
                // WB Control
                o_ctrlWB[6:5] = 2'b10;
                o_ctrlWB.writeReg = `RD;
            end

            7'b0010111: begin
                // U-Type Instruction (AUIPC)
                // Register Reads
                o_rdReg1[4:0] = 5'b00000;
                o_rdReg2[4:0] = 5'b00000;
                // EX Control
                o_ctrlEX.aluOp = 2'b00;
                o_ctrlEX.aluSrc = 2'b11;
                o_ctrlEX.func3 = 3'b000;
                o_ctrlEX.func7 = 7'b000_0000;
                // MEM Control
                o_ctrlMEM[3:0] = 4'b0000;
                // WB Control
                o_ctrlWB[6:5] = 2'b10;
                o_ctrlWB.writeReg = `RD;
            end

            7'b1101111: begin
                // J-Type Instruction (JAL)
                // Register Reads
                o_rdReg1[4:0] = 5'b00000;
                o_rdReg2[4:0] = 5'b00000;
                // EX Control
                o_ctrlEX.aluOp = 2'b00;
                o_ctrlEX.aluSrc = 2'b10;
                o_ctrlEX.func3 = 3'b000;
                o_ctrlEX.func7 = 7'b000_0000;
                // MEM Control
                o_ctrlMEM[3:0] = 4'b1000;
                // WB Control
                o_ctrlWB[6:5] = 2'b10;
                o_ctrlWB.writeReg = `RD;
            end

            default: begin
                // R-Type Instruction (NOP)
                // Register Reads
                o_rdReg1[4:0] = 5'b00000;
                o_rdReg2[4:0] = 5'b00000;
                // EX Control
                o_ctrlEX.aluOp = 2'b10;
                o_ctrlEX.aluSrc = 2'b00;
                o_ctrlEX.func3 = `FUNCT3;
                o_ctrlEX.func7 = `FUNCT7;
                // MEM Control
                o_ctrlMEM[3:0] = 4'b0000;
                // WB Control
                o_ctrlWB[6:5] = 2'b00;
                o_ctrlWB.writeReg = 5'b00000;
            end
        endcase
    end


endmodule : id_control
