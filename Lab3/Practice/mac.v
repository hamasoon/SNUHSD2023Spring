/* Generated by Amaranth Yosys 0.25 (PyPI ver 0.25.0.0.post70, git sha1 e02b7f64b) */

(* \amaranth.hierarchy  = "top" *)
(* top =  1  *)
(* generator = "Amaranth" *)
module top(in_a_valid, in_b, in_b_valid, out_d, out_d_valid, out_ovf, clk, rst, in_a);
  reg \$auto$verilog_backend.cc:2083:dump_module$4  = 0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:30" *)
  wire [7:0] \$1 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:42" *)
  wire \$11 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:42" *)
  wire \$12 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:42" *)
  wire \$15 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:42" *)
  wire \$17 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:42" *)
  wire \$19 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:32" *)
  wire [8:0] \$3 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:35" *)
  wire \$5 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:35" *)
  wire \$7 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:35" *)
  wire \$9 ;
  (* src = "/usr/local/lib/python3.10/dist-packages/amaranth/hdl/ir.py:527" *)
  input clk;
  wire clk;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:24" *)
  wire [7:0] current_out;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:25" *)
  wire current_out_ovf;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:12" *)
  input [3:0] in_a;
  wire [3:0] in_a;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:13" *)
  input in_a_valid;
  wire in_a_valid;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:14" *)
  input [3:0] in_b;
  wire [3:0] in_b;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:15" *)
  input in_b_valid;
  wire in_b_valid;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:23" *)
  wire [7:0] mult;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:19" *)
  output [7:0] out_d;
  reg [7:0] out_d = 8'h00;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:19" *)
  reg [7:0] \out_d$next ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:20" *)
  output out_d_valid;
  reg out_d_valid = 1'h0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:20" *)
  reg \out_d_valid$next ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:21" *)
  output out_ovf;
  reg out_ovf = 1'h0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:21" *)
  reg \out_ovf$next ;
  (* src = "/usr/local/lib/python3.10/dist-packages/amaranth/hdl/ir.py:527" *)
  input rst;
  wire rst;
  assign \$9  = in_a_valid & (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:35" *) in_b_valid;
  assign \$12  = mult[7] ^ (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:42" *) out_d[7];
  assign \$11  = ~ (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:42" *) \$12 ;
  assign \$15  = mult[7] ^ (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:42" *) current_out[7];
  assign \$17  = \$11  & (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:42" *) \$15 ;
  assign \$1  = $signed(in_a) * (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:30" *) $signed(in_b);
  assign \$19  = \$17  | (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:42" *) out_ovf;
  assign \$3  = $signed(mult) + (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:32" *) $signed(out_d);
  assign \$5  = in_a_valid & (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:35" *) in_b_valid;
  assign \$7  = in_a_valid & (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:35" *) in_b_valid;
  always @(posedge clk)
    out_ovf <= \out_ovf$next ;
  always @(posedge clk)
    out_d_valid <= \out_d_valid$next ;
  always @(posedge clk)
    out_d <= \out_d$next ;
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$4 ) begin end
    \out_d$next  = out_d;
    (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:35" *)
    casez (\$5 )
      /* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:35" */
      1'h1:
          \out_d$next  = current_out;
    endcase
    (* src = "/usr/local/lib/python3.10/dist-packages/amaranth/hdl/xfrm.py:519" *)
    casez (rst)
      1'h1:
          \out_d$next  = 8'h00;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$4 ) begin end
    \out_d_valid$next  = out_d_valid;
    (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:35" *)
    casez (\$7 )
      /* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:35" */
      1'h1:
          \out_d_valid$next  = 1'h1;
    endcase
    (* src = "/usr/local/lib/python3.10/dist-packages/amaranth/hdl/xfrm.py:519" *)
    casez (rst)
      1'h1:
          \out_d_valid$next  = 1'h0;
    endcase
  end
  always @* begin
    if (\$auto$verilog_backend.cc:2083:dump_module$4 ) begin end
    \out_ovf$next  = out_ovf;
    (* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:35" *)
    casez (\$9 )
      /* src = "/data/Github/SNUHSD2023Spring/Lab3/Practice/mac.py:35" */
      1'h1:
          \out_ovf$next  = \$19 ;
    endcase
    (* src = "/usr/local/lib/python3.10/dist-packages/amaranth/hdl/xfrm.py:519" *)
    casez (rst)
      1'h1:
          \out_ovf$next  = 1'h0;
    endcase
  end
  assign { current_out_ovf, current_out } = \$3 ;
  assign mult = \$1 ;
endmodule
