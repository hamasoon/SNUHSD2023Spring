module my_pe #(
	parameter BITWIDTH = 4,
  parameter FAN_IN_BITS = 3,
  parameter INIT = 0,
  parameter EXEC = 1
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
    reg [FAN_IN_BITS-1:0] counter;

    // TODO
    my_mac my_mac(
      .in_a(in_a),
      .in_a_valid(state),
      .in_b(in_b),
      .in_b_valid(state),
      .clk(clk),
      .in_rst(in_init),
      .out_d(out_d),
      .out_d_valid(),
      .out_ovf(out_ovf)
    );

    initial begin
      state = 0;
    end

    always @(posedge clk) begin
      // if INIT --> wait for in_init signal
      //             if in_init, state changes to EXEC
      case(state)
        INIT: if(in_init == 1) begin 
          state <= EXEC; out_d_valid = 0;
        end
        EXEC: if(counter == 2**FAN_IN_BITS - 1) begin
          state <= INIT; out_d_valid = 1;
        end
      endcase

      case(state)
        INIT: begin
        end
        EXEC: begin

          if(counter == 2**FAN_IN_BITS - 1) counter = 0;
          else counter = counter + 1;
          
        end
      endcase
  
    end

endmodule