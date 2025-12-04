`define ADD_OP 0
`define SUB_OP 1
`define ADDI_OP 2
`define SLL_OP 3
`define BEQ_OP 10
`define SW_OP 20
`define LW_OP 21

module if_instrMem (
  input  logic        i_clk,
  input  logic [31:0] i_addr,
  output logic [31:0] o_instr
);

  // Function to generate a 32-bit instruction
  function automatic [31:0] gen_instr;
    input [6:0]  op;   // opcode macro
    input [4:0]  rd;
    input [4:0]  rs1;
    input [4:0]  rs2;
    input signed [12:0] imm;
    begin
      case (op)
        `ADD_OP:  gen_instr = {7'b0000000, rs2, rs1, 3'b000, rd, 7'b0110011};
        `SUB_OP:  gen_instr = {7'b0100000, rs2, rs1, 3'b000, rd, 7'b0110011};
        `ADDI_OP: gen_instr = {imm[11:0], rs1, 3'b000, rd, 7'b0010011};
        `SLL_OP:  gen_instr = {7'b0000000, rs2, rs1, 3'b001, rd, 7'b0110011};
        `BEQ_OP:  gen_instr = {imm[12], imm[10:5], rs2, rs1, 3'b000, imm[4:1], imm[11], 7'b1100011};
        `SW_OP:   gen_instr = {imm[11:5], rs2, rs1, 3'b010, imm[4:0], 7'b0100011};
        `LW_OP:   gen_instr = {imm[11:0], rs1, 3'b010, rd, 7'b0000011};
        default:  gen_instr = 32'h00000000;
      endcase
    end
  endfunction

  always_ff @(negedge i_clk) begin
    case (i_addr)
      0:   o_instr <= gen_instr(`ADDI_OP, 1, 1, 0, 13'd1);
      4:   o_instr <= gen_instr(`ADDI_OP, 2, 2, 0, 13'd1);
      8:   o_instr <= gen_instr(`ADDI_OP, 8, 8, 0, 13'd53);
      12:  o_instr <= gen_instr(`ADDI_OP, 7, 7, 0, 13'd27);
      16:  o_instr <= gen_instr(`ADD_OP, 7, 7, 9, 0);
      20:  o_instr <= gen_instr(`ADD_OP, 9, 8, 7, 0);
      24:  o_instr <= gen_instr(`SUB_OP, 9, 9, 8, 0);
      28:  o_instr <= gen_instr(`SLL_OP, 9, 9, 2, 0);
      32:  o_instr <= gen_instr(`SUB_OP, 1, 1, 2, 0);
      36:  o_instr <= gen_instr(`BEQ_OP, 0, 1, 0, -20);
      40:  o_instr <= gen_instr(`SW_OP, 0, 2, 9, 13'd4);
      44:  o_instr <= gen_instr(`LW_OP, 10, 2, 0, 13'd4);
      default: o_instr <= gen_instr(`ADD_OP, 0, 0, 0, 0);
    endcase
  end

endmodule : if_instrMem
