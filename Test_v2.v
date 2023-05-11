`timescale 1ns / 1ps

module gru_lstm_tb;
//file_out.txt generated in C:\Users\*\Documents\GRU_LSTM\GRU_LSTM.sim\sim_1\behav\xsim
//Added fopen, fwriteb, and fclose for file handling
	// Inputs
   	parameter DATA_WIDTH = 8;
	parameter FRACT_WIDTH = 5;
	integer file_out;
	reg [DATA_WIDTH-1:0] h_in;
	reg [DATA_WIDTH-1:0] X;
	reg [DATA_WIDTH-1:0] Wz, Wr, Wh, Uz, Ur, Uh;
	reg [DATA_WIDTH-1:0] bz, br, bh;


	// Outputs
	wire signed [DATA_WIDTH-1:0] h_out;

	// Instantiate the Unit Under Test (UUT)
gru_lstm_cell uut (
.h_in(h_in), 
.X(X), 
.h_out(h_out),
.Wz(Wz), .Wr(Wr), .Wh(Wh), .Uz(Uz), .Ur(Ur), .Uh(Uh), .bz(bz), .br(br), .bh(bh)
);

initial begin
// Initialize Inputs
h_in = 0;
X = 0;
Wz= $random;
Wr= $random;
Wh= $random;
Uz= $random;
Ur= $random; 
Uh= $random;
bz= $random;
br= $random;
bh= $random;
file_out = $fopen("file_out.txt", "w");


forever
begin
#10;
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
h_in=$random;


$monitor("Output (After Activation):%d ",h_out);
$fdisplay(file_out, h_out*(2.0**-FRACT_WIDTH));
//$fwriteb(file_out,h_out,"\n");

end

end

initial begin
#300 // Adjust timestop
$fclose(file_out);
$finish;
end
endmodule
