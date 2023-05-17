`timescale 1ns / 1ps

module gru_lstm_tb;
//file_out.txt generated in C:\Users\*\Documents\GRU_LSTM\GRU_LSTM.sim\sim_1\behav\xsim
//Added fopen, fwriteb, and fclose for file handling
	// Inputs
   	parameter DATA_WIDTH = 16;
	parameter FRACT_WIDTH = 12;
	integer file_out;
	reg signed [DATA_WIDTH-1:0] h_in;
	reg signed [DATA_WIDTH-1:0] X;
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
file_out = $fopen("file_out.txt", "w");
h_in = 16'b00000100000000000;
X = 16'b00000001000000000;
Wz= 16'b0000010000000010;
Wr= 16'b0001010000000010;
Wh= 16'b0000010000000010;
Uz= 16'b0001010000000010;
Ur= 16'b0000010000000010; 
Uh= 16'b0001010000000010;
bz= 16'b0000010000000010;
br= 16'b0001010000000010;
bh= 16'b0000010000000010;


forever
begin
#5;
h_in=h_in;
 X= X + 16'b0000010000000000;
Wz= 16'b0000010000000000;
Wr= 16'b0001010000000010;
Wh= 16'b0000010000000000;
Uz= 16'b0001010000000010;
Ur= 16'b0000010000000000; 
Uh= 16'b0001010000000010;
bz= 16'b0000010000000000;
br= 16'b0001010000000010;
bh= 16'b0000010000000000;

//////////////////////For 8 bit Data Width (Begin)
//initial begin
//// Initialize Inputs
//file_out = $fopen("file_out.txt", "w");
//h_in = 8'b00010000;
//X = 8'b00000001;
//Wz= 8'b00001000;
//Wr= 8'b00101000;
//Wh= 8'b00001000;
//Uz= 8'b00101000;
//Ur= 8'b00001000; 
//Uh= 8'b00101000;
//bz= 8'b00001000;
//br= 8'b00101000;
//bh= 8'b00001000;



////////////////////////For 8 bit Data Width (End)
//forever
//begin
//#5;
//h_in=h_in;
// X= X + 8'b00000001;
////Wz= $random;
////Wr= $random;
////Wh= $random;
////Uz= $random;
////Ur= $random; 
////Uh= $random;
////bz= $random;
////br= $random;
////bh= $random;



$monitor("Output (After Activation):%d ",h_out);
$fdisplay(file_out, Wr*(2.0**-FRACT_WIDTH)," ",Wz*(2.0**-FRACT_WIDTH)," ",h_in*(2.0**-FRACT_WIDTH)," ",X*(2.0**-FRACT_WIDTH)," " , h_out*(2.0**-FRACT_WIDTH));
//$fwriteb(file_out,h_out,"\n");

end

end

initial begin
#2000 // Adjust timestop
$fclose(file_out);
$finish;
end
endmodule
