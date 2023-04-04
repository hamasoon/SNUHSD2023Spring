module my_pe #(
	parameter BITWIDTH = 4,
  parameter FAN_IN_BITS = 3
)
(
  input [BITWIDTH-1:0] in_a,
  input [BITWIDTH-1:0] in_b,
  output [2*BITWIDTH-1:0] out_d,
  output reg out_d_valid,
  output out_ovf,
  input clk,
  input in_init
);
    // state == 0 --> INIT
    // state == 1 --> EXEC
    reg state;

    // TODO
    my_mac my_mac(
      .in_a(),
      .in_a_valid(),
      .in_b(),
      .in_b_valid(),
      .clk(clk),
      .in_rst(),
      .out_d(),
      .out_d_valid(),
      .out_ovf()
    );

    initial begin
      state = 0;
    end

    always @(posedge clk) begin
      // if INIT --> wait for in_init signal
      //             if in_init, state changes to EXEC
      if (state == 0) begin
        // TODO INIT
      end else begin
        // TODO EXEC
      end
    end
endmodule