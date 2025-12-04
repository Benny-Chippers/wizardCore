// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VtestBench__Syms.h"


void VtestBench___024root__trace_chg_0_sub_0(VtestBench___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void VtestBench___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root__trace_chg_0\n"); );
    // Body
    VtestBench___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VtestBench___024root*>(voidSelf);
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    VtestBench___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void VtestBench___024root__trace_chg_0_sub_0(VtestBench___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root__trace_chg_0_sub_0\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[1U]))) {
        bufp->chgIData(oldp+0,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0]),32);
        bufp->chgIData(oldp+1,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[1]),32);
        bufp->chgIData(oldp+2,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[2]),32);
        bufp->chgIData(oldp+3,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[3]),32);
        bufp->chgIData(oldp+4,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[4]),32);
        bufp->chgIData(oldp+5,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[5]),32);
        bufp->chgIData(oldp+6,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[6]),32);
        bufp->chgIData(oldp+7,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[7]),32);
        bufp->chgIData(oldp+8,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[8]),32);
        bufp->chgIData(oldp+9,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[9]),32);
        bufp->chgIData(oldp+10,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[10]),32);
        bufp->chgIData(oldp+11,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[11]),32);
        bufp->chgIData(oldp+12,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[12]),32);
        bufp->chgIData(oldp+13,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[13]),32);
        bufp->chgIData(oldp+14,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[14]),32);
        bufp->chgIData(oldp+15,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[15]),32);
        bufp->chgIData(oldp+16,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[16]),32);
        bufp->chgIData(oldp+17,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[17]),32);
        bufp->chgIData(oldp+18,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[18]),32);
        bufp->chgIData(oldp+19,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[19]),32);
        bufp->chgIData(oldp+20,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[20]),32);
        bufp->chgIData(oldp+21,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[21]),32);
        bufp->chgIData(oldp+22,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[22]),32);
        bufp->chgIData(oldp+23,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[23]),32);
        bufp->chgIData(oldp+24,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[24]),32);
        bufp->chgIData(oldp+25,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[25]),32);
        bufp->chgIData(oldp+26,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[26]),32);
        bufp->chgIData(oldp+27,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[27]),32);
        bufp->chgIData(oldp+28,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[28]),32);
        bufp->chgIData(oldp+29,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[29]),32);
        bufp->chgIData(oldp+30,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[30]),32);
        bufp->chgIData(oldp+31,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[31]),32);
        bufp->chgIData(oldp+32,(vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__unnamedblk1__DOT__i),32);
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[2U]))) {
        bufp->chgBit(oldp+33,((1U > (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))));
        bufp->chgBit(oldp+34,((2U > (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))));
        bufp->chgBit(oldp+35,((3U > (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))));
        bufp->chgSData(oldp+36,(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out),16);
        bufp->chgSData(oldp+37,(((4U == (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))
                                  ? 0U : (0x0000ffffU 
                                          & ((IData)(1U) 
                                             + (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))))),16);
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[3U]))) {
        bufp->chgIData(oldp+38,(vlSelfRef.testBench__DOT__instruction),32);
        bufp->chgIData(oldp+39,(vlSelfRef.testBench__DOT__immediate),32);
        bufp->chgSData(oldp+40,(vlSelfRef.testBench__DOT__ex),13);
        bufp->chgIData(oldp+41,(((0x00001000U & vlSelfRef.testBench__DOT__immediate)
                                  ? (0xffffe000U | 
                                     (0x00001fffU & vlSelfRef.testBench__DOT__immediate))
                                  : vlSelfRef.testBench__DOT__immediate)),32);
        bufp->chgSData(oldp+42,(vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU),12);
        bufp->chgCData(oldp+43,(vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1),5);
        bufp->chgCData(oldp+44,(vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2),5);
    }
    if (VL_UNLIKELY((vlSelfRef.__Vm_traceActivity[4U]))) {
        bufp->chgIData(oldp+45,(vlSelfRef.testBench__DOT__regData1),32);
        bufp->chgIData(oldp+46,(vlSelfRef.testBench__DOT__regData2),32);
        bufp->chgBit(oldp+47,(vlSelfRef.testBench__DOT__zero));
        bufp->chgIData(oldp+48,(vlSelfRef.testBench__DOT__EX__DOT__w_B),32);
    }
    bufp->chgSData(oldp+49,(vlSelfRef.b),16);
    bufp->chgIData(oldp+50,(vlSelfRef.readData),32);
    bufp->chgCData(oldp+51,(vlSelfRef.wb),7);
    bufp->chgIData(oldp+52,(vlSelfRef.outAddr),32);
    bufp->chgIData(oldp+53,(vlSelfRef.resultALU),32);
    bufp->chgBit(oldp+54,(vlSelfRef.testBench__DOT__clk));
    bufp->chgBit(oldp+55,(vlSelfRef.testBench__DOT__reset_n));
    bufp->chgBit(oldp+56,(vlSelfRef.testBench__DOT__hit_reset));
    bufp->chgBit(oldp+57,((((IData)(vlSelfRef.testBench__DOT__mem) 
                            >> 2U) & (IData)(vlSelfRef.testBench__DOT__zero))));
    bufp->chgIData(oldp+58,(vlSelfRef.testBench__DOT__IF__DOT__PCout),32);
    bufp->chgIData(oldp+59,(((0x00000020U & (IData)(vlSelfRef.wb))
                              ? vlSelfRef.readData : vlSelfRef.resultALU)),32);
    bufp->chgCData(oldp+60,(vlSelfRef.testBench__DOT__mem),3);
    bufp->chgBit(oldp+61,((1U & ((IData)(vlSelfRef.wb) 
                                 >> 6U))));
    bufp->chgCData(oldp+62,((0x0000001fU & (IData)(vlSelfRef.wb))),5);
    bufp->chgIData(oldp+63,(((((IData)(vlSelfRef.testBench__DOT__mem) 
                               >> 2U) & (IData)(vlSelfRef.testBench__DOT__zero))
                              ? vlSelfRef.outAddr : 
                             ((IData)(4U) + vlSelfRef.testBench__DOT__IF__DOT__PCout))),32);
    bufp->chgCData(oldp+64,((3U & (IData)(vlSelfRef.testBench__DOT__mem))),2);
    bufp->chgIData(oldp+65,(vlSelfRef.testBench__DOT__MEM__DOT__Memory__DOT__unnamedblk1__DOT__i),32);
    bufp->chgBit(oldp+66,((1U & ((IData)(vlSelfRef.wb) 
                                 >> 5U))));
}

void VtestBench___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root__trace_cleanup\n"); );
    // Body
    VtestBench___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VtestBench___024root*>(voidSelf);
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[3U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[4U] = 0U;
}
