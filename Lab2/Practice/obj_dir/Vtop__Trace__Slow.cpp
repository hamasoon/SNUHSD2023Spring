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
        tracep->declBus(c+4,"in_a", false,-1, 3,0);
        tracep->declBus(c+5,"in_b", false,-1, 3,0);
        tracep->declBus(c+6,"out_d", false,-1, 7,0);
        tracep->declBit(c+7,"out_d_valid", false,-1);
        tracep->declBit(c+8,"out_ovf", false,-1);
        tracep->declBit(c+9,"clk", false,-1);
        tracep->declBit(c+10,"in_init", false,-1);
        tracep->declBus(c+12,"my_pe BITWIDTH", false,-1, 31,0);
        tracep->declBus(c+13,"my_pe FAN_IN_BITS", false,-1, 31,0);
        tracep->declBus(c+14,"my_pe INIT", false,-1, 31,0);
        tracep->declBus(c+15,"my_pe EXEC", false,-1, 31,0);
        tracep->declBus(c+4,"my_pe in_a", false,-1, 3,0);
        tracep->declBus(c+5,"my_pe in_b", false,-1, 3,0);
        tracep->declBus(c+6,"my_pe out_d", false,-1, 7,0);
        tracep->declBit(c+7,"my_pe out_d_valid", false,-1);
        tracep->declBit(c+8,"my_pe out_ovf", false,-1);
        tracep->declBit(c+9,"my_pe clk", false,-1);
        tracep->declBit(c+10,"my_pe in_init", false,-1);
        tracep->declBit(c+1,"my_pe state", false,-1);
        tracep->declBus(c+2,"my_pe counter", false,-1, 2,0);
        tracep->declBus(c+12,"my_pe my_mac BITWIDTH", false,-1, 31,0);
        tracep->declBus(c+4,"my_pe my_mac in_a", false,-1, 3,0);
        tracep->declBit(c+1,"my_pe my_mac in_a_valid", false,-1);
        tracep->declBus(c+5,"my_pe my_mac in_b", false,-1, 3,0);
        tracep->declBit(c+1,"my_pe my_mac in_b_valid", false,-1);
        tracep->declBit(c+9,"my_pe my_mac clk", false,-1);
        tracep->declBit(c+10,"my_pe my_mac in_rst", false,-1);
        tracep->declBus(c+6,"my_pe my_mac out_d", false,-1, 7,0);
        tracep->declBit(c+8,"my_pe my_mac out_ovf", false,-1);
        tracep->declBit(c+3,"my_pe my_mac out_d_valid", false,-1);
        tracep->declBus(c+11,"my_pe my_mac multi", false,-1, 8,0);
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
        tracep->fullBit(oldp+1,(vlTOPp->my_pe__DOT__state));
        tracep->fullCData(oldp+2,(vlTOPp->my_pe__DOT__counter),3);
        tracep->fullBit(oldp+3,(vlTOPp->my_pe__DOT__my_mac__DOT__out_d_valid));
        tracep->fullCData(oldp+4,(vlTOPp->in_a),4);
        tracep->fullCData(oldp+5,(vlTOPp->in_b),4);
        tracep->fullCData(oldp+6,(vlTOPp->out_d),8);
        tracep->fullBit(oldp+7,(vlTOPp->out_d_valid));
        tracep->fullBit(oldp+8,(vlTOPp->out_ovf));
        tracep->fullBit(oldp+9,(vlTOPp->clk));
        tracep->fullBit(oldp+10,(vlTOPp->in_init));
        tracep->fullSData(oldp+11,(vlTOPp->my_pe__DOT__my_mac__DOT__multi),9);
        tracep->fullIData(oldp+12,(4U),32);
        tracep->fullIData(oldp+13,(3U),32);
        tracep->fullIData(oldp+14,(0U),32);
        tracep->fullIData(oldp+15,(1U),32);
    }
}
