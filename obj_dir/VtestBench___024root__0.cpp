// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VtestBench.h for the primary calling header

#include "VtestBench__pch.h"

VL_ATTR_COLD void VtestBench___024root___eval_initial__TOP(VtestBench___024root* vlSelf);
VlCoroutine VtestBench___024root___eval_initial__TOP__Vtiming__0(VtestBench___024root* vlSelf);
VlCoroutine VtestBench___024root___eval_initial__TOP__Vtiming__1(VtestBench___024root* vlSelf);

void VtestBench___024root___eval_initial(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_initial\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    VtestBench___024root___eval_initial__TOP(vlSelf);
    VtestBench___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    VtestBench___024root___eval_initial__TOP__Vtiming__1(vlSelf);
}

VlCoroutine VtestBench___024root___eval_initial__TOP__Vtiming__0(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_initial__TOP__Vtiming__0\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    co_await vlSelfRef.__VdlySched.delay(0x0000000000000bb8ULL, 
                                         nullptr, "src/testBench.sv", 
                                         79);
    VL_FINISH_MT("src/testBench.sv", 80, "");
}

VlCoroutine VtestBench___024root___eval_initial__TOP__Vtiming__1(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_initial__TOP__Vtiming__1\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    while (VL_LIKELY(!vlSymsp->_vm_contextp__->gotFinish())) {
        co_await vlSelfRef.__VdlySched.delay(5ULL, 
                                             nullptr, 
                                             "src/testBench.sv", 
                                             49);
        vlSelfRef.__VdlyVal__testBench__DOT__clk__v0 
            = (1U & (~ (IData)(vlSelfRef.testBench__DOT__clk)));
        vlSelfRef.__VdlySet__testBench__DOT__clk__v0 = 1U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VtestBench___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG

void VtestBench___024root___eval_triggers__act(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_triggers__act\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered[0U] = (QData)((IData)(
                                                    (((((vlSelfRef.__VdlySched.awaitingCurrentTime() 
                                                         << 3U) 
                                                        | (((IData)(vlSelfRef.testBench__DOT__clk_mem) 
                                                            & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__testBench__DOT__clk_mem__0))) 
                                                           << 2U)) 
                                                       | ((((~ (IData)(vlSelfRef.testBench__DOT__clk_mem)) 
                                                            & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__testBench__DOT__clk_mem__0)) 
                                                           << 1U) 
                                                          | ((IData)(vlSelfRef.testBench__DOT__clk_id) 
                                                             & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__testBench__DOT__clk_id__0))))) 
                                                      << 4U) 
                                                     | (((((~ (IData)(vlSelfRef.testBench__DOT__clk_if)) 
                                                           & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__testBench__DOT__clk_if__0)) 
                                                          << 3U) 
                                                         | (((IData)(vlSelfRef.testBench__DOT__clk_if) 
                                                             & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__testBench__DOT__clk_if__0))) 
                                                            << 2U)) 
                                                        | ((((~ (IData)(vlSelfRef.testBench__DOT__reset_n)) 
                                                             & (IData)(vlSelfRef.__Vtrigprevexpr___TOP__testBench__DOT__reset_n__0)) 
                                                            << 1U) 
                                                           | ((IData)(vlSelfRef.testBench__DOT__clk) 
                                                              & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__testBench__DOT__clk__0))))))));
    vlSelfRef.__Vtrigprevexpr___TOP__testBench__DOT__clk__0 
        = vlSelfRef.testBench__DOT__clk;
    vlSelfRef.__Vtrigprevexpr___TOP__testBench__DOT__reset_n__0 
        = vlSelfRef.testBench__DOT__reset_n;
    vlSelfRef.__Vtrigprevexpr___TOP__testBench__DOT__clk_if__0 
        = vlSelfRef.testBench__DOT__clk_if;
    vlSelfRef.__Vtrigprevexpr___TOP__testBench__DOT__clk_id__0 
        = vlSelfRef.testBench__DOT__clk_id;
    vlSelfRef.__Vtrigprevexpr___TOP__testBench__DOT__clk_mem__0 
        = vlSelfRef.testBench__DOT__clk_mem;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        VtestBench___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
    }
#endif
}

bool VtestBench___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___trigger_anySet__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        if (in[n]) {
            return (1U);
        }
        n = ((IData)(1U) + n);
    } while ((1U > n));
    return (0U);
}

void VtestBench___024root___nba_sequent__TOP__0(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___nba_sequent__TOP__0\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VdlyVal__testBench__DOT__ID__DOT__Reg__DOT__regs__v0;
    __VdlyVal__testBench__DOT__ID__DOT__Reg__DOT__regs__v0 = 0;
    CData/*4:0*/ __VdlyDim0__testBench__DOT__ID__DOT__Reg__DOT__regs__v0;
    __VdlyDim0__testBench__DOT__ID__DOT__Reg__DOT__regs__v0 = 0;
    CData/*0:0*/ __VdlySet__testBench__DOT__ID__DOT__Reg__DOT__regs__v0;
    __VdlySet__testBench__DOT__ID__DOT__Reg__DOT__regs__v0 = 0;
    CData/*0:0*/ __VdlySet__testBench__DOT__ID__DOT__Reg__DOT__regs__v1;
    __VdlySet__testBench__DOT__ID__DOT__Reg__DOT__regs__v1 = 0;
    // Body
    __VdlySet__testBench__DOT__ID__DOT__Reg__DOT__regs__v0 = 0U;
    __VdlySet__testBench__DOT__ID__DOT__Reg__DOT__regs__v1 = 0U;
    if ((1U & (~ (IData)(vlSelfRef.testBench__DOT__reset_n)))) {
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__unnamedblk1__DOT__i = 0x00000020U;
    }
    if (vlSelfRef.testBench__DOT__reset_n) {
        if ((((IData)(vlSelfRef.wb) >> 6U) & (0U != 
                                              (0x0000001fU 
                                               & (IData)(vlSelfRef.wb))))) {
            __VdlyVal__testBench__DOT__ID__DOT__Reg__DOT__regs__v0 
                = ((0x00000020U & (IData)(vlSelfRef.wb))
                    ? vlSelfRef.readData : vlSelfRef.resultALU);
            __VdlyDim0__testBench__DOT__ID__DOT__Reg__DOT__regs__v0 
                = (0x0000001fU & (IData)(vlSelfRef.wb));
            __VdlySet__testBench__DOT__ID__DOT__Reg__DOT__regs__v0 = 1U;
        }
    } else {
        __VdlySet__testBench__DOT__ID__DOT__Reg__DOT__regs__v1 = 1U;
    }
    if (__VdlySet__testBench__DOT__ID__DOT__Reg__DOT__regs__v0) {
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[__VdlyDim0__testBench__DOT__ID__DOT__Reg__DOT__regs__v0] 
            = __VdlyVal__testBench__DOT__ID__DOT__Reg__DOT__regs__v0;
    }
    if (__VdlySet__testBench__DOT__ID__DOT__Reg__DOT__regs__v1) {
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[1U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[2U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[3U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[4U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[5U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[6U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[7U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[8U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[9U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x0aU] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x0bU] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x0cU] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x0dU] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x0eU] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x0fU] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x10U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x11U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x12U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x13U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x14U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x15U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x16U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x17U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x18U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x19U] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x1aU] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x1bU] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x1cU] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x1dU] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x1eU] = 0U;
        vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs[0x1fU] = 0U;
    }
}

void VtestBench___024root___nba_sequent__TOP__1(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___nba_sequent__TOP__1\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (vlSelfRef.__VdlySet__testBench__DOT__clk__v0) {
        vlSelfRef.__VdlySet__testBench__DOT__clk__v0 = 0U;
        vlSelfRef.testBench__DOT__clk = vlSelfRef.__VdlyVal__testBench__DOT__clk__v0;
    }
}

void VtestBench___024root___nba_sequent__TOP__2(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___nba_sequent__TOP__2\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out 
        = ((IData)(vlSelfRef.testBench__DOT__reset_n)
            ? (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_in)
            : 0U);
    vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_in 
        = ((4U == (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))
            ? 0U : (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))));
    vlSelfRef.testBench__DOT__clk_if = (1U > (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out));
    vlSelfRef.testBench__DOT__clk_id = (2U > (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out));
    vlSelfRef.testBench__DOT__clk_mem = (3U > (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out));
}

void VtestBench___024root___nba_sequent__TOP__3(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___nba_sequent__TOP__3\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VdlyVal__testBench__DOT__MEM__DOT__Memory__DOT__mem_array__v0;
    __VdlyVal__testBench__DOT__MEM__DOT__Memory__DOT__mem_array__v0 = 0;
    CData/*7:0*/ __VdlyDim0__testBench__DOT__MEM__DOT__Memory__DOT__mem_array__v0;
    __VdlyDim0__testBench__DOT__MEM__DOT__Memory__DOT__mem_array__v0 = 0;
    CData/*7:0*/ __VdlyDim0__testBench__DOT__MEM__DOT__Memory__DOT__mem_array__v1;
    __VdlyDim0__testBench__DOT__MEM__DOT__Memory__DOT__mem_array__v1 = 0;
    // Body
    if (vlSelfRef.testBench__DOT__reset_n) {
        if ((1U & (IData)(vlSelfRef.testBench__DOT__mem))) {
            __VdlyVal__testBench__DOT__MEM__DOT__Memory__DOT__mem_array__v0 
                = vlSelfRef.testBench__DOT__regData2;
            __VdlyDim0__testBench__DOT__MEM__DOT__Memory__DOT__mem_array__v0 
                = (0x000000ffU & (vlSelfRef.resultALU 
                                  >> 2U));
            vlSelfRef.__VdlyCommitQueuetestBench__DOT__MEM__DOT__Memory__DOT__mem_array.enqueue(__VdlyVal__testBench__DOT__MEM__DOT__Memory__DOT__mem_array__v0, (IData)(__VdlyDim0__testBench__DOT__MEM__DOT__Memory__DOT__mem_array__v0));
        }
    } else {
        vlSelfRef.testBench__DOT__MEM__DOT__Memory__DOT__unnamedblk1__DOT__i = 0U;
        while (VL_GTS_III(32, 0x00000100U, vlSelfRef.testBench__DOT__MEM__DOT__Memory__DOT__unnamedblk1__DOT__i)) {
            __VdlyDim0__testBench__DOT__MEM__DOT__Memory__DOT__mem_array__v1 
                = (0x000000ffU & vlSelfRef.testBench__DOT__MEM__DOT__Memory__DOT__unnamedblk1__DOT__i);
            vlSelfRef.__VdlyCommitQueuetestBench__DOT__MEM__DOT__Memory__DOT__mem_array.enqueue(0U, (IData)(__VdlyDim0__testBench__DOT__MEM__DOT__Memory__DOT__mem_array__v1));
            vlSelfRef.testBench__DOT__MEM__DOT__Memory__DOT__unnamedblk1__DOT__i 
                = ((IData)(1U) + vlSelfRef.testBench__DOT__MEM__DOT__Memory__DOT__unnamedblk1__DOT__i);
        }
    }
}

void VtestBench___024root___nba_sequent__TOP__4(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___nba_sequent__TOP__4\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VdfgRegularize_hebeb780c_0_0;
    __VdfgRegularize_hebeb780c_0_0 = 0;
    // Body
    vlSelfRef.testBench__DOT__instruction = (((((((
                                                   ((0U 
                                                     == vlSelfRef.testBench__DOT__IF__DOT__PCout) 
                                                    | (4U 
                                                       == vlSelfRef.testBench__DOT__IF__DOT__PCout)) 
                                                   | (8U 
                                                      == vlSelfRef.testBench__DOT__IF__DOT__PCout)) 
                                                  | (0x0000000cU 
                                                     == vlSelfRef.testBench__DOT__IF__DOT__PCout)) 
                                                 | (0x00000010U 
                                                    == vlSelfRef.testBench__DOT__IF__DOT__PCout)) 
                                                | (0x00000014U 
                                                   == vlSelfRef.testBench__DOT__IF__DOT__PCout)) 
                                               | (0x00000018U 
                                                  == vlSelfRef.testBench__DOT__IF__DOT__PCout)) 
                                              | (0x0000001cU 
                                                 == vlSelfRef.testBench__DOT__IF__DOT__PCout))
                                              ? ((0U 
                                                  == vlSelfRef.testBench__DOT__IF__DOT__PCout)
                                                  ? 0x00108093U
                                                  : 
                                                 ((4U 
                                                   == vlSelfRef.testBench__DOT__IF__DOT__PCout)
                                                   ? 0x00110113U
                                                   : 
                                                  ((8U 
                                                    == vlSelfRef.testBench__DOT__IF__DOT__PCout)
                                                    ? 0x03540413U
                                                    : 
                                                   ((0x0000000cU 
                                                     == vlSelfRef.testBench__DOT__IF__DOT__PCout)
                                                     ? 0x01b38393U
                                                     : 
                                                    ((0x00000010U 
                                                      == vlSelfRef.testBench__DOT__IF__DOT__PCout)
                                                      ? 0x009383b3U
                                                      : 
                                                     ((0x00000014U 
                                                       == vlSelfRef.testBench__DOT__IF__DOT__PCout)
                                                       ? 0x007404b3U
                                                       : 
                                                      ((0x00000018U 
                                                        == vlSelfRef.testBench__DOT__IF__DOT__PCout)
                                                        ? 0x408484b3U
                                                        : 0x002494b3U)))))))
                                              : ((0x00000020U 
                                                  == vlSelfRef.testBench__DOT__IF__DOT__PCout)
                                                  ? 0x402080b3U
                                                  : 
                                                 ((0x00000024U 
                                                   == vlSelfRef.testBench__DOT__IF__DOT__PCout)
                                                   ? 0xfe0086e3U
                                                   : 
                                                  ((0x00000028U 
                                                    == vlSelfRef.testBench__DOT__IF__DOT__PCout)
                                                    ? 0x00912223U
                                                    : 
                                                   ((0x0000002cU 
                                                     == vlSelfRef.testBench__DOT__IF__DOT__PCout)
                                                     ? 0x00412503U
                                                     : 0x00000033U)))));
    __VdfgRegularize_hebeb780c_0_0 = ((1U & vlSelfRef.testBench__DOT__instruction)
                                       ? 0U : vlSelfRef.testBench__DOT__instruction);
    if ((0x00000040U & vlSelfRef.testBench__DOT__instruction)) {
        vlSelfRef.wb = 0U;
        if ((0x00000020U & vlSelfRef.testBench__DOT__instruction)) {
            if ((0x00000010U & vlSelfRef.testBench__DOT__instruction)) {
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
                vlSelfRef.testBench__DOT__immediate 
                    = __VdfgRegularize_hebeb780c_0_0;
            } else if ((8U & vlSelfRef.testBench__DOT__instruction)) {
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
                vlSelfRef.testBench__DOT__immediate 
                    = __VdfgRegularize_hebeb780c_0_0;
            } else if ((4U & vlSelfRef.testBench__DOT__instruction)) {
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
                vlSelfRef.testBench__DOT__immediate 
                    = __VdfgRegularize_hebeb780c_0_0;
            } else if ((2U & vlSelfRef.testBench__DOT__instruction)) {
                if ((1U & vlSelfRef.testBench__DOT__instruction)) {
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                        = (0x0000001fU & (vlSelfRef.testBench__DOT__instruction 
                                          >> 0x0fU));
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                        = (0x0000001fU & (vlSelfRef.testBench__DOT__instruction 
                                          >> 0x14U));
                    vlSelfRef.testBench__DOT__ex = 
                        (0x00000800U | (0x00000380U 
                                        & (vlSelfRef.testBench__DOT__instruction 
                                           >> 5U)));
                    vlSelfRef.testBench__DOT__immediate 
                        = ((((2U & (vlSelfRef.testBench__DOT__instruction 
                                    >> 0x0000001eU)) 
                             | (1U & (vlSelfRef.testBench__DOT__instruction 
                                      >> 7U))) << 0x0000000bU) 
                           | ((0x000007e0U & (vlSelfRef.testBench__DOT__instruction 
                                              >> 0x00000014U)) 
                              | (0x0000001eU & (vlSelfRef.testBench__DOT__instruction 
                                                >> 7U))));
                } else {
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                        = (0x0000001fU & 0U);
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                        = (0x0000001fU & 0U);
                    vlSelfRef.testBench__DOT__ex = 
                        (0x00001000U | ((0x00000380U 
                                         & (vlSelfRef.testBench__DOT__instruction 
                                            >> 5U)) 
                                        | (vlSelfRef.testBench__DOT__instruction 
                                           >> 0x19U)));
                    vlSelfRef.testBench__DOT__immediate 
                        = __VdfgRegularize_hebeb780c_0_0;
                }
            } else {
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
                vlSelfRef.testBench__DOT__immediate 
                    = __VdfgRegularize_hebeb780c_0_0;
            }
        } else {
            vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                = (0x0000001fU & 0U);
            vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                = (0x0000001fU & 0U);
            vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                            | ((0x00000380U 
                                                & (vlSelfRef.testBench__DOT__instruction 
                                                   >> 5U)) 
                                               | (vlSelfRef.testBench__DOT__instruction 
                                                  >> 0x19U)));
            vlSelfRef.testBench__DOT__immediate = __VdfgRegularize_hebeb780c_0_0;
        }
    } else if ((0x00000020U & vlSelfRef.testBench__DOT__instruction)) {
        if ((0x00000010U & vlSelfRef.testBench__DOT__instruction)) {
            if ((8U & vlSelfRef.testBench__DOT__instruction)) {
                vlSelfRef.wb = 0U;
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
            } else if ((4U & vlSelfRef.testBench__DOT__instruction)) {
                vlSelfRef.wb = 0U;
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
            } else if ((2U & vlSelfRef.testBench__DOT__instruction)) {
                if ((1U & vlSelfRef.testBench__DOT__instruction)) {
                    vlSelfRef.wb = (0x00000040U | (0x0000001fU 
                                                   & (vlSelfRef.testBench__DOT__instruction 
                                                      >> 7U)));
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                        = (0x0000001fU & (vlSelfRef.testBench__DOT__instruction 
                                          >> 0x0fU));
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                        = (0x0000001fU & (vlSelfRef.testBench__DOT__instruction 
                                          >> 0x14U));
                    vlSelfRef.testBench__DOT__ex = 
                        (0x00001000U | ((0x00000380U 
                                         & (vlSelfRef.testBench__DOT__instruction 
                                            >> 5U)) 
                                        | (vlSelfRef.testBench__DOT__instruction 
                                           >> 0x19U)));
                } else {
                    vlSelfRef.wb = 0U;
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                        = (0x0000001fU & 0U);
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                        = (0x0000001fU & 0U);
                    vlSelfRef.testBench__DOT__ex = 
                        (0x00001000U | ((0x00000380U 
                                         & (vlSelfRef.testBench__DOT__instruction 
                                            >> 5U)) 
                                        | (vlSelfRef.testBench__DOT__instruction 
                                           >> 0x19U)));
                }
            } else {
                vlSelfRef.wb = 0U;
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
            }
            vlSelfRef.testBench__DOT__immediate = __VdfgRegularize_hebeb780c_0_0;
        } else {
            vlSelfRef.wb = 0U;
            if ((8U & vlSelfRef.testBench__DOT__instruction)) {
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
                vlSelfRef.testBench__DOT__immediate 
                    = __VdfgRegularize_hebeb780c_0_0;
            } else if ((4U & vlSelfRef.testBench__DOT__instruction)) {
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
                vlSelfRef.testBench__DOT__immediate 
                    = __VdfgRegularize_hebeb780c_0_0;
            } else if ((2U & vlSelfRef.testBench__DOT__instruction)) {
                if ((1U & vlSelfRef.testBench__DOT__instruction)) {
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                        = (0x0000001fU & (vlSelfRef.testBench__DOT__instruction 
                                          >> 0x0fU));
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                        = (0x0000001fU & (vlSelfRef.testBench__DOT__instruction 
                                          >> 0x14U));
                    vlSelfRef.testBench__DOT__ex = 
                        (0x00000400U | (0x00000380U 
                                        & (vlSelfRef.testBench__DOT__instruction 
                                           >> 5U)));
                    vlSelfRef.testBench__DOT__immediate 
                        = ((0x00000fe0U & (vlSelfRef.testBench__DOT__instruction 
                                           >> 0x00000014U)) 
                           | (0x0000001fU & (vlSelfRef.testBench__DOT__instruction 
                                             >> 7U)));
                } else {
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                        = (0x0000001fU & 0U);
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                        = (0x0000001fU & 0U);
                    vlSelfRef.testBench__DOT__ex = 
                        (0x00001000U | ((0x00000380U 
                                         & (vlSelfRef.testBench__DOT__instruction 
                                            >> 5U)) 
                                        | (vlSelfRef.testBench__DOT__instruction 
                                           >> 0x19U)));
                    vlSelfRef.testBench__DOT__immediate 
                        = __VdfgRegularize_hebeb780c_0_0;
                }
            } else {
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
                vlSelfRef.testBench__DOT__immediate 
                    = __VdfgRegularize_hebeb780c_0_0;
            }
        }
    } else {
        if ((0x00000010U & vlSelfRef.testBench__DOT__instruction)) {
            if ((8U & vlSelfRef.testBench__DOT__instruction)) {
                vlSelfRef.wb = 0U;
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
            } else if ((4U & vlSelfRef.testBench__DOT__instruction)) {
                vlSelfRef.wb = 0U;
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
            } else if ((2U & vlSelfRef.testBench__DOT__instruction)) {
                if ((1U & vlSelfRef.testBench__DOT__instruction)) {
                    vlSelfRef.wb = (0x00000040U | (0x0000001fU 
                                                   & (vlSelfRef.testBench__DOT__instruction 
                                                      >> 7U)));
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                        = (0x0000001fU & (vlSelfRef.testBench__DOT__instruction 
                                          >> 0x0fU));
                    vlSelfRef.testBench__DOT__ex = 
                        (0x00001400U | (0x00000380U 
                                        & (vlSelfRef.testBench__DOT__instruction 
                                           >> 5U)));
                } else {
                    vlSelfRef.wb = 0U;
                    vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                        = (0x0000001fU & 0U);
                    vlSelfRef.testBench__DOT__ex = 
                        (0x00001000U | ((0x00000380U 
                                         & (vlSelfRef.testBench__DOT__instruction 
                                            >> 5U)) 
                                        | (vlSelfRef.testBench__DOT__instruction 
                                           >> 0x19U)));
                }
            } else {
                vlSelfRef.wb = 0U;
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
            }
        } else if ((8U & vlSelfRef.testBench__DOT__instruction)) {
            vlSelfRef.wb = 0U;
            vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                = (0x0000001fU & 0U);
            vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                            | ((0x00000380U 
                                                & (vlSelfRef.testBench__DOT__instruction 
                                                   >> 5U)) 
                                               | (vlSelfRef.testBench__DOT__instruction 
                                                  >> 0x19U)));
        } else if ((4U & vlSelfRef.testBench__DOT__instruction)) {
            vlSelfRef.wb = 0U;
            vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                = (0x0000001fU & 0U);
            vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                            | ((0x00000380U 
                                                & (vlSelfRef.testBench__DOT__instruction 
                                                   >> 5U)) 
                                               | (vlSelfRef.testBench__DOT__instruction 
                                                  >> 0x19U)));
        } else if ((2U & vlSelfRef.testBench__DOT__instruction)) {
            if ((1U & vlSelfRef.testBench__DOT__instruction)) {
                vlSelfRef.wb = (0x00000060U | (0x0000001fU 
                                               & (vlSelfRef.testBench__DOT__instruction 
                                                  >> 7U)));
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & (vlSelfRef.testBench__DOT__instruction 
                                      >> 0x0fU));
                vlSelfRef.testBench__DOT__ex = (0x00000400U 
                                                | (0x00000380U 
                                                   & (vlSelfRef.testBench__DOT__instruction 
                                                      >> 5U)));
            } else {
                vlSelfRef.wb = 0U;
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & 0U);
                vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                                | ((0x00000380U 
                                                    & (vlSelfRef.testBench__DOT__instruction 
                                                       >> 5U)) 
                                                   | (vlSelfRef.testBench__DOT__instruction 
                                                      >> 0x19U)));
            }
        } else {
            vlSelfRef.wb = 0U;
            vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                = (0x0000001fU & 0U);
            vlSelfRef.testBench__DOT__ex = (0x00001000U 
                                            | ((0x00000380U 
                                                & (vlSelfRef.testBench__DOT__instruction 
                                                   >> 5U)) 
                                               | (vlSelfRef.testBench__DOT__instruction 
                                                  >> 0x19U)));
        }
        vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2 
            = (0x0000001fU & 0U);
        vlSelfRef.testBench__DOT__immediate = ((8U 
                                                & vlSelfRef.testBench__DOT__instruction)
                                                ? __VdfgRegularize_hebeb780c_0_0
                                                : (
                                                   (4U 
                                                    & vlSelfRef.testBench__DOT__instruction)
                                                    ? __VdfgRegularize_hebeb780c_0_0
                                                    : 
                                                   ((2U 
                                                     & vlSelfRef.testBench__DOT__instruction)
                                                     ? 
                                                    ((1U 
                                                      & vlSelfRef.testBench__DOT__instruction)
                                                      ? 
                                                     VL_SHIFTR_III(32,32,32, vlSelfRef.testBench__DOT__instruction, 0x00000014U)
                                                      : __VdfgRegularize_hebeb780c_0_0)
                                                     : __VdfgRegularize_hebeb780c_0_0)));
    }
    vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU 
        = ((0x00000c00U & ((IData)(vlSelfRef.testBench__DOT__ex) 
                           >> 1U)) | (0x000003ffU & (IData)(vlSelfRef.testBench__DOT__ex)));
    vlSelfRef.b = (0x0000ffffU & (((vlSelfRef.testBench__DOT__instruction 
                                    >> 0x00000010U) 
                                   | vlSelfRef.testBench__DOT__instruction) 
                                  | ((vlSelfRef.testBench__DOT__immediate 
                                      >> 0x00000010U) 
                                     | vlSelfRef.testBench__DOT__immediate)));
}

void VtestBench___024root___nba_sequent__TOP__5(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___nba_sequent__TOP__5\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if (vlSelfRef.testBench__DOT__reset_n) {
        if ((2U & (IData)(vlSelfRef.testBench__DOT__mem))) {
            vlSelfRef.readData = vlSelfRef.testBench__DOT__MEM__DOT__Memory__DOT__mem_array
                [(0x000000ffU & (vlSelfRef.resultALU 
                                 >> 2U))];
        }
    } else {
        vlSelfRef.readData = 0U;
    }
}

void VtestBench___024root___nba_sequent__TOP__6(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___nba_sequent__TOP__6\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.testBench__DOT__IF__DOT__PCout = ((IData)(vlSelfRef.testBench__DOT__reset_n)
                                                 ? vlSelfRef.testBench__DOT__IF__DOT__PCin
                                                 : 0U);
}

void VtestBench___024root___nba_comb__TOP__0(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___nba_comb__TOP__0\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.testBench__DOT__regData1 = ((0U == (IData)(vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1))
                                           ? 0U : vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs
                                          [vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1]);
    vlSelfRef.testBench__DOT__regData2 = ((0U == (IData)(vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2))
                                           ? 0U : vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs
                                          [vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2]);
    vlSelfRef.testBench__DOT__EX__DOT__w_B = ((0x00000400U 
                                               & (IData)(vlSelfRef.testBench__DOT__ex))
                                               ? vlSelfRef.testBench__DOT__immediate
                                               : vlSelfRef.testBench__DOT__regData2);
    vlSelfRef.resultALU = ((0U == (3U & ((IData)(vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU) 
                                         >> 0x0aU)))
                            ? (vlSelfRef.testBench__DOT__regData1 
                               + vlSelfRef.testBench__DOT__EX__DOT__w_B)
                            : ((1U == (3U & ((IData)(vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU) 
                                             >> 0x0aU)))
                                ? (vlSelfRef.testBench__DOT__regData1 
                                   - vlSelfRef.testBench__DOT__EX__DOT__w_B)
                                : ((2U == (3U & ((IData)(vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU) 
                                                 >> 0x0aU)))
                                    ? ((0x00000200U 
                                        & (IData)(vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU))
                                        ? ((0x00000100U 
                                            & (IData)(vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU))
                                            ? ((0x00000080U 
                                                & (IData)(vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU))
                                                ? (vlSelfRef.testBench__DOT__regData1 
                                                   & vlSelfRef.testBench__DOT__EX__DOT__w_B)
                                                : (vlSelfRef.testBench__DOT__regData1 
                                                   | vlSelfRef.testBench__DOT__EX__DOT__w_B))
                                            : 0U) : 
                                       ((0x00000100U 
                                         & (IData)(vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU))
                                         ? 0U : ((0x00000080U 
                                                  & (IData)(vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU))
                                                  ? 
                                                 (vlSelfRef.testBench__DOT__regData1 
                                                  << 
                                                  (0x0000001fU 
                                                   & vlSelfRef.testBench__DOT__EX__DOT__w_B))
                                                  : 
                                                 ((0U 
                                                   == 
                                                   (0x0000007fU 
                                                    & (IData)(vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU)))
                                                   ? 
                                                  (vlSelfRef.testBench__DOT__regData1 
                                                   + vlSelfRef.testBench__DOT__EX__DOT__w_B)
                                                   : 
                                                  ((0x20U 
                                                    == 
                                                    (0x0000007fU 
                                                     & (IData)(vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU)))
                                                    ? 
                                                   (vlSelfRef.testBench__DOT__regData1 
                                                    - vlSelfRef.testBench__DOT__EX__DOT__w_B)
                                                    : 0U)))))
                                    : 0U)));
    vlSelfRef.testBench__DOT__zero = (0U == vlSelfRef.resultALU);
}

void VtestBench___024root___nba_sequent__TOP__7(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___nba_sequent__TOP__7\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VdlyCommitQueuetestBench__DOT__MEM__DOT__Memory__DOT__mem_array.commit(vlSelfRef.testBench__DOT__MEM__DOT__Memory__DOT__mem_array);
}

void VtestBench___024root___nba_sequent__TOP__8(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___nba_sequent__TOP__8\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.testBench__DOT__mem = ((0x00000040U & vlSelfRef.testBench__DOT__instruction)
                                      ? ((0x00000020U 
                                          & vlSelfRef.testBench__DOT__instruction)
                                          ? ((0x00000010U 
                                              & vlSelfRef.testBench__DOT__instruction)
                                              ? 0U : 
                                             ((8U & vlSelfRef.testBench__DOT__instruction)
                                               ? 0U
                                               : ((4U 
                                                   & vlSelfRef.testBench__DOT__instruction)
                                                   ? 0U
                                                   : 
                                                  ((2U 
                                                    & vlSelfRef.testBench__DOT__instruction)
                                                    ? 
                                                   ((1U 
                                                     & vlSelfRef.testBench__DOT__instruction)
                                                     ? 4U
                                                     : 0U)
                                                    : 0U))))
                                          : 0U) : (
                                                   (0x00000020U 
                                                    & vlSelfRef.testBench__DOT__instruction)
                                                    ? 
                                                   ((0x00000010U 
                                                     & vlSelfRef.testBench__DOT__instruction)
                                                     ? 0U
                                                     : 
                                                    ((8U 
                                                      & vlSelfRef.testBench__DOT__instruction)
                                                      ? 0U
                                                      : 
                                                     ((4U 
                                                       & vlSelfRef.testBench__DOT__instruction)
                                                       ? 0U
                                                       : 
                                                      ((2U 
                                                        & vlSelfRef.testBench__DOT__instruction)
                                                        ? 
                                                       ((1U 
                                                         & vlSelfRef.testBench__DOT__instruction)
                                                         ? 1U
                                                         : 0U)
                                                        : 0U))))
                                                    : 
                                                   ((0x00000010U 
                                                     & vlSelfRef.testBench__DOT__instruction)
                                                     ? 0U
                                                     : 
                                                    ((8U 
                                                      & vlSelfRef.testBench__DOT__instruction)
                                                      ? 0U
                                                      : 
                                                     ((4U 
                                                       & vlSelfRef.testBench__DOT__instruction)
                                                       ? 0U
                                                       : 
                                                      ((2U 
                                                        & vlSelfRef.testBench__DOT__instruction)
                                                        ? 
                                                       ((1U 
                                                         & vlSelfRef.testBench__DOT__instruction)
                                                         ? 2U
                                                         : 0U)
                                                        : 0U))))));
}

void VtestBench___024root___nba_sequent__TOP__9(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___nba_sequent__TOP__9\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.testBench__DOT__reset_n = (1U & (~ (IData)(vlSelfRef.testBench__DOT__hit_reset)));
}

void VtestBench___024root___nba_comb__TOP__1(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___nba_comb__TOP__1\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.outAddr = (vlSelfRef.testBench__DOT__IF__DOT__PCout 
                         + ((0x00001000U & vlSelfRef.testBench__DOT__immediate)
                             ? (0xffffe000U | (0x00001fffU 
                                               & vlSelfRef.testBench__DOT__immediate))
                             : vlSelfRef.testBench__DOT__immediate));
}

void VtestBench___024root___nba_comb__TOP__2(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___nba_comb__TOP__2\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.testBench__DOT__IF__DOT__PCin = ((((IData)(vlSelfRef.testBench__DOT__mem) 
                                                 >> 2U) 
                                                & (IData)(vlSelfRef.testBench__DOT__zero))
                                                ? vlSelfRef.outAddr
                                                : ((IData)(4U) 
                                                   + vlSelfRef.testBench__DOT__IF__DOT__PCout));
}

void VtestBench___024root___eval_nba(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_nba\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((0x0000000000000012ULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        VtestBench___024root___nba_sequent__TOP__0(vlSelf);
        vlSelfRef.__Vm_traceActivity[1U] = 1U;
    }
    if ((0x0000000000000080ULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        VtestBench___024root___nba_sequent__TOP__1(vlSelf);
    }
    if ((3ULL & vlSelfRef.__VnbaTriggered[0U])) {
        VtestBench___024root___nba_sequent__TOP__2(vlSelf);
        vlSelfRef.__Vm_traceActivity[2U] = 1U;
    }
    if ((0x0000000000000042ULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        VtestBench___024root___nba_sequent__TOP__3(vlSelf);
    }
    if ((8ULL & vlSelfRef.__VnbaTriggered[0U])) {
        VtestBench___024root___nba_sequent__TOP__4(vlSelf);
        vlSelfRef.__Vm_traceActivity[3U] = 1U;
    }
    if ((0x0000000000000022ULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        VtestBench___024root___nba_sequent__TOP__5(vlSelf);
    }
    if ((6ULL & vlSelfRef.__VnbaTriggered[0U])) {
        VtestBench___024root___nba_sequent__TOP__6(vlSelf);
    }
    if ((0x000000000000001aULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        VtestBench___024root___nba_comb__TOP__0(vlSelf);
        vlSelfRef.__Vm_traceActivity[4U] = 1U;
    }
    if ((0x0000000000000042ULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        VtestBench___024root___nba_sequent__TOP__7(vlSelf);
    }
    if ((8ULL & vlSelfRef.__VnbaTriggered[0U])) {
        VtestBench___024root___nba_sequent__TOP__8(vlSelf);
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered[0U])) {
        VtestBench___024root___nba_sequent__TOP__9(vlSelf);
    }
    if ((0x000000000000000eULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        VtestBench___024root___nba_comb__TOP__1(vlSelf);
    }
    if ((0x000000000000001eULL & vlSelfRef.__VnbaTriggered
         [0U])) {
        VtestBench___024root___nba_comb__TOP__2(vlSelf);
    }
}

void VtestBench___024root___timing_resume(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___timing_resume\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((0x0000000000000080ULL & vlSelfRef.__VactTriggered
         [0U])) {
        vlSelfRef.__VdlySched.resume();
    }
}

void VtestBench___024root___trigger_orInto__act(VlUnpacked<QData/*63:0*/, 1> &out, const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___trigger_orInto__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = (out[n] | in[n]);
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool VtestBench___024root___eval_phase__act(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_phase__act\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VactExecute;
    // Body
    VtestBench___024root___eval_triggers__act(vlSelf);
    VtestBench___024root___trigger_orInto__act(vlSelfRef.__VnbaTriggered, vlSelfRef.__VactTriggered);
    __VactExecute = VtestBench___024root___trigger_anySet__act(vlSelfRef.__VactTriggered);
    if (__VactExecute) {
        VtestBench___024root___timing_resume(vlSelf);
    }
    return (__VactExecute);
}

void VtestBench___024root___trigger_clear__act(VlUnpacked<QData/*63:0*/, 1> &out) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___trigger_clear__act\n"); );
    // Locals
    IData/*31:0*/ n;
    // Body
    n = 0U;
    do {
        out[n] = 0ULL;
        n = ((IData)(1U) + n);
    } while ((1U > n));
}

bool VtestBench___024root___eval_phase__nba(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_phase__nba\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = VtestBench___024root___trigger_anySet__act(vlSelfRef.__VnbaTriggered);
    if (__VnbaExecute) {
        VtestBench___024root___eval_nba(vlSelf);
        VtestBench___024root___trigger_clear__act(vlSelfRef.__VnbaTriggered);
    }
    return (__VnbaExecute);
}

void VtestBench___024root___eval(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VnbaIterCount;
    // Body
    __VnbaIterCount = 0U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VnbaIterCount)))) {
#ifdef VL_DEBUG
            VtestBench___024root___dump_triggers__act(vlSelfRef.__VnbaTriggered, "nba"s);
#endif
            VL_FATAL_MT("src/testBench.sv", 1, "", "NBA region did not converge after 100 tries");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        vlSelfRef.__VactIterCount = 0U;
        do {
            if (VL_UNLIKELY(((0x00000064U < vlSelfRef.__VactIterCount)))) {
#ifdef VL_DEBUG
                VtestBench___024root___dump_triggers__act(vlSelfRef.__VactTriggered, "act"s);
#endif
                VL_FATAL_MT("src/testBench.sv", 1, "", "Active region did not converge after 100 tries");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
        } while (VtestBench___024root___eval_phase__act(vlSelf));
    } while (VtestBench___024root___eval_phase__nba(vlSelf));
}

#ifdef VL_DEBUG
void VtestBench___024root___eval_debug_assertions(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_debug_assertions\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
