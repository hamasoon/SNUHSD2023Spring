#include <verilated.h>

// Include model header, generated from Verilating "top.v"
#include "obj_dir/Vtop.h"
#include <verilated_vcd_c.h>

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

    for (int i = 0; i < 16; ++i) {
        for (int j = 0; j < 16; ++j) {
            top->in_a = i;  // set input1
            top->in_b = j;  // set input2
            top->eval();    // what?
            printf("%d + %d -> %d %d\n", i, j, top->out_ovf, top->out_d);
            wave_fp->dump(time++);  // what?
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