module elevator (
  input clk,
  input in_signal,
  output out_red,
  output out_green
);
  reg state;

  initial begin
    state = 0;
  end

  assign out_red = ~state;
  assign out_green = state;

  always @(posedge clk) begin
    if (in_signal) begin
      state <= 1;
    end else begin
      state <= 0;
    end
  end
endmodule