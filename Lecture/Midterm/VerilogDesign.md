Systolic Array Matrix Multiplication
====================================
- Done at 2n + 1 cycle
- Flow of input and output
- compare with other version
- systolic_array.v : interest in wiring output & input relationship
```verilog
module systolic_array(inp_west0, inp_west4, inp_west8, inp_west12,
		      inp_north0, inp_north1, inp_north2, inp_north3,
		      clk, rst, done);
	
	input [31:0] inp_west0, inp_west4, inp_west8, inp_west12,
		      inp_north0, inp_north1, inp_north2, inp_north3;
	output reg done;
	input clk, rst;
	reg [3:0] count;
	
	wire [31:0] inp_north0, inp_north1, inp_north2, inp_north3;
	wire [31:0] inp_west0, inp_west4, inp_west8, inp_west12;
	wire [31:0] outp_south0, outp_south1, outp_south2, outp_south3, outp_south4, outp_south5, outp_south6, outp_south7, outp_south8, outp_south9, outp_south10, outp_south11, outp_south12, outp_south13, outp_south14, outp_south15;
	wire [31:0] outp_east0, outp_east1, outp_east2, outp_east3, outp_east4, outp_east5, outp_east6, outp_east7, outp_east8, outp_east9, outp_east10, outp_east11, outp_east12, outp_east13, outp_east14, outp_east15;
	wire [63:0] result0, result1, result2, result3, result4, result5, result6, result7, result8, result9, result10, result11, result12, result13, result14, result15;
	
	//direct input 
	block P0 (inp_north0, inp_west0, clk, rst, outp_south0, outp_east0, result0);
	//from north
	block P1 (inp_north1, outp_east0, clk, rst, outp_south1, outp_east1, result1);
	block P2 (inp_north2, outp_east1, clk, rst, outp_south2, outp_east2, result2);
	block P3 (inp_north3, outp_east2, clk, rst, outp_south3, outp_east3, result3);
	
	//from west
	block P4 (outp_south0, inp_west4, clk, rst, outp_south4, outp_east4, result4);
	block P8 (outp_south4, inp_west8, clk, rst, outp_south8, outp_east8, result8);
	block P12 (outp_south8, inp_west12, clk, rst, outp_south12, outp_east12, result12);

    //indirect input : wiring
	//second row
	block P5 (outp_south1, outp_east4, clk, rst, outp_south5, outp_east5, result5);
	block P6 (outp_south2, outp_east5, clk, rst, outp_south6, outp_east6, result6);
	block P7 (outp_south3, outp_east6, clk, rst, outp_south7, outp_east7, result7);
	//third row
	block P9 (outp_south5, outp_east8, clk, rst, outp_south9, outp_east9, result9);
	block P10 (outp_south6, outp_east9, clk, rst, outp_south10, outp_east10, result10);
	block P11 (outp_south7, outp_east10, clk, rst, outp_south11, outp_east11, result11);
	//fourth row
	block P13 (outp_south9, outp_east12, clk, rst, outp_south13, outp_east13, result13);
	block P14 (outp_south10, outp_east13, clk, rst, outp_south14, outp_east14, result14);
	block P15 (outp_south11, outp_east14, clk, rst, outp_south15, outp_east15, result15);
	
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			done <= 0;
			count <= 0;
		end
		else begin
			if(count == 9) begin
				done <= 1;
				count <= 0;
			end
			else begin
				done <= 0;
				count <= count + 1;
			end
		end	
	end 
		      
endmodule
```

- block.v : related to PE of our lab - I will handle this topic in Lad.md
```verilog
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
```

Verilog
=======
##1. Generate Block

- generate Block
```verilog
    genvar i
    generate for (i = 0; i < SIZE; i++) begin: bit
        assign bin[i] = ^gray[SIZE-1:i]
    end endgenerate
```
- full adder with generate version 1
```verilog
module adder_nbit(x, y, c_in, sum, c_out);
...
    genvar i;
    wire [N-2:0] c;
    generate for (i = 0; i < SIZE;  i++) begin: adder
        if(i == 0) full_adder fa (x[i], y[i], c_in, sum[i], C[i]);
        else if (i == N-1) full_adder fa (x[i], y[i], C[i-1], sum[i], c_out);
        else full_adder fa (x[i], y[i], C[i-1], sum[i], C[i]);
    end endgenerate
```
- full adder with generate version 2
```verilog
module adder_nbit(x, y, c_in, sum, c_out); 
...
    genvar i;
    wire [N-2:0] c; // internal carries declared as nets.
    generate for (i = 0; i < N; i = i + 1) begin: adder
    if (i == 0) // specify LSB
        assign {C[i], sum[i]} = x[i] + y[i] + c_in;
    else if (i == N-1) // specify MSB
        assign {c_out, sum[i]} = x[i] + y[i] + c[i-1];
    else // specify other bits
        assign {C[i], sum[i]} = x[i] + y[i] + c[i-1];
    end endgenerate
```

##2. Grammar Errors
- Latch inference
  - MUST add default!!!!
- Asynchronous Reset D-Type Flip-Flops
```verilog
always @(posedge clk or negedge reset_n)
    if (!reset_n) q <= 0; // blocking!!!
    else q <= d;
```

TPU Systolic Execution
======================
- pre-stored input
- east forwarding input from west
- south forwarding input from north(partial sum with ***blocking!!!!***)

Matrix-Matrix Multiplication Accelerator
========================================
- each vector of matrix provide to 4 x 4 PE array at a same time
- repeat this 4-times and accumlate output
- after 4cycle, calculation done

Tensor Core
===========
- Same as MMMA but... use 4 * 4 * 4 PE array
- provide matrix's each vector to 4 * 4 PE array and using adder-tree to accumlate output of PE array
- So, output(16 dot product) is done at 1 cycle