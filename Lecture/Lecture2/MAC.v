// module for ovf checking, valid signal
module my_mac #(
	parameter BITWIDTH = 4
)
(
  input [BITWIDTH-1:0] in_a,
  input in_a_valid,
  input [BITWIDTH-1:0] in_b,
  input in_b_valid,
  input clk,
  input in_rst,
  output reg [2*BITWIDTH-1:0] out_d,
  output reg out_ovf,
  output reg out_d_valid,
  wire [2*BITWIDTH:0] temp
);

  assign temp = in_a * in_b + out_d;

  always @(posedge clk) begin
    if(in_rst) begin
      out_d <= 0;
      out_d_valid <= 0;
      out_ovf <= 0;
    end
    
    else begin
      if (in_a_valid & in_b_valid) begin
        out_d_valid <= 1;

        out_d <= temp[2*BITWIDTH-1:0];

        if(!out_ovf & temp[2*BITWIDTH]) begin
          out_ovf <= 1;
        end
      end
    end
  end
endmodule

//module doesn't consider ovf. why?
module block(inp_north, inp_west, clk, rst, outp_south, outp_east, result);
	input [31:0] inp_north, inp_west;
	output reg [31:0] outp_south, outp_east;
	input clk, rst;
	output reg [63:0] result;
	wire [63:0] multi;
	always @(posedge rst or posedge clk) begin
		if(rst) begin
			result <= 0;
			outp_east <= 0;
			outp_south <= 0;
		end
		else begin
			result <= result + multi;
			outp_east <= inp_west;
			outp_south <= inp_north;
		end
	end
	assign multi = inp_north*inp_west;
endmodule
