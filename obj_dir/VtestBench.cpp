// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "VtestBench__pch.h"
#include "verilated_vcd_c.h"

//============================================================
// Constructors

VtestBench::VtestBench(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new VtestBench__Syms(contextp(), _vcname__, this)}
    , wb{vlSymsp->TOP.wb}
    , b{vlSymsp->TOP.b}
    , outAddr{vlSymsp->TOP.outAddr}
    , resultALU{vlSymsp->TOP.resultALU}
    , readData{vlSymsp->TOP.readData}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
    contextp()->traceBaseModelCbAdd(
        [this](VerilatedTraceBaseC* tfp, int levels, int options) { traceBaseModel(tfp, levels, options); });
}

VtestBench::VtestBench(const char* _vcname__)
    : VtestBench(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

VtestBench::~VtestBench() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void VtestBench___024root___eval_debug_assertions(VtestBench___024root* vlSelf);
#endif  // VL_DEBUG
void VtestBench___024root___eval_static(VtestBench___024root* vlSelf);
void VtestBench___024root___eval_initial(VtestBench___024root* vlSelf);
void VtestBench___024root___eval_settle(VtestBench___024root* vlSelf);
void VtestBench___024root___eval(VtestBench___024root* vlSelf);

void VtestBench::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VtestBench::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    VtestBench___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_activity = true;
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        VtestBench___024root___eval_static(&(vlSymsp->TOP));
        VtestBench___024root___eval_initial(&(vlSymsp->TOP));
        VtestBench___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    VtestBench___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

void VtestBench::eval_end_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+eval_end_step VtestBench::eval_end_step\n"); );
#ifdef VM_TRACE
    // Tracing
    if (VL_UNLIKELY(vlSymsp->__Vm_dumping)) vlSymsp->_traceDump();
#endif  // VM_TRACE
}

//============================================================
// Events and timing
bool VtestBench::eventsPending() { return !vlSymsp->TOP.__VdlySched.empty(); }

uint64_t VtestBench::nextTimeSlot() { return vlSymsp->TOP.__VdlySched.nextTimeSlot(); }

//============================================================
// Utilities

const char* VtestBench::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void VtestBench___024root___eval_final(VtestBench___024root* vlSelf);

VL_ATTR_COLD void VtestBench::final() {
    VtestBench___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* VtestBench::hierName() const { return vlSymsp->name(); }
const char* VtestBench::modelName() const { return "VtestBench"; }
unsigned VtestBench::threads() const { return 1; }
void VtestBench::prepareClone() const { contextp()->prepareClone(); }
void VtestBench::atClone() const {
    contextp()->threadPoolpOnClone();
}
std::unique_ptr<VerilatedTraceConfig> VtestBench::traceConfig() const {
    return std::unique_ptr<VerilatedTraceConfig>{new VerilatedTraceConfig{false, false, false}};
};

//============================================================
// Trace configuration

void VtestBench___024root__trace_decl_types(VerilatedVcd* tracep);

void VtestBench___024root__trace_init_top(VtestBench___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD static void trace_init(void* voidSelf, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    VtestBench___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<VtestBench___024root*>(voidSelf);
    VtestBench__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (!vlSymsp->_vm_contextp__->calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
            "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->pushPrefix(std::string{vlSymsp->name()}, VerilatedTracePrefixType::SCOPE_MODULE);
    VtestBench___024root__trace_decl_types(tracep);
    VtestBench___024root__trace_init_top(vlSelf, tracep);
    tracep->popPrefix();
}

VL_ATTR_COLD void VtestBench___024root__trace_register(VtestBench___024root* vlSelf, VerilatedVcd* tracep);

VL_ATTR_COLD void VtestBench::traceBaseModel(VerilatedTraceBaseC* tfp, int levels, int options) {
    (void)levels; (void)options;
    VerilatedVcdC* const stfp = dynamic_cast<VerilatedVcdC*>(tfp);
    if (VL_UNLIKELY(!stfp)) {
        vl_fatal(__FILE__, __LINE__, __FILE__,"'VtestBench::trace()' called on non-VerilatedVcdC object;"
            " use --trace-fst with VerilatedFst object, and --trace-vcd with VerilatedVcd object");
    }
    stfp->spTrace()->addModel(this);
    stfp->spTrace()->addInitCb(&trace_init, &(vlSymsp->TOP));
    VtestBench___024root__trace_register(&(vlSymsp->TOP), stfp->spTrace());
}
