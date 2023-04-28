module ConcatMultAdd(X, h_in, W0, W1, b, out);	
	// Concatenates and Adds
	// incoming data signed and fixed width
	parameter DATA_WIDTH = 16;
	parameter FRACT_WIDTH = 8;
	
	input signed [DATA_WIDTH-1:0] X, h_in;
	input signed [DATA_WIDTH-1:0] W0, W1, b;
	output signed [DATA_WIDTH-1:0] out;

	// internal regs/wires
	wire signed [DATA_WIDTH+DATA_WIDTH-1:0] p1,p2;
	wire signed [DATA_WIDTH+DATA_WIDTH-1:0] temp;
	wire cout, cout2;
	
	// behavior: out = W*{x,h_in} + b where W={W0,W1}
	qmult #(DATA_WIDTH, FRACT_WIDTH) m1 (X,W0, p1, );
	qmult #(DATA_WIDTH, FRACT_WIDTH) m2 (h_in, W1, p2, );

	carry_look_ahead_8bit a1 (p1, p2, 1'b0, temp, cout);	//is not n bit configurable (to fix)
	carry_look_ahead_8bit a2 (temp, b, cout, out1, cout2);	//is not n bit configurable (to fix)

	assign out = out1;
/*
	//Old code to remove
	assign p1 = (W0*X)>>>FRACT_WIDTH; 
	assign p2 = (W1*h_in)>>>FRACT_WIDTH;
	assign out = p1 + p2 + b;
*/
endmodule
