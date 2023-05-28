/* Generated by Amaranth Yosys 0.25 (PyPI ver 0.25.0.0.post70, git sha1 e02b7f64b) */

(* \amaranth.hierarchy  = "top" *)
(* top =  1  *)
(* generator = "Amaranth" *)
module top(in_data_4_1, in_data_4_2, in_data_4_3, in_ovf_4_0, in_ovf_4_1, in_ovf_4_2, in_ovf_4_3, in_valid_4_0, in_valid_4_1, in_valid_4_2, in_valid_4_3, out_d, out_ovf, out_valid, in_data_4_0);
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:49" *)
  wire [8:0] \$1 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:56" *)
  wire \$11 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:55" *)
  wire \$13 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:55" *)
  wire \$15 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:55" *)
  wire \$17 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:50" *)
  wire \$19 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:51" *)
  wire \$3 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:51" *)
  wire \$5 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:55" *)
  wire \$7 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:55" *)
  wire \$8 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:18" *)
  input [7:0] in_data_4_0;
  wire [7:0] in_data_4_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:18" *)
  input [7:0] in_data_4_1;
  wire [7:0] in_data_4_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:18" *)
  input [7:0] in_data_4_2;
  wire [7:0] in_data_4_2;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:18" *)
  input [7:0] in_data_4_3;
  wire [7:0] in_data_4_3;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:20" *)
  input in_ovf_4_0;
  wire in_ovf_4_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:20" *)
  input in_ovf_4_1;
  wire in_ovf_4_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:20" *)
  input in_ovf_4_2;
  wire in_ovf_4_2;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:20" *)
  input in_ovf_4_3;
  wire in_ovf_4_3;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:22" *)
  input in_valid_4_0;
  wire in_valid_4_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:22" *)
  input in_valid_4_1;
  wire in_valid_4_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:22" *)
  input in_valid_4_2;
  wire in_valid_4_2;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:22" *)
  input in_valid_4_3;
  wire in_valid_4_3;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:24" *)
  output [7:0] out_d;
  wire [7:0] out_d;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:25" *)
  output out_ovf;
  wire out_ovf;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:26" *)
  output out_valid;
  wire out_valid;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:18" *)
  wire [7:0] tree_l_in_data_2_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:18" *)
  wire [7:0] tree_l_in_data_2_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:20" *)
  wire tree_l_in_ovf_2_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:20" *)
  wire tree_l_in_ovf_2_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:22" *)
  wire tree_l_in_valid_2_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:22" *)
  wire tree_l_in_valid_2_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:24" *)
  wire [7:0] tree_l_out_d;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:25" *)
  wire tree_l_out_ovf;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:26" *)
  wire tree_l_out_valid;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:18" *)
  wire [7:0] tree_r_in_data_2_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:18" *)
  wire [7:0] tree_r_in_data_2_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:20" *)
  wire tree_r_in_ovf_2_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:20" *)
  wire tree_r_in_ovf_2_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:22" *)
  wire tree_r_in_valid_2_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:22" *)
  wire tree_r_in_valid_2_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:24" *)
  wire [7:0] tree_r_out_d;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:25" *)
  wire tree_r_out_ovf;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:26" *)
  wire tree_r_out_valid;
  assign \$7  = ~ (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:55" *) \$8 ;
  assign \$11  = tree_l_out_d[7] ^ (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:56" *) out_d[7];
  assign \$13  = \$7  & (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:55" *) \$11 ;
  assign \$15  = \$13  | (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:55" *) tree_l_out_ovf;
  assign \$17  = \$15  | (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:55" *) tree_r_out_ovf;
  assign \$1  = $signed(tree_l_out_d) + (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:49" *) $signed(tree_r_out_d);
  assign \$19  = tree_l_out_valid & (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:50" *) tree_r_out_valid;
  assign \$3  = tree_l_out_ovf | (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:51" *) tree_r_out_ovf;
  assign \$5  = \$3  | (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:51" *) out_ovf;
  assign \$8  = tree_l_out_d[7] ^ (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:55" *) tree_r_out_d[7];
  tree_l tree_l (
    .in_data_2_0(tree_l_in_data_2_0),
    .in_data_2_1(tree_l_in_data_2_1),
    .in_ovf_2_0(tree_l_in_ovf_2_0),
    .in_ovf_2_1(tree_l_in_ovf_2_1),
    .in_valid_2_0(tree_l_in_valid_2_0),
    .in_valid_2_1(tree_l_in_valid_2_1),
    .out_d(tree_l_out_d),
    .out_ovf(tree_l_out_ovf),
    .out_valid(tree_l_out_valid)
  );
  tree_r tree_r (
    .in_data_2_0(tree_r_in_data_2_0),
    .in_data_2_1(tree_r_in_data_2_1),
    .in_ovf_2_0(tree_r_in_ovf_2_0),
    .in_ovf_2_1(tree_r_in_ovf_2_1),
    .in_valid_2_0(tree_r_in_valid_2_0),
    .in_valid_2_1(tree_r_in_valid_2_1),
    .out_d(tree_r_out_d),
    .out_ovf(tree_r_out_ovf),
    .out_valid(tree_r_out_valid)
  );
  assign out_valid = \$19 ;
  assign out_ovf = \$17 ;
  assign out_d = \$1 [7:0];
  assign tree_r_in_ovf_2_1 = in_ovf_4_3;
  assign tree_l_in_ovf_2_1 = in_ovf_4_1;
  assign tree_r_in_valid_2_1 = in_valid_4_3;
  assign tree_l_in_valid_2_1 = in_valid_4_1;
  assign tree_r_in_data_2_1 = in_data_4_3;
  assign tree_l_in_data_2_1 = in_data_4_1;
  assign tree_r_in_ovf_2_0 = in_ovf_4_2;
  assign tree_l_in_ovf_2_0 = in_ovf_4_0;
  assign tree_r_in_valid_2_0 = in_valid_4_2;
  assign tree_l_in_valid_2_0 = in_valid_4_0;
  assign tree_r_in_data_2_0 = in_data_4_2;
  assign tree_l_in_data_2_0 = in_data_4_0;
endmodule

(* \amaranth.hierarchy  = "top.tree_l" *)
(* generator = "Amaranth" *)
module tree_l(in_valid_2_0, in_ovf_2_0, in_data_2_1, in_valid_2_1, in_ovf_2_1, out_d, out_valid, out_ovf, in_data_2_0);
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:61" *)
  wire \$1 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *)
  wire \$10 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:68" *)
  wire \$13 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *)
  wire \$15 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *)
  wire \$17 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *)
  wire \$19 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:62" *)
  wire [8:0] \$3 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:63" *)
  wire \$5 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:63" *)
  wire \$7 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *)
  wire \$9 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:18" *)
  input [7:0] in_data_2_0;
  wire [7:0] in_data_2_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:18" *)
  input [7:0] in_data_2_1;
  wire [7:0] in_data_2_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:20" *)
  input in_ovf_2_0;
  wire in_ovf_2_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:20" *)
  input in_ovf_2_1;
  wire in_ovf_2_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:22" *)
  input in_valid_2_0;
  wire in_valid_2_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:22" *)
  input in_valid_2_1;
  wire in_valid_2_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:24" *)
  output [7:0] out_d;
  wire [7:0] out_d;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:25" *)
  output out_ovf;
  wire out_ovf;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:26" *)
  output out_valid;
  wire out_valid;
  assign \$10  = in_data_2_0[7] ^ (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *) in_data_2_1[7];
  assign \$9  = ~ (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *) \$10 ;
  assign \$13  = in_data_2_0[7] ^ (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:68" *) out_d[7];
  assign \$15  = \$9  & (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *) \$13 ;
  assign \$17  = \$15  | (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *) in_ovf_2_0;
  assign \$1  = in_valid_2_0 & (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:61" *) in_valid_2_1;
  assign \$19  = \$17  | (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *) in_ovf_2_1;
  assign \$3  = $signed(in_data_2_0) + (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:62" *) $signed(in_data_2_1);
  assign \$5  = in_ovf_2_0 | (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:63" *) in_ovf_2_1;
  assign \$7  = \$5  | (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:63" *) out_ovf;
  assign out_ovf = \$19 ;
  assign out_d = \$3 [7:0];
  assign out_valid = \$1 ;
endmodule

(* \amaranth.hierarchy  = "top.tree_r" *)
(* generator = "Amaranth" *)
module tree_r(in_valid_2_0, in_ovf_2_0, in_data_2_1, in_valid_2_1, in_ovf_2_1, out_d, out_valid, out_ovf, in_data_2_0);
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:61" *)
  wire \$1 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *)
  wire \$10 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:68" *)
  wire \$13 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *)
  wire \$15 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *)
  wire \$17 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *)
  wire \$19 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:62" *)
  wire [8:0] \$3 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:63" *)
  wire \$5 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:63" *)
  wire \$7 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *)
  wire \$9 ;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:18" *)
  input [7:0] in_data_2_0;
  wire [7:0] in_data_2_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:18" *)
  input [7:0] in_data_2_1;
  wire [7:0] in_data_2_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:20" *)
  input in_ovf_2_0;
  wire in_ovf_2_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:20" *)
  input in_ovf_2_1;
  wire in_ovf_2_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:22" *)
  input in_valid_2_0;
  wire in_valid_2_0;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:22" *)
  input in_valid_2_1;
  wire in_valid_2_1;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:24" *)
  output [7:0] out_d;
  wire [7:0] out_d;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:25" *)
  output out_ovf;
  wire out_ovf;
  (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:26" *)
  output out_valid;
  wire out_valid;
  assign \$10  = in_data_2_0[7] ^ (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *) in_data_2_1[7];
  assign \$9  = ~ (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *) \$10 ;
  assign \$13  = in_data_2_0[7] ^ (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:68" *) out_d[7];
  assign \$15  = \$9  & (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *) \$13 ;
  assign \$17  = \$15  | (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *) in_ovf_2_0;
  assign \$1  = in_valid_2_0 & (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:61" *) in_valid_2_1;
  assign \$19  = \$17  | (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:67" *) in_ovf_2_1;
  assign \$3  = $signed(in_data_2_0) + (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:62" *) $signed(in_data_2_1);
  assign \$5  = in_ovf_2_0 | (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:63" *) in_ovf_2_1;
  assign \$7  = \$5  | (* src = "/data/Github/SNUHSD2023Spring/Lab4/Practice/adder_tree.py:63" *) out_ovf;
  assign out_ovf = \$19 ;
  assign out_d = \$3 [7:0];
  assign out_valid = \$1 ;
endmodule