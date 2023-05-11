`timescale 1ns / 1ps
module full_adder(A,B,Cin,Sum,Cout);
input A,B,Cin;
output Sum,Cout;

assign Sum = A^B^Cin;
assign Cout = A*B|A*Cin|B*Cin;
endmodule
