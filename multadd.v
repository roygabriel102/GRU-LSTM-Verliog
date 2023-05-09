module MultAdd(X, W0, b, out);	
	// Concatenates and Adds
	// incoming data signed and fixed width
	parameter DATA_WIDTH = 16;
	parameter FRACT_WIDTH = 8;
	
	input signed [DATA_WIDTH-1:0] X;
	input signed [DATA_WIDTH-1:0] W0, b;
	output signed [DATA_WIDTH-1:0] out;

	// internal regs/wires
	wire signed [DATA_WIDTH-1:0] p1;
	wire cout;
	
	// behavior: out = W*{x,h_in} + b where W={W0,W1}
	qmult #(DATA_WIDTH, FRACT_WIDTH) m1 (X,W0, p1, );

	nbit_carrylookahead #(.WIDTH(DATA_WIDTH)) a1 (p1, b, 1'b0, out1, cout);	

	assign out = out1;

endmodule