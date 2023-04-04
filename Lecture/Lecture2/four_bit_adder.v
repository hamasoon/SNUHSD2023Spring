`include "full_adder.v"
module four_bit_adder (
    x, y, c_in, sum, c_out
);
    input [3:0] x, y;
    input c_in;
    output [3:0] sum;
    output c_out;
    wire temp1, temp2, temp3;

    full_adder fa1(x[0], y[0], c_in, sum[0], temp1);
    full_adder fa2(x[1], y[1], temp1, sum[1], temp2);
    full_adder fa3(x[2], y[2], temp2, sum[2], temp3);
    full_adder fa4(x[3], y[3], temp3, sum[3], c_out);

endmodule