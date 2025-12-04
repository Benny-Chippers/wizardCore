// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VtestBench.h for the primary calling header

#include "VtestBench__pch.h"

VL_ATTR_COLD void VtestBench___024root___eval_static(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_static\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
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
}

VL_ATTR_COLD void VtestBench___024root___eval_initial__TOP(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_initial__TOP\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.testBench__DOT__clk = 0U;
    vlSelfRef.testBench__DOT__reset_n = 0U;
    vlSelfRef.testBench__DOT__hit_reset = 0U;
    VL_WRITEF_NX("[%0t] Tracing to dump.vcd...\n\n",0,
                 64,VL_TIME_UNITED_Q(1),-12);
    vlSymsp->_vm_contextp__->dumpfile("dump.vcd"s);
    vlSymsp->_traceDumpOpen();
    VL_WRITEF_NX("[%0t] Model running...\n\n",0,64,
                 VL_TIME_UNITED_Q(1),-12);
}

VL_ATTR_COLD void VtestBench___024root___eval_final(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_final\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void VtestBench___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag);
#endif  // VL_DEBUG
VL_ATTR_COLD bool VtestBench___024root___eval_phase__stl(VtestBench___024root* vlSelf);

VL_ATTR_COLD void VtestBench___024root___eval_settle(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_settle\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VstlIterCount;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    do {
        if (VL_UNLIKELY(((0x00000064U < __VstlIterCount)))) {
#ifdef VL_DEBUG
            VtestBench___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
#endif
            VL_FATAL_MT("src/testBench.sv", 1, "", "Settle region did not converge after 100 tries");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
    } while (VtestBench___024root___eval_phase__stl(vlSelf));
}

VL_ATTR_COLD void VtestBench___024root___eval_triggers__stl(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_triggers__stl\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered[0U] = ((0xfffffffffffffffeULL 
                                      & vlSelfRef.__VstlTriggered
                                      [0U]) | (IData)((IData)(vlSelfRef.__VstlFirstIteration)));
    vlSelfRef.__VstlFirstIteration = 0U;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        VtestBench___024root___dump_triggers__stl(vlSelfRef.__VstlTriggered, "stl"s);
    }
#endif
}

VL_ATTR_COLD bool VtestBench___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void VtestBench___024root___dump_triggers__stl(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(VtestBench___024root___trigger_anySet__stl(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD bool VtestBench___024root___trigger_anySet__stl(const VlUnpacked<QData/*63:0*/, 1> &in) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___trigger_anySet__stl\n"); );
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

VL_ATTR_COLD void VtestBench___024root___stl_sequent__TOP__0(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___stl_sequent__TOP__0\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    IData/*31:0*/ __VdfgRegularize_hebeb780c_0_0;
    __VdfgRegularize_hebeb780c_0_0 = 0;
    // Body
    vlSelfRef.testBench__DOT__clk_if = (1U > (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out));
    vlSelfRef.testBench__DOT__clk_id = (2U > (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out));
    vlSelfRef.testBench__DOT__clk_mem = (3U > (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out));
    vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_in 
        = ((4U == (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))
            ? 0U : (0x0000ffffU & ((IData)(1U) + (IData)(vlSelfRef.testBench__DOT__CLK_GEN__DOT__w_clkData_out))));
    __VdfgRegularize_hebeb780c_0_0 = ((1U & vlSelfRef.testBench__DOT__instruction)
                                       ? 0U : vlSelfRef.testBench__DOT__instruction);
    if ((0x00000040U & vlSelfRef.testBench__DOT__instruction)) {
        vlSelfRef.wb = 0U;
        if ((0x00000020U & vlSelfRef.testBench__DOT__instruction)) {
            if ((0x00000010U & vlSelfRef.testBench__DOT__instruction)) {
                vlSelfRef.testBench__DOT__mem = 0U;
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
                vlSelfRef.testBench__DOT__mem = 0U;
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
                vlSelfRef.testBench__DOT__mem = 0U;
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
                    vlSelfRef.testBench__DOT__mem = 4U;
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
                    vlSelfRef.testBench__DOT__mem = 0U;
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
                vlSelfRef.testBench__DOT__mem = 0U;
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
            vlSelfRef.testBench__DOT__mem = 0U;
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
            vlSelfRef.testBench__DOT__mem = 0U;
            vlSelfRef.testBench__DOT__immediate = __VdfgRegularize_hebeb780c_0_0;
        } else {
            vlSelfRef.wb = 0U;
            if ((8U & vlSelfRef.testBench__DOT__instruction)) {
                vlSelfRef.testBench__DOT__mem = 0U;
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
                vlSelfRef.testBench__DOT__mem = 0U;
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
                    vlSelfRef.testBench__DOT__mem = 1U;
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
                    vlSelfRef.testBench__DOT__mem = 0U;
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
                vlSelfRef.testBench__DOT__mem = 0U;
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
            vlSelfRef.testBench__DOT__mem = 0U;
        } else if ((8U & vlSelfRef.testBench__DOT__instruction)) {
            vlSelfRef.wb = 0U;
            vlSelfRef.testBench__DOT__mem = 0U;
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
            vlSelfRef.testBench__DOT__mem = 0U;
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
                vlSelfRef.testBench__DOT__mem = 2U;
                vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1 
                    = (0x0000001fU & (vlSelfRef.testBench__DOT__instruction 
                                      >> 0x0fU));
                vlSelfRef.testBench__DOT__ex = (0x00000400U 
                                                | (0x00000380U 
                                                   & (vlSelfRef.testBench__DOT__instruction 
                                                      >> 5U)));
            } else {
                vlSelfRef.wb = 0U;
                vlSelfRef.testBench__DOT__mem = 0U;
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
            vlSelfRef.testBench__DOT__mem = 0U;
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
    vlSelfRef.testBench__DOT__regData1 = ((0U == (IData)(vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1))
                                           ? 0U : vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs
                                          [vlSelfRef.testBench__DOT__ID__DOT__w_rdReg1]);
    vlSelfRef.testBench__DOT__regData2 = ((0U == (IData)(vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2))
                                           ? 0U : vlSelfRef.testBench__DOT__ID__DOT__Reg__DOT__regs
                                          [vlSelfRef.testBench__DOT__ID__DOT__w_rdReg2]);
    vlSelfRef.testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU 
        = ((0x00000c00U & ((IData)(vlSelfRef.testBench__DOT__ex) 
                           >> 1U)) | (0x000003ffU & (IData)(vlSelfRef.testBench__DOT__ex)));
    vlSelfRef.b = (0x0000ffffU & (((vlSelfRef.testBench__DOT__instruction 
                                    >> 0x00000010U) 
                                   | vlSelfRef.testBench__DOT__instruction) 
                                  | ((vlSelfRef.testBench__DOT__immediate 
                                      >> 0x00000010U) 
                                     | vlSelfRef.testBench__DOT__immediate)));
    vlSelfRef.outAddr = (vlSelfRef.testBench__DOT__IF__DOT__PCout 
                         + ((0x00001000U & vlSelfRef.testBench__DOT__immediate)
                             ? (0xffffe000U | (0x00001fffU 
                                               & vlSelfRef.testBench__DOT__immediate))
                             : vlSelfRef.testBench__DOT__immediate));
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
    vlSelfRef.testBench__DOT__IF__DOT__PCin = ((((IData)(vlSelfRef.testBench__DOT__mem) 
                                                 >> 2U) 
                                                & (IData)(vlSelfRef.testBench__DOT__zero))
                                                ? vlSelfRef.outAddr
                                                : ((IData)(4U) 
                                                   + vlSelfRef.testBench__DOT__IF__DOT__PCout));
}

VL_ATTR_COLD void VtestBench___024root____Vm_traceActivitySetAll(VtestBench___024root* vlSelf);

VL_ATTR_COLD void VtestBench___024root___eval_stl(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_stl\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered[0U])) {
        VtestBench___024root___stl_sequent__TOP__0(vlSelf);
        VtestBench___024root____Vm_traceActivitySetAll(vlSelf);
    }
}

VL_ATTR_COLD bool VtestBench___024root___eval_phase__stl(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___eval_phase__stl\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Locals
    CData/*0:0*/ __VstlExecute;
    // Body
    VtestBench___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = VtestBench___024root___trigger_anySet__stl(vlSelfRef.__VstlTriggered);
    if (__VstlExecute) {
        VtestBench___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

bool VtestBench___024root___trigger_anySet__act(const VlUnpacked<QData/*63:0*/, 1> &in);

#ifdef VL_DEBUG
VL_ATTR_COLD void VtestBench___024root___dump_triggers__act(const VlUnpacked<QData/*63:0*/, 1> &triggers, const std::string &tag) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(VtestBench___024root___trigger_anySet__act(triggers))))) {
        VL_DBG_MSGS("         No '" + tag + "' region triggers active\n");
    }
    if ((1U & (IData)(triggers[0U]))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 0 is active: @(posedge testBench.clk)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 1U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 1 is active: @(negedge testBench.reset_n)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 2U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 2 is active: @(posedge testBench.clk_if)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 3U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 3 is active: @(negedge testBench.clk_if)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 4U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 4 is active: @(posedge testBench.clk_id)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 5U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 5 is active: @(negedge testBench.clk_mem)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 6U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 6 is active: @(posedge testBench.clk_mem)\n");
    }
    if ((1U & (IData)((triggers[0U] >> 7U)))) {
        VL_DBG_MSGS("         '" + tag + "' region trigger index 7 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void VtestBench___024root____Vm_traceActivitySetAll(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root____Vm_traceActivitySetAll\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__Vm_traceActivity[0U] = 1U;
    vlSelfRef.__Vm_traceActivity[1U] = 1U;
    vlSelfRef.__Vm_traceActivity[2U] = 1U;
    vlSelfRef.__Vm_traceActivity[3U] = 1U;
    vlSelfRef.__Vm_traceActivity[4U] = 1U;
}

VL_ATTR_COLD void VtestBench___024root___ctor_var_reset(VtestBench___024root* vlSelf) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VtestBench___024root___ctor_var_reset\n"); );
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    auto& vlSelfRef = std::ref(*vlSelf).get();
    // Body
    const uint64_t __VscopeHash = VL_MURMUR64_HASH(vlSelf->name());
    vlSelf->b = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 16900879642891266615ull);
    vlSelf->wb = VL_SCOPED_RAND_RESET_I(7, __VscopeHash, 17970158761716929289ull);
    vlSelf->outAddr = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 2096251957307142306ull);
    vlSelf->resultALU = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 16691824487910272488ull);
    vlSelf->readData = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 1468926445861151297ull);
    vlSelf->testBench__DOT__clk = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 18035612882241887392ull);
    vlSelf->testBench__DOT__reset_n = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16306089237216913586ull);
    vlSelf->testBench__DOT__hit_reset = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6284782728670509889ull);
    vlSelf->testBench__DOT__a = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 3922136951580664392ull);
    vlSelf->testBench__DOT__c_i = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 23187881931050396ull);
    vlSelf->testBench__DOT__instruction = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 16017995102216534828ull);
    vlSelf->testBench__DOT__immediate = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 16573913827977217079ull);
    vlSelf->testBench__DOT__regData1 = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 5141779880824421606ull);
    vlSelf->testBench__DOT__regData2 = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 12985153516474304956ull);
    vlSelf->testBench__DOT__zero = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 17223876733677949791ull);
    vlSelf->testBench__DOT__ex = VL_SCOPED_RAND_RESET_I(13, __VscopeHash, 10684134198560829368ull);
    vlSelf->testBench__DOT__mem = VL_SCOPED_RAND_RESET_I(3, __VscopeHash, 8820056416796983079ull);
    vlSelf->testBench__DOT__clk_if = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 16669536688259895003ull);
    vlSelf->testBench__DOT__clk_id = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 6323966558111042610ull);
    vlSelf->testBench__DOT__clk_mem = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 10529063851384056739ull);
    vlSelf->testBench__DOT__CLK_GEN__DOT__w_clkData_out = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 5855574429398224124ull);
    vlSelf->testBench__DOT__CLK_GEN__DOT__w_clkData_in = VL_SCOPED_RAND_RESET_I(16, __VscopeHash, 15334706772383389515ull);
    vlSelf->testBench__DOT__IF__DOT__PCin = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 3966950643163718672ull);
    vlSelf->testBench__DOT__IF__DOT__PCout = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 7158737778908695474ull);
    vlSelf->testBench__DOT__ID__DOT__w_rdReg1 = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 12645113173347667593ull);
    vlSelf->testBench__DOT__ID__DOT__w_rdReg2 = VL_SCOPED_RAND_RESET_I(5, __VscopeHash, 1368892980874567164ull);
    for (int __Vi0 = 0; __Vi0 < 32; ++__Vi0) {
        vlSelf->testBench__DOT__ID__DOT__Reg__DOT__regs[__Vi0] = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 13540947584761795746ull);
    }
    vlSelf->testBench__DOT__ID__DOT__Reg__DOT__unnamedblk1__DOT__i = 0;
    vlSelf->testBench__DOT__EX__DOT__w_B = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 5883527614877548007ull);
    vlSelf->testBench__DOT__EX__DOT__ALU__DOT__i_ctrlALU = VL_SCOPED_RAND_RESET_I(12, __VscopeHash, 8859550645253385859ull);
    for (int __Vi0 = 0; __Vi0 < 256; ++__Vi0) {
        vlSelf->testBench__DOT__MEM__DOT__Memory__DOT__mem_array[__Vi0] = VL_SCOPED_RAND_RESET_I(32, __VscopeHash, 17622799458989529860ull);
    }
    vlSelf->testBench__DOT__MEM__DOT__Memory__DOT__unnamedblk1__DOT__i = 0;
    vlSelf->__VdlyVal__testBench__DOT__clk__v0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8603347421784750487ull);
    vlSelf->__VdlySet__testBench__DOT__clk__v0 = 0;
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VstlTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VactTriggered[__Vi0] = 0;
    }
    vlSelf->__Vtrigprevexpr___TOP__testBench__DOT__clk__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 4556649801966276559ull);
    vlSelf->__Vtrigprevexpr___TOP__testBench__DOT__reset_n__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 1045373451071998589ull);
    vlSelf->__Vtrigprevexpr___TOP__testBench__DOT__clk_if__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 14557655129727511288ull);
    vlSelf->__Vtrigprevexpr___TOP__testBench__DOT__clk_id__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 8734245875544548683ull);
    vlSelf->__Vtrigprevexpr___TOP__testBench__DOT__clk_mem__0 = VL_SCOPED_RAND_RESET_I(1, __VscopeHash, 2311579819961125855ull);
    for (int __Vi0 = 0; __Vi0 < 1; ++__Vi0) {
        vlSelf->__VnbaTriggered[__Vi0] = 0;
    }
    for (int __Vi0 = 0; __Vi0 < 5; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
