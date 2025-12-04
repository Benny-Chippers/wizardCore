// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See VtestBench.h for the primary calling header

#ifndef VERILATED_VTESTBENCH___024ROOT_H_
#define VERILATED_VTESTBENCH___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class VtestBench__Syms;

class alignas(VL_CACHE_LINE_BYTES) VtestBench___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_OUT8(wb,6,0);
    CData/*0:0*/ testBench__DOT__clk;
    CData/*0:0*/ testBench__DOT__reset_n;
    CData/*0:0*/ testBench__DOT__hit_reset;
    CData/*0:0*/ testBench__DOT__zero;
    CData/*2:0*/ testBench__DOT__mem;
    CData/*0:0*/ testBench__DOT__clk_if;
    CData/*0:0*/ testBench__DOT__clk_id;
    CData/*0:0*/ testBench__DOT__clk_mem;
    CData/*4:0*/ testBench__DOT__ID__DOT__w_rdReg1;
    CData/*4:0*/ testBench__DOT__ID__DOT__w_rdReg2;
    CData/*0:0*/ __VdlyVal__testBench__DOT__clk__v0;
    CData/*0:0*/ __VdlySet__testBench__DOT__clk__v0;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__testBench__DOT__clk__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__testBench__DOT__reset_n__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__testBench__DOT__clk_if__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__testBench__DOT__clk_id__0;
    CData/*0:0*/ __Vtrigprevexpr___TOP__testBench__DOT__clk_mem__0;
    VL_OUT16(b,15,0);
    SData/*15:0*/ testBench__DOT__a;
    SData/*15:0*/ testBench__DOT__c_i;
    SData/*12:0*/ testBench__DOT__ex;
    SData/*15:0*/ testBench__DOT__CLK_GEN__DOT__w_clkData_out;
    SData/*15:0*/ testBench__DOT__CLK_GEN__DOT__w_clkData_in;
    SData/*11:0*/ testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU;
    VL_OUT(outAddr,31,0);
    VL_OUT(resultALU,31,0);
    VL_OUT(readData,31,0);
    IData/*31:0*/ testBench__DOT__instruction;
    IData/*31:0*/ testBench__DOT__immediate;
    IData/*31:0*/ testBench__DOT__regData1;
    IData/*31:0*/ testBench__DOT__regData2;
    IData/*31:0*/ testBench__DOT__IF__DOT__PCin;
    IData/*31:0*/ testBench__DOT__IF__DOT__PCout;
    IData/*31:0*/ testBench__DOT__ID__DOT__Reg__DOT__unnamedblk1__DOT__i;
    IData/*31:0*/ testBench__DOT__EX__DOT__w_B;
    IData/*31:0*/ testBench__DOT__MEM__DOT__Memory__DOT__unnamedblk1__DOT__i;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<IData/*31:0*/, 32> testBench__DOT__ID__DOT__Reg__DOT__regs;
    VlUnpacked<IData/*31:0*/, 256> testBench__DOT__MEM__DOT__Memory__DOT__mem_array;
    VlUnpacked<QData/*63:0*/, 1> __VstlTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VactTriggered;
    VlUnpacked<QData/*63:0*/, 1> __VnbaTriggered;
    VlUnpacked<CData/*0:0*/, 5> __Vm_traceActivity;
    VlNBACommitQueue<VlUnpacked<IData/*31:0*/, 256>, false, IData/*31:0*/, 1> __VdlyCommitQueuetestBench__DOT__MEM__DOT__Memory__DOT__mem_array;
    VlDelayScheduler __VdlySched;

    // INTERNAL VARIABLES
    VtestBench__Syms* const vlSymsp;

    // CONSTRUCTORS
    VtestBench___024root(VtestBench__Syms* symsp, const char* v__name);
    ~VtestBench___024root();
    VL_UNCOPYABLE(VtestBench___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
