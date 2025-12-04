// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VtestBench__Syms.h"


VL_ATTR_COLD void VtestBench___024root__trace_init_sub__TOP__0(VtestBench___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root__trace_init_sub__TOP__0\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const int c = vlSymsp->__Vm_baseCode;
    tracep->pushPrefix("$rootio", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+50,0,"b",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+51,0,"readData",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+52,0,"wb",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+53,0,"outAddr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+54,0,"resultALU",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->pushPrefix("testBench", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+55,0,"clk",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+56,0,"reset_n",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+57,0,"hit_reset",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+68,0,"a",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+50,0,"b",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+69,0,"c_o",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+70,0,"c_i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBit(c+58,0,"PCSrc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+59,0,"inAddr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+39,0,"instruction",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+40,0,"immediate",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+46,0,"regData1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+47,0,"regData2",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+48,0,"zero",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+51,0,"readData",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+60,0,"wrData",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+41,0,"ex",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 12,0);
    tracep->declBus(c+61,0,"mem",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+52,0,"wb",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+53,0,"outAddr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+54,0,"resultALU",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+34,0,"clk_if",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+35,0,"clk_id",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+36,0,"clk_mem",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("CLK_GEN", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+55,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+56,0,"i_reset_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+34,0,"o_clk_if",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+35,0,"o_clk_id",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+36,0,"o_clk_mem",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+37,0,"w_clkData_out",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+38,0,"w_clkData_in",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->pushPrefix("clkDivider_if", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+55,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+56,0,"reset_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+38,0,"d",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->declBus(c+37,0,"q",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 15,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("EX", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+59,0,"i_inAddr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+46,0,"i_regData1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+47,0,"i_regData2",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+40,0,"i_immediate",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+41,0,"i_ctrlEX",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 12,0);
    tracep->declBus(c+53,0,"o_outAddr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+48,0,"o_zero",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+54,0,"o_resultALU",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+46,0,"w_A",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+49,0,"w_B",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+42,0,"w_addrOffset",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->pushPrefix("ALU", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+46,0,"i_A",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+49,0,"i_B",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+43,0,"i_ctrlALU",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 11,0);
    tracep->declBus(c+54,0,"o_result",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+48,0,"o_zero",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("ID", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+35,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+56,0,"i_reset_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+39,0,"i_instr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+62,0,"i_wrSig",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+63,0,"i_wrReg",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+60,0,"i_wrData",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+46,0,"o_rdData1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+47,0,"o_rdData2",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+40,0,"o_immediate",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+41,0,"o_ctrlEX",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 12,0);
    tracep->declBus(c+61,0,"o_ctrlMEM",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+52,0,"o_ctrlWB",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+44,0,"w_rdReg1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+45,0,"w_rdReg2",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->pushPrefix("Ctrl", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+39,0,"i_instr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+44,0,"o_rdReg1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+45,0,"o_rdReg2",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+41,0,"o_ctrlEX",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 12,0);
    tracep->declBus(c+61,0,"o_ctrlMEM",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+52,0,"o_ctrlWB",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->popPrefix();
    tracep->pushPrefix("ImmGen", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+39,0,"i_instr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+40,0,"o_imm",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->pushPrefix("Reg", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+35,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+56,0,"i_reset_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+44,0,"i_rdReg1",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+45,0,"i_rdReg2",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBit(c+62,0,"i_wrSig",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+63,0,"i_wrReg",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+60,0,"i_wrData",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+46,0,"o_rdData1",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+47,0,"o_rdData2",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->pushPrefix("regs", VerilatedTracePrefixType::ARRAY_UNPACKED);
    for (int i = 0; i < 32; ++i) {
        tracep->declBus(c+1+i*1,0,"",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, true,(i+0), 31,0);
    }
    tracep->popPrefix();
    tracep->pushPrefix("unnamedblk1", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+33,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("IF", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+34,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+56,0,"i_reset_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+58,0,"i_PCSrc",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+53,0,"i_inAddr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+59,0,"o_outAddr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+39,0,"o_instruction",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+64,0,"PCin",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+59,0,"PCout",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->pushPrefix("IM", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+34,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+59,0,"i_addr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+39,0,"o_instr",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->pushPrefix("PC", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+34,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+56,0,"reset_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+64,0,"d",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+59,0,"q",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("MEM", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+36,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+56,0,"i_reset_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+54,0,"i_memAddr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+47,0,"i_wrData",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+61,0,"i_ctrlMEM",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+48,0,"i_zero",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+51,0,"o_readData",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+58,0,"o_PCSrc",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("Memory", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+36,0,"i_clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+56,0,"i_reset_n",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+54,0,"i_memAddr",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+47,0,"i_writeData",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+65,0,"i_ctrlMEM",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+51,0,"o_readData",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->pushPrefix("unnamedblk1", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+66,0,"i",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::INT, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("WB", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+67,0,"i_ctrlWB",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+51,0,"i_readData",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+54,0,"i_resultALU",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+60,0,"o_wrData",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
}

VL_ATTR_COLD void VtestBench___024root__trace_init_top(VtestBench___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root__trace_init_top\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    VtestBench___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void VtestBench___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
VL_ATTR_COLD void VtestBench___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VtestBench___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void VtestBench___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void VtestBench___024root__trace_register(VtestBench___024root* vlSelf, VerilatedVcd* tracep) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root__trace_register\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    tracep->addConstCb(&VtestBench___024root__trace_const_0, 0, vlSelf);
    tracep->addFullCb(&VtestBench___024root__trace_full_0, 0, vlSelf);
    tracep->addChgCb(&VtestBench___024root__trace_chg_0, 0, vlSelf);
    tracep->addCleanupCb(&VtestBench___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void VtestBench___024root__trace_const_0_sub_0(VtestBench___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void VtestBench___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root__trace_const_0\n"); );
    // Body
    VtestBench___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VtestBench___024root*>(voidSelf);
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VtestBench___024root__trace_const_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void VtestBench___024root__trace_const_0_sub_0(VtestBench___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root__trace_const_0_sub_0\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    bufp->fullSData(oldp+68,(vlSelfRef.testBench__DOT__a),16);
    bufp->fullSData(oldp+69,(((0x0000ff00U & ((IData)(vlSelfRef.testBench__DOT__c_i) 
                                              << 8U)) 
                              | (0x000000ffU & ((IData)(vlSelfRef.testBench__DOT__c_i) 
                                                >> 8U)))),16);
    bufp->fullSData(oldp+70,(vlSelfRef.testBench__DOT__c_i),16);
}

VL_ATTR_COLD void VtestBench___024root__trace_full_0_sub_0(VtestBench___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void VtestBench___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root__trace_full_0\n"); );
    // Body
    VtestBench___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VtestBench___024root*>(voidSelf);
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VtestBench___024root__trace_full_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void VtestBench___024root__trace_full_0_sub_0(VtestBench___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root__trace_full_0_sub_0\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    bufp->fullIData(oldp+1,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0]),32);
    bufp->fullIData(oldp+2,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[1]),32);
    bufp->fullIData(oldp+3,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[2]),32);
    bufp->fullIData(oldp+4,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[3]),32);
    bufp->fullIData(oldp+5,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[4]),32);
    bufp->fullIData(oldp+6,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[5]),32);
    bufp->fullIData(oldp+7,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[6]),32);
    bufp->fullIData(oldp+8,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[7]),32);
    bufp->fullIData(oldp+9,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[8]),32);
    bufp->fullIData(oldp+10,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[9]),32);
    bufp->fullIData(oldp+11,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[10]),32);
    bufp->fullIData(oldp+12,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[11]),32);
    bufp->fullIData(oldp+13,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[12]),32);
    bufp->fullIData(oldp+14,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[13]),32);
    bufp->fullIData(oldp+15,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[14]),32);
    bufp->fullIData(oldp+16,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[15]),32);
    bufp->fullIData(oldp+17,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[16]),32);
    bufp->fullIData(oldp+18,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[17]),32);
    bufp->fullIData(oldp+19,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[18]),32);
    bufp->fullIData(oldp+20,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[19]),32);
    bufp->fullIData(oldp+21,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[20]),32);
    bufp->fullIData(oldp+22,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[21]),32);
    bufp->fullIData(oldp+23,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[22]),32);
    bufp->fullIData(oldp+24,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[23]),32);
    bufp->fullIData(oldp+25,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[24]),32);
    bufp->fullIData(oldp+26,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[25]),32);
    bufp->fullIData(oldp+27,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[26]),32);
    bufp->fullIData(oldp+28,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[27]),32);
    bufp->fullIData(oldp+29,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[28]),32);
    bufp->fullIData(oldp+30,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[29]),32);
    bufp->fullIData(oldp+31,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[30]),32);
    bufp->fullIData(oldp+32,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[31]),32);
    bufp->fullIData(oldp+33,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__unnamedblk1__DOT__i),32);
    bufp->fullBit(oldp+34,((1U > (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))));
    bufp->fullBit(oldp+35,((2U > (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))));
    bufp->fullBit(oldp+36,((3U > (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))));
    bufp->fullSData(oldp+37,(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out),16);
    bufp->fullSData(oldp+38,(((4U == (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))
                               ? 0U : (0x0000ffffU 
                                       & ((IData)(1U) 
                                          + (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))))),16);
    bufp->fullIData(oldp+39,(vlSelfRef.testBench__DOT__instruction),32);
    bufp->fullIData(oldp+40,(vlSelfRef.testBench__DOT__immediate),32);
    bufp->fullSData(oldp+41,(vlSelfRef.testBench__DOT__ex),13);
    bufp->fullIData(oldp+42,(((0x00001000U & vlSelfRef.testBench__DOT__immediate)
                               ? (0xffffe000U | (0x00001fffU 
                                                 & vlSelfRef.testBench__DOT__immediate))
                               : vlSelfRef.testBench__DOT__immediate)),32);
    bufp->fullSData(oldp+43,(vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU),12);
    bufp->fullCData(oldp+44,(vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1),5);
    bufp->fullCData(oldp+45,(vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2),5);
    bufp->fullIData(oldp+46,(vlSelfRef.testBench__DOT__regData1),32);
    bufp->fullIData(oldp+47,(vlSelfRef.testBench__DOT__regData2),32);
    bufp->fullBit(oldp+48,(vlSelfRef.testBench__DOT__zero));
    bufp->fullIData(oldp+49,(vlSelfRef.testBench__DOT__EX__DOT__w_B),32);
    bufp->fullSData(oldp+50,(vlSelfRef.b),16);
    bufp->fullIData(oldp+51,(vlSelfRef.readData),32);
    bufp->fullCData(oldp+52,(vlSelfRef.wb),7);
    bufp->fullIData(oldp+53,(vlSelfRef.outAddr),32);
    bufp->fullIData(oldp+54,(vlSelfRef.resultALU),32);
    bufp->fullBit(oldp+55,(vlSelfRef.testBench__DOT__clk));
    bufp->fullBit(oldp+56,(vlSelfRef.testBench__DOT__reset_n));
    bufp->fullBit(oldp+57,(vlSelfRef.testBench__DOT__hit_reset));
    bufp->fullBit(oldp+58,((((IData)(vlSelfRef.testBench__DOT__mem) 
                             >> 2U) & (IData)(vlSelfRef.testBench__DOT__zero))));
    bufp->fullIData(oldp+59,(vlSelfRef.testBench__DOT__IF__DOT__PCout),32);
    bufp->fullIData(oldp+60,(((0x00000020U & (IData)(vlSelfRef.wb))
                               ? vlSelfRef.readData
                               : vlSelfRef.resultALU)),32);
    bufp->fullCData(oldp+61,(vlSelfRef.testBench__DOT__mem),3);
    bufp->fullBit(oldp+62,((1U & ((IData)(vlSelfRef.wb) 
                                  >> 6U))));
    bufp->fullCData(oldp+63,((0x0000001fU & (IData)(vlSelfRef.wb))),5);
    bufp->fullIData(oldp+64,(((((IData)(vlSelfRef.testBench__DOT__mem) 
                                >> 2U) & (IData)(vlSelfRef.testBench__DOT__zero))
                               ? vlSelfRef.outAddr : 
                              ((IData)(4U) + vlSelfRef.testBench__DOT__IF__DOT__PCout))),32);
    bufp->fullCData(oldp+65,((3U & (IData)(vlSelfRef.testBench__DOT__mem))),2);
    bufp->fullIData(oldp+66,(vlSelfRef.testBench__DOT__MEM__DOT__Memory__DOT__unnamedblk1__DOT__i),32);
    bufp->fullBit(oldp+67,((1U & ((IData)(vlSelfRef.wb) 
                                  >> 5U))));
}
