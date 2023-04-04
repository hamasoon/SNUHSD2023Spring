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