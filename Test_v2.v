`timescale 1ns / 1ps

module gru_lstm_tb;

	// Inputs
//	reg [15:0] c_in;
	reg [7:0] h_in;
	reg [7:0] X;

	// Outputs
//	wire [15:0] c_out;
	wire [7:0] h_out;

	// Instantiate the Unit Under Test (UUT)
	gru_lstm uut (
		.h_in(h_in), 
		.X(X), 
		.h_out(h_out)
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
		
                #200;
		X=-8'h80;       
//		c_in=-16'h0100;    // c_in = -1
		h_in=8'h80;     

		$monitor("Output (After Activation):%d ",h_out);
		
		#200;
     		X=8'h10;
//		c_in=16'h0110;
		h_in=8'h11;

		$monitor("Output (After Activation):%d ",h_out);
		
		#200;
	 	X=-8'h10;
//		c_in=16'h0120;
		h_in=8'h11;

		$monitor("Output (After Activation):%d ",h_out);
		
		#200;
      		X=8'h01;
//		c_in=16'h0210;
		h_in=-8'h00;

		$monitor("Output (After Activation):%d ",h_out);

	end
      
endmodule
