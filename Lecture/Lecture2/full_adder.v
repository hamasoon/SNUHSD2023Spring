`include "half_adder.v"
module full_adder (
    x, y, c_in, sum, c_out
);
    input x, y, c_in;
    output sum, c_out;
    wire temp1, temp2, temp3;

    half_adder ha1(x, y, temp1, temp2);
    half_adder ha2(temp1, c_in, sum, temp3);
    assign c_out = temp2 | temp3;

endmodule