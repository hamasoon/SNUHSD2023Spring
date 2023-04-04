module half_adder (
    x, y, sum, c_out
);
    input x, y;
    output sum, c_out;

    assign c_out = x & y;
    assign sum = x ^ y;
endmodule