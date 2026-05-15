module ex_alu (
    // Input
    input logic [31:0] i_A,
    input logic [31:0] i_B,
    input macro_pkg::alu_ctrl_t i_ctrlALU,  //ALU OP(2), Func3(3), Func7(7)

    //Output
    output logic [31:0] o_result,
    output logic o_zero
);


    // Combinational Logic
    always_comb begin
        o_zero = 1'b0;
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

// mult_gen_32_64 mult(
//   .CLK(clk), // input wire CLK
//   .A(A), // input wire [31:0] A
//   .B(B), // input wire [31:0] B
//   .CE(CE), // input wire CE
//   .P(Prod) // output wire [63:0] P
// );

// mult_gen_32u_64u multU (
//   .CLK(clk), // input wire CLK
//   .A(A), // input wire [31:0] A
//   .B(B), // input wire [31:0] B
//   .CE(CE), // input wire CE
//   .P(uProd) // output wire [63:0] P
// );

// div_gen_32_64 div (
//   .aclk(clk),                                      // input wire aclk
//   .s_axis_divisor_tvalid(CE),    // input wire s_axis_divisor_tvalid
//   .s_axis_divisor_tdata(B),      // input wire [31 : 0] s_axis_divisor_tdata
//   .s_axis_dividend_tvalid(CE),  // input wire s_axis_dividend_tvalid
//   .s_axis_dividend_tdata(A),    // input wire [31 : 0] s_axis_dividend_tdata
//   .m_axis_dout_tvalid(qValid),          // output wire m_axis_dout_tvalid
//   .m_axis_dout_tdata({Quot,Rem})            // output wire [63 : 0] m_axis_dout_tdata
// );

// div_gen_32u_64u divU (
//   .aclk(clk),                                      // input wire aclk
//   .s_axis_divisor_tvalid(CE),    // input wire s_axis_divisor_tvalid
//   .s_axis_divisor_tdata(B),      // input wire [31 : 0] s_axis_divisor_tdata
//   .s_axis_dividend_tvalid(CE),  // input wire s_axis_dividend_tvalid
//   .s_axis_dividend_tdata(A),    // input wire [31 : 0] s_axis_dividend_tdata
//   .m_axis_dout_tvalid(qValidU),          // output wire m_axis_dout_tvalid
//   .m_axis_dout_tdata({uQuot,uRem})            // output wire [63 : 0] m_axis_dout_tdata
// );
