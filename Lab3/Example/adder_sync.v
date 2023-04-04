/* Generated by Amaranth Yosys 0.25 (PyPI ver 0.25.0.0.post70, git sha1 e02b7f64b) */

(* \amaranth.hierarchy  = "top" *)
(* top =  1  *)
(* generator = "Amaranth" *)
module top(in_a, in_b, out_d, out_ovf, clk, rst, in_en);
  reg \$auto$verilog_backend.cc:2083:dump_module$2  = 0;
  wire [4:0] \$1 ;
  input clk;
  wire clk;
  input [3:0] in_a;
  wire [3:0] in_a;
  input [3:0] in_b;
  wire [3:0] in_b;
  input in_en;
  wire in_en;
  output [3:0] out_d;
  wire [3:0] out_d;
  output out_ovf;
  wire out_ovf;
  input rst;
  wire rst;
  reg [14:0] sim_delay = 15'h0000;
  reg [14:0] \sim_delay$next ;
  assign \$1  = in_a + in_b;
  always @(posedge clk)
    sim_delay <= \sim_delay$next ;
  always @* begin
    if begin end
    \sim_delay$next  = sim_delay;
    case (in_en)
      1'h1:
        begin
          \sim_delay$next [14:5] = sim_delay[9:0];
          \sim_delay$next [4:0] = \$1 ;
        end
    endcase

    case (rst)
      1'h1:
          \sim_delay$next  = 15'h0000;
    endcase
  end
  assign { out_ovf, out_d } = sim_delay[14:10];
endmodule