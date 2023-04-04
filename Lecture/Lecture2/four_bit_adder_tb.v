`timescale 1ns / 100 ps  // time unit / precision
`include "four_bit_adder.v"
module four_bit_adder_tb;
//Internal signals declarations:
reg [3:0] x;
reg [3:0] y;
reg c_in;
wire [3:0] sum;
wire c_out;
// Unit Under Test port map
    four_bit_adder UUT (.x(x), .y(y), .c_in(c_in), .sum(sum), .c_out(c_out));
reg [7:0] i;

initial 
   for (i = 0; i <= 255; i = i + 1) begin
        x[3:0] = i[7:4]; y[3:0] = i[3:0]; c_in =1'b0;
   #20 ;   end
endmodule