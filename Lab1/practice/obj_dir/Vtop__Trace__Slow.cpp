// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vtop__Syms.h"


//======================

void Vtop::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addInitCb(&traceInit, __VlSymsp);
    traceRegister(tfp->spTrace());
}

void Vtop::traceInit(void* userp, VerilatedVcd* tracep, uint32_t code) {
    // Callback from tracep->open()
    Vtop__Syms* __restrict vlSymsp = static_cast<Vtop__Syms*>(userp);
    if (!Verilated::calcUnusedSigs()) {
        VL_FATAL_MT(__FILE__, __LINE__, __FILE__,
                        "Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vlSymsp->__Vm_baseCode = code;
    tracep->module(vlSymsp->name());
    tracep->scopeEscape(' ');
    Vtop::traceInitTop(vlSymsp, tracep);
    tracep->scopeEscape('.');
}

//======================


void Vtop::traceInitTop(void* userp, VerilatedVcd* tracep) {
    Vtop__Syms* __restrict vlSymsp = static_cast<Vtop__Syms*>(userp);
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlTOPp->traceInitSub0(userp, tracep);
    }
}

void Vtop::traceInitSub0(void* userp, VerilatedVcd* tracep) {
    Vtop__Syms* __restrict vlSymsp = static_cast<Vtop__Syms*>(userp);
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    const int c = vlSymsp->__Vm_baseCode;
    if (false && tracep && c) {}  // Prevent unused
    // Body
    {
        tracep->declBus(c+1,"in_a", false,-1, 3,0);
        tracep->declBit(c+2,"in_a_valid", false,-1);
        tracep->declBus(c+3,"in_b", false,-1, 3,0);
        tracep->declBit(c+4,"in_b_valid", false,-1);
        tracep->declBit(c+5,"clk", false,-1);
        tracep->declBit(c+6,"in_rst", false,-1);
        tracep->declBus(c+7,"out_d", false,-1, 7,0);
        tracep->declBit(c+8,"out_ovf", false,-1);
        tracep->declBit(c+9,"out_d_valid", false,-1);
        tracep->declBus(c+10,"temp", false,-1, 8,0);
        tracep->declBus(c+11,"my_mac BITWIDTH", false,-1, 31,0);
        tracep->declBus(c+1,"my_mac in_a", false,-1, 3,0);
        tracep->declBit(c+2,"my_mac in_a_valid", false,-1);
        tracep->declBus(c+3,"my_mac in_b", false,-1, 3,0);
        tracep->declBit(c+4,"my_mac in_b_valid", false,-1);
        tracep->declBit(c+5,"my_mac clk", false,-1);
        tracep->declBit(c+6,"my_mac in_rst", false,-1);
        tracep->declBus(c+7,"my_mac out_d", false,-1, 7,0);
        tracep->declBit(c+8,"my_mac out_ovf", false,-1);
        tracep->declBit(c+9,"my_mac out_d_valid", false,-1);
        tracep->declBus(c+10,"my_mac temp", false,-1, 8,0);
    }
}

void Vtop::traceRegister(VerilatedVcd* tracep) {
    // Body
    {
        tracep->addFullCb(&traceFullTop0, __VlSymsp);
        tracep->addChgCb(&traceChgTop0, __VlSymsp);
        tracep->addCleanupCb(&traceCleanup, __VlSymsp);
    }
}

void Vtop::traceFullTop0(void* userp, VerilatedVcd* tracep) {
    Vtop__Syms* __restrict vlSymsp = static_cast<Vtop__Syms*>(userp);
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    {
        vlTOPp->traceFullSub0(userp, tracep);
    }
}

void Vtop::traceFullSub0(void* userp, VerilatedVcd* tracep) {
    Vtop__Syms* __restrict vlSymsp = static_cast<Vtop__Syms*>(userp);
    Vtop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    vluint32_t* const oldp = tracep->oldp(vlSymsp->__Vm_baseCode);
    if (false && oldp) {}  // Prevent unused
    // Body
    {
        tracep->fullCData(oldp+1,(vlTOPp->in_a),4);
        tracep->fullBit(oldp+2,(vlTOPp->in_a_valid));
        tracep->fullCData(oldp+3,(vlTOPp->in_b),4);
        tracep->fullBit(oldp+4,(vlTOPp->in_b_valid));
        tracep->fullBit(oldp+5,(vlTOPp->clk));
        tracep->fullBit(oldp+6,(vlTOPp->in_rst));
        tracep->fullCData(oldp+7,(vlTOPp->out_d),8);
        tracep->fullBit(oldp+8,(vlTOPp->out_ovf));
        tracep->fullBit(oldp+9,(vlTOPp->out_d_valid));
        tracep->fullSData(oldp+10,(vlTOPp->temp),9);
        tracep->fullIData(oldp+11,(4U),32);
    }
}
