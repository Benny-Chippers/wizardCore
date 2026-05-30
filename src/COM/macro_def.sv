// Control Signal Definitions
`define OPCODE  i_instr[6:0]
`define RD      i_instr[11:7]
`define RS1     i_instr[19:15]
`define RS2     i_instr[24:20]
`define FUNCT3  i_instr[14:12]
`define FUNCT7  i_instr[31:25]
`define IMM     i_instr[31:20]

// System Definitions
`define CPU_FREQ 50_000_000