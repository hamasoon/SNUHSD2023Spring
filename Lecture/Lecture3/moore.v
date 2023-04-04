module vending_machine (
    N, D, reset, clk, open
);
    input       clk, reset, N, D;
    output  reg open;
    reg [1:0]   p_state, n_state;
    parameter   S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    // part1 initialize and reset logic
    always @(posedge clk or posedge reset) begin
        if(!reset) p_state <= A;  // sync - reset logic 
        else p_state <= n_state;    // sync - next state assign
    end

    // part2 next state logic
    always @(*) begin
        case(p_state)
            S0: if(N) n_state = S1; else if(D) n_state = S2; else n_state = p_state;
            S1: if(N) n_state = S2; else if(D) n_state = S3; else n_state = p_state;
            S2: if(N|D) n_state = S3; else n_state = p_state;
            S3: n_state = S0;
        endcase
    end

    // part3 output select logic - independent from input(only relate to state)
    always @(p_state) begin
        case (p_state)
            S0: open = 0;
            S1: open = 0;
            S2: open = 0;
            S3: open = 1;
        endcase
    end
endmodule