`define LUI_OP 0
`define AUIPC_OP 1
`define JAL_OP 2
`define JALR_OP 3
`define BEQ_OP 10
`define BNE_OP 11
`define BLT_OP 12
`define BGE_OP 13
`define BLTU_OP 14
`define BGEU_OP 15
`define LB_OP 20
`define LH_OP 21
`define LW_OP 22
`define LBU_OP 23
`define LHU_OP 24
`define SB_OP 25
`define SH_OP 26
`define SW_OP 27
`define ADDI_OP 30
`define SLTI_OP 31
`define SLTIU_OP 32
`define XORI_OP 33
`define ORI_OP 34
`define ANDI_OP 35
`define SLLI_OP 36
`define SRLI_OP 37
`define SRAI_OP 38
`define ADD_OP 40
`define SUB_OP 41
`define SLL_OP 42
`define SLT_OP 43
`define SLTU_OP 44
`define XOR_OP 45
`define SRL_OP 46
`define SRA_OP 47
`define OR_OP 48
`define AND_OP 49

// `define SCRIPT_TEST



module if_instrMem (
  input  logic        i_clk,
  input  logic [31:0] i_addr,
  input  logic [31:0] i_mem_instr,
  output logic [31:0] o_instr,
  output logic [31:0] o_mem_instrAddr
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
        `JALR_OP: gen_instr = {imm[11:0], rs1, 3'b000, rd, 7'b1100111};
        `BEQ_OP:  gen_instr = {imm[12], imm[10:5], rs2, rs1, 3'b000, imm[4:1], imm[11], 7'b1100011};
        `BNE_OP:  gen_instr = {imm[12], imm[10:5], rs2, rs1, 3'b001, imm[4:1], imm[11], 7'b1100011};
        `BLT_OP:  gen_instr = {imm[12], imm[10:5], rs2, rs1, 3'b100, imm[4:1], imm[11], 7'b1100011};
        `BGE_OP:  gen_instr = {imm[12], imm[10:5], rs2, rs1, 3'b101, imm[4:1], imm[11], 7'b1100011};
        `BLTU_OP: gen_instr = {imm[12], imm[10:5], rs2, rs1, 3'b110, imm[4:1], imm[11], 7'b1100011};
        `BGEU_OP: gen_instr = {imm[12], imm[10:5], rs2, rs1, 3'b111, imm[4:1], imm[11], 7'b1100011};
        `LB_OP:   gen_instr = {imm[11:0], rs1, 3'b000, rd, 7'b0000011};
        `LH_OP:   gen_instr = {imm[11:0], rs1, 3'b001, rd, 7'b0000011};
        `LW_OP:   gen_instr = {imm[11:0], rs1, 3'b010, rd, 7'b0000011};
        `LBU_OP:  gen_instr = {imm[11:0], rs1, 3'b100, rd, 7'b0000011};
        `LHU_OP:  gen_instr = {imm[11:0], rs1, 3'b101, rd, 7'b0000011};
        `SB_OP:   gen_instr = {imm[11:5], rs2, rs1, 3'b000, imm[4:0], 7'b0100011};
        `SH_OP:   gen_instr = {imm[11:5], rs2, rs1, 3'b001, imm[4:0], 7'b0100011};
        `SW_OP:   gen_instr = {imm[11:5], rs2, rs1, 3'b010, imm[4:0], 7'b0100011};
        `ADDI_OP: gen_instr = {imm[11:0], rs1, 3'b000, rd, 7'b0010011};
        `SLTI_OP: gen_instr = {imm[11:0], rs1, 3'b010, rd, 7'b0010011};
        `SLTIU_OP:gen_instr = {imm[11:0], rs1, 3'b011, rd, 7'b0010011};
        `XORI_OP: gen_instr = {imm[11:0], rs1, 3'b100, rd, 7'b0010011};
        `ORI_OP:  gen_instr = {imm[11:0], rs1, 3'b110, rd, 7'b0010011};
        `ANDI_OP: gen_instr = {imm[11:0], rs1, 3'b111, rd, 7'b0010011};
        `SLLI_OP: gen_instr = {7'b0000000, imm[4:0], rs1, 3'b001, rd, 7'b0010011};
        `SRLI_OP: gen_instr = {7'b0000000, imm[4:0], rs1, 3'b101, rd, 7'b0010011};
        `SRAI_OP: gen_instr = {7'b0100000, imm[4:0], rs1, 3'b101, rd, 7'b0010011};
        `ADD_OP:  gen_instr = {7'b0000000, rs2, rs1, 3'b000, rd, 7'b0110011};
        `SUB_OP:  gen_instr = {7'b0100000, rs2, rs1, 3'b000, rd, 7'b0110011};
        `SLL_OP:  gen_instr = {7'b0000000, rs2, rs1, 3'b001, rd, 7'b0110011};
        `SLT_OP:  gen_instr = {7'b0000000, rs2, rs1, 3'b010, rd, 7'b0110011};
        `SLTU_OP: gen_instr = {7'b0000000, rs2, rs1, 3'b011, rd, 7'b0110011};
        `XOR_OP:  gen_instr = {7'b0000000, rs2, rs1, 3'b100, rd, 7'b0110011};
        default:  gen_instr = 32'h00000000;
      endcase
    end
  endfunction

`ifndef SCRIPT_TEST

  // Route to main memory
  // gets latched in PC
  assign o_mem_instrAddr = i_addr;

  // Should latch when accessing block RAM
  // always_ff @(negedge i_clk) begin
  //   o_instr <= i_mem_instr;
  // end

  assign o_instr = i_mem_instr;

`else

  always_ff @(negedge i_clk) begin
    case (i_addr)
      0:   o_instr <= gen_instr(`ADDI_OP, 1, 1, 0, 32'd1);
      4:   o_instr <= gen_instr(`ADDI_OP, 2, 2, 0, 32'd1);
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
      76: o_instr <= gen_instr(`LUI_OP, 5, 0, 0, 32'hCD_AA_BA_AA);
      80: o_instr <= gen_instr(`ADDI_OP, 5, 5, 0, -1247);
      84: o_instr <= gen_instr(`SW_OP, 0, 0, 5, 32'd8);
      88: o_instr <= gen_instr(`LB_OP, 6, 0, 0, 32'd8);
      92: o_instr <= gen_instr(`LB_OP, 7, 0, 0, 32'd9);
      96: o_instr <= gen_instr(`LB_OP, 8, 0, 0, 32'd10);
      100: o_instr <= gen_instr(`LB_OP, 9, 0, 0, 32'd11);

      default: o_instr <= gen_instr(`ADD_OP, 0, 0, 0, 0);
    endcase
  end

  `endif

endmodule : if_instrMem
