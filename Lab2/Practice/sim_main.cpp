// Include common routines
#include <verilated.h>

// Include model header, generated from Verilating "top.v"
#include <cstdlib>

#include "Vtop.h"
#include "verilated_vcd_c.h"

int main(int argc, char** argv, char** env) {
    // Prevent unused variable warnings
    if (false && argc && argv && env) {
    }

    // Construct the Verilated model, from Vtop.h generated from Verilating
    // "top.v"
    Vtop* top = new Vtop;
    Verilated::traceEverOn(true);
    VerilatedVcdC* wave_fp = new VerilatedVcdC;
    int time = 0;
    top->trace(wave_fp, 1);

    wave_fp->open("./top.vcd");

    // test code
    top->clk = 0;
    top->eval();
    wave_fp->dump(time++);

    for (int i = 0; i < 16; ++i) {
        for (int j = 0; j < 32; ++j) {
            top->clk = !(top->clk);
            top->eval();
            if (top->clk) {  // posedge
                top->in_a = rand() % 16;
                top->in_b = rand() % 16;
                if (j / 2 == 15) {
                    top->in_init = 1;
                } else {
                    top->in_init = 0;
                }
            }
            wave_fp->dump(time++);
        }
    }

    // Final model cleanup
    top->final();
    wave_fp->close();

    // Destroy model
    delete top;
    delete wave_fp;

    // Fin
    exit(0);
}