module sequence_detector_mealy (
    clk, reset_n, x, z
);
    input       clk, reset_n, x;
    output  reg z;
    reg [1:0]   p_state, n_state;
    parameter   A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // part1 initialize and reset logic
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n) p_state <= A;  // sync - reset logic 
        else p_state <= n_state;    // sync - next state assign
    end

    // part2 next state logic
    always @(p_state or x) begin
        case(p_state)
            A: if(x) n_state = A else n_state = B;
            B: if(x) n_state = C else n_state = B;
            C: if(x) n_state = A else n_state = D;
            D: if(x) n_state = C else n_state = B;
        endcase
    end

    // part3 output select logic - dependent to input (x)
    always @(p_state or x) begin
        case (p_state)
            A: if(x) z = 0 else z = 0;
            B: if(x) z = 0 else z = 0;
            C: if(x) z = 0 else z = 0;
            D: if(x) z = 1 else z = 0;
        endcase
    end

endmodule