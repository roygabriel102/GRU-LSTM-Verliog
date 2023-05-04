`timescale 1ns / 1ps

module gru_lstm_tb;

	// Inputs
//	reg [15:0] c_in;
	// All inputs are reconfigurable
    	parameter DATA_WIDTH = 8;
	parameter FRACT_WIDTH = 5;
	reg [DATA_WIDTH-1:0] h_in;
	reg [DATA_WIDTH-1:0] X;
	reg [DATA_WIDTH-1:0] Wz, Wr, Wh, Uz, Ur, Uh;
	reg [DATA_WIDTH-1:0] bz, br, bh;

	// Outputs
//	wire [15:0] c_out;
	wire [7:0] h_out;

	// Instantiate the Unit Under Test (UUT)
	gru_lstm_cell uut (
		.h_in(h_in), 
		.X(X), 
		.h_out(h_out),
		.Wz(Wz), .Wr(Wr), .Wh(Wh), .Uz(Uz), .Ur(Ur), .Uh(Uh), .bz(bz), .br(br), .bh(bh) //the weight bias were declared as inputs in main.
	);

	initial begin
		// Initialize Inputs
//		c_in = 0;
		h_in = 0;
		X = 0;

		// Wait 100 ns for global reset to finish
		// Take not too large inputs such that they don't overflow and give proper results after right shift
		// Preferably, take inputs <4 && >-4
		// First 8 bits are integeral part and last 8 bits are fractional
		// All Numbers are signed 
		
        #10;
		X=-8'h80;       
//		c_in=-16'h0100;    // c_in = -1
		h_in=8'h80;     

		$monitor("Output (After Activation):%d ",h_out);
		
		#10;
     		X=8'h10;
//		c_in=16'h0110;
		h_in=8'h11;

		$monitor("Output (After Activation):%d ",h_out);
		
		#10;
	 	X=-8'h10;
//		c_in=16'h0120;
		h_in=8'h11;

		$monitor("Output (After Activation):%d ",h_out);
		forever
		begin
		#10;
		//Randomized values for weights and bias
      		 X= $random;
      		Wz= $random;
      		Wr= $random;
      		Wh= $random;
      		Uz= $random;
      		Ur= $random; 
      		Uh= $random;
      		bz= $random;
      		br= $random;
      		bh= $random;
//		c_in=16'h0210;
		h_in=$random;

		$monitor("Output (After Activation):%d ",h_out);
        end
	end
      
endmodule
