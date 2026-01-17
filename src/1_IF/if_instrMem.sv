`define LUI_OP 0
`define AUIPC_OP 11
`define JAL_OP 12
`define ADD_OP 1
`define SUB_OP 2
`define ADDI_OP 3
`define SLL_OP 4
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
    input signed [31:0] imm;
    begin
      case (op)
        `LUI_OP:  gen_instr = {imm[31:12], rd, 7'b0110111};
        `AUIPC_OP:gen_instr = {imm[31:12], rd, 7'b0010111};
        `JAL_OP:  gen_instr = {imm[20], imm[10:1], imm[11], imm[19:12], rd, 7'b1101111};
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
      0:   o_instr <= gen_instr(`ADDI_OP, 1, 1, 0, 32'd1);
      4:   o_instr <= gen_instr(`ADDI_OP, 2, 2, 0, 32'd1);
      // 8:   o_instr <= gen_instr(`ADDI_OP, 8, 8, 0, 32'd53);
      8:   o_instr <= gen_instr(`LUI_OP, 8, 0, 0, 32'h00_AB_F0_00);
      12:  o_instr <= gen_instr(`ADDI_OP, 7, 7, 0, 32'd27);
      16:  o_instr <= gen_instr(`ADD_OP, 7, 7, 9, 0);
      20:  o_instr <= gen_instr(`ADD_OP, 9, 8, 7, 0);
      24:  o_instr <= gen_instr(`SUB_OP, 9, 9, 8, 0);
      28:  o_instr <= gen_instr(`SLL_OP, 9, 9, 2, 0);
      32:  o_instr <= gen_instr(`SUB_OP, 1, 1, 2, 0);
      36:  o_instr <= gen_instr(`BEQ_OP, 0, 1, 0, -20);
      40:  o_instr <= gen_instr(`SW_OP, 0, 0, 9, 32'd4);
      44:  o_instr <= gen_instr(`LW_OP, 10, 0, 0, 32'd4);
      48:  o_instr <= gen_instr(`ADDI_OP, 1, 0, 0, 32'd1);
      52:  o_instr <= gen_instr(`ADD_OP, 2, 1, 0, 0);
      56:  o_instr <= gen_instr(`ADD_OP, 3, 2, 1, 0);
      60:  o_instr <= gen_instr(`ADD_OP, 4, 3, 2, 0);
      64:  o_instr <= gen_instr(`ADD_OP, 5, 4, 3, 0);
      68:  o_instr <= gen_instr(`ADD_OP, 6, 5, 4, 0);
      72:  o_instr <= gen_instr(`SUB_OP, 7, 6, 5, 0);
      76:  o_instr <= gen_instr(`SUB_OP, 8, 7, 6, 0);
      80:  o_instr <= gen_instr(`SUB_OP, 9, 8, 7, 0);
      84:  o_instr <= gen_instr(`SUB_OP, 10, 9, 8, 0);
      88:  o_instr <= gen_instr(`SUB_OP, 11, 10, 9, 0);
      92:  o_instr <= gen_instr(`SUB_OP, 12, 11, 10, 0);
      96:  o_instr <= gen_instr(`SUB_OP, 13, 12, 11, 0);
      100: o_instr <= gen_instr(`SUB_OP, 14, 13, 12, 0);
      104: o_instr <= gen_instr(`SUB_OP, 15, 14, 13, 0);
      108: o_instr <= gen_instr(`SUB_OP, 16, 15, 14, 0);
      112: o_instr <= gen_instr(`SUB_OP, 17, 16, 15, 0);
      116: o_instr <= gen_instr(`SUB_OP, 18, 17, 16, 0);
      120: o_instr <= gen_instr(`SUB_OP, 19, 18, 17, 0);
      124: o_instr <= gen_instr(`SUB_OP, 20, 19, 18, 0);
      128: o_instr <= gen_instr(`SUB_OP, 21, 20, 19, 0);
      132: o_instr <= gen_instr(`SUB_OP, 22, 21, 20, 0);
      136: o_instr <= gen_instr(`SUB_OP, 23, 22, 21, 0);
      140: o_instr <= gen_instr(`SUB_OP, 24, 23, 22, 0);
      144: o_instr <= gen_instr(`SUB_OP, 25, 24, 23, 0);
      148: o_instr <= gen_instr(`SUB_OP, 26, 25, 24, 0);
      152: o_instr <= gen_instr(`SUB_OP, 27, 26, 25, 0);
      156: o_instr <= gen_instr(`SUB_OP, 28, 27, 26, 0);
      160: o_instr <= gen_instr(`SUB_OP, 29, 28, 27, 0);
      164: o_instr <= gen_instr(`SUB_OP, 30, 29, 28, 0);
      168: o_instr <= gen_instr(`ADD_OP, 31, 30, 29, 0);
      172: o_instr <= gen_instr(`JAL_OP, 8, 0, 0, 32'h00_0B_FA_00);

      default: o_instr <= gen_instr(`ADD_OP, 0, 0, 0, 0);
    endcase
  end

endmodule : if_instrMem
