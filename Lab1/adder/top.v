module top #(
    parameter BITWIDTH = 4
)(
	input [BITWIDTH-1:0] in_a,	// 4-bits Input1
	input [BITWIDTH-1:0] in_b,	// 4-bits Input1
	output [BITWIDTH-1:0] out_d,// 4-bits Output
	output out_ovf				// Output for overflow
);
    assign {out_ovf, out_d} = in_a + in_b;
endmodule