module ex_alu (
    i_A, i_B, i_ctrlALU,
    o_result, o_zero
);
    // I/O
    input logic [31:0] i_A;
    input logic [31:0] i_B;
    input alu_ctrl_t i_ctrlALU; //ALU OP(2), Func3(3), Func7(7)
    output logic [31:0] o_result;
    output logic o_zero;


    // Combinational Logic
    always_comb begin
        case (i_ctrlALU.aluOp)
            2'b00:      // Load/Store
                o_result = i_A + i_B;
            2'b01:      // Branch
            begin
                case (i_ctrlALU.func3)
                    3'b000: o_zero = (i_A == i_B);  // BEQ
                    3'b001: o_zero = (i_A != i_B);  // BNE
                    3'b100: o_zero = ($signed(i_A) < $signed(i_B));  // BLT
                    3'b101: o_zero = ($signed(i_A) >= $signed(i_B)); // BGE
                    3'b110: o_zero = (i_A < i_B);    // BLTU
                    3'b111: o_zero = (i_A >= i_B);   // BGEU
                    default:
                        o_zero = 1'b0;
                endcase
                o_result = i_A - i_B;
            end
            2'b10:      // OP instruction
            begin
                case (i_ctrlALU.func3)
                    3'b000:   // ADD / SUB
                        case (i_ctrlALU[6:0])
                            7'b000_0000: o_result = i_A + i_B;    // ADD
                            7'b010_0000: o_result = i_A - i_B;    // SUB
                            default : o_result = 32'b0;
                        endcase
                    3'b001:   // SLL
                        o_result = i_A << i_B[4:0];
                    3'b010:   // SLT
                        if( $signed(i_A) < $signed(i_B) ) begin
                            o_result = 32'd1;
                        end else begin
                            o_result = 32'b0;
                        end
                    3'b011:
                        if( i_A < i_B ) begin
                            o_result = 32'd1;
                        end else begin
                            o_result = 32'b0;
                        end
                    3'b100:   // XOR
                        o_result = i_A ^ i_B;
                    3'b101:   // SRL / SRA
                        case (i_ctrlALU.func7)
                            7'b000_0000: o_result = i_A >> i_B[4:0];    // SRL
                            7'b010_0000: o_result = $signed(i_A) >>> i_B[4:0]; // SRA
                            default : o_result = 32'b0;
                        endcase
                    3'b110:   // OR
                        o_result = i_A | i_B;
                    3'b111:   // AND
                        o_result = i_A & i_B;
                    default : o_result = 32'b0;
                endcase
            end
            default : o_result = 32'b0;
        endcase
        // Zero Flag
        if(i_ctrlALU.aluOp != 2'b01) begin
            if(o_result == 32'b0) begin
                o_zero = 1'b1;
            end else begin
                o_zero = 1'b0;
            end
        end
    end

endmodule : ex_alu
