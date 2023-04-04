module adder_nbits (
    x, y, c_in, sum, c_out
);

    parameter BITWIDTH = 32

    input [BITWIDTH-1:0] x, y;
    input c_in;
    output [BITWIDTH-1:0] sum;
    output c_out;
    wire [BITWIDTH-2:0] C

    generate for (i = 0; i < N; i = i + 1) begin : adder
        if(i == 0) assign {C[i], sum[i]} = x[i] + y[i] + c_in;
        else if(i == N-1) assign {c_out, sum[i]} = x[i] + y[i] + C[i-1];
        else assign {C[i], sum[i]} = x[i] + y[i] + C[i-1];
    end     
    endgenerate

endmodule