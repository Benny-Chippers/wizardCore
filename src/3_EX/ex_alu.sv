module ex_alu (
    i_A, i_B, i_ctrlALU,
    o_result, o_zero
);
    // I/O
    input logic [31:0] i_A;
    input logic [31:0] i_B;
    input logic [11:0] i_ctrlALU;
    output logic [31:0] o_result;
    output logic o_zero;


    // Combinational Logic
    always_comb begin
        case (i_ctrlALU[11:10])
            2'b00:      // Load/Store
                o_result = i_A + i_B;
            2'b01:      // Branch
                o_result = i_A - i_B;
            2'b10:      // OP instruction
                case (i_ctrlALU[9:7])
                    3'b000:   // ADD / SUB
                        case (i_ctrlALU[6:0])
                            7'b000_0000: o_result = i_A + i_B;    // ADD
                            7'b010_0000: o_result = i_A - i_B;    // SUB
                            default : o_result = 32'b0;
                        endcase
                    3'b001:   // SLL
                        o_result = i_A << i_B[4:0];
                    3'b110:   // OR
                        o_result = i_A | i_B;
                    3'b111:   // AND
                        o_result = i_A & i_B;
                    default : o_result = 32'b0;
                endcase
            default : o_result = 32'b0;
        endcase
        // Zero Flag
        if(o_result == 32'b0) begin
            o_zero = 1'b1;
        end else begin
            o_zero = 1'b0;
        end
    end

endmodule : ex_alu
