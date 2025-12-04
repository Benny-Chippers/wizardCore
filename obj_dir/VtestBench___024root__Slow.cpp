// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VtestBench.h for the primary calling header

#include "VtestBench__pch.h"

void VtestBench___024root___ctor_var_reset(VtestBench___024root* vlSelf);

VtestBench___024root::VtestBench___024root(VtestBench__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    VtestBench___024root___ctor_var_reset(this);
}

void VtestBench___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

VtestBench___024root::~VtestBench___024root() {
}
