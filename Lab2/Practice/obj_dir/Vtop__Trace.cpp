// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtop__Syms.h"


void Vtop::traceChgTop0(void* userp, VerilatedVcd* tracep) {
    Vtop__Syms* __restrict vlSymsp = static_cast<Vtop__Syms*>(userp);
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    {
        vlTOPp->traceChgSub0(userp, tracep);
    }
}

void Vtop::traceChgSub0(void* userp, VerilatedVcd* tracep) {
    Vtop__Syms* __restrict vlSymsp = static_cast<Vtop__Syms*>(userp);
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode + 1);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        if (VL_UNLIKELY(vlTOPp->__Vm_traceActivity[1U])) {
            tracep->chgBit(oldp+0,(vlTOPp->my_pe__DOT__state));
            tracep->chgCData(oldp+1,(vlTOPp->my_pe__DOT__counter),3);
            tracep->chgBit(oldp+2,(vlTOPp->my_pe__DOT__my_mac__DOT__out_d_valid));
        }
        tracep->chgCData(oldp+3,(vlTOPp->in_a),4);
        tracep->chgCData(oldp+4,(vlTOPp->in_b),4);
        tracep->chgCData(oldp+5,(vlTOPp->out_d),8);
        tracep->chgBit(oldp+6,(vlTOPp->out_d_valid));
        tracep->chgBit(oldp+7,(vlTOPp->out_ovf));
        tracep->chgBit(oldp+8,(vlTOPp->clk));
        tracep->chgBit(oldp+9,(vlTOPp->in_init));
        tracep->chgSData(oldp+10,(vlTOPp->my_pe__DOT__my_mac__DOT__multi),9);
    }
}

void Vtop::traceCleanup(void* userp, VerilatedVcd* /*unused*/) {
    Vtop__Syms* __restrict vlSymsp = static_cast<Vtop__Syms*>(userp);
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlSymsp->__Vm_activity = false;
        vlTOPp->__Vm_traceActivity[0U] = 0U;
        vlTOPp->__Vm_traceActivity[1U] = 0U;
    }
}
