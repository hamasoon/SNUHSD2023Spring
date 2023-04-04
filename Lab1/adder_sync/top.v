module top #(
   parameter BITWIDTH = 4
)(
	input clk,
	input [BITWIDTH-1:0] in_a,
	input [BITWIDTH-1:0] in_b,
	output reg [BITWIDTH-1:0] out_d,
	output reg out_ovf
);
	always @ (posedge clk) begin
		{out_ovf, out_d} <= in_a + in_b;
	end
endmodule