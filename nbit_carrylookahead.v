`timescale 1ns / 1ps 
module nbit_carrylookahead(A,B,Sum,Cout);
  parameter WIDTH = 11;
  input [WIDTH-1:0] A,B;
  output [WIDTH-1:0] Sum;
  output Cout;
  
  wire [WIDTH:0]     w_C;
  wire [WIDTH-1:0]   w_G, w_P, w_SUM;
 
  // Create the Full Adders
  genvar             ii;
  generate
    for (ii=0; ii<WIDTH; ii=ii+1) 
      begin
        full_adder full_adder_inst
            ( 
              .A(A[ii]),
              .B(B[ii]),
              .Cin(w_C[ii]),
              .Sum(w_SUM[ii]),
              .Cout()
              );
      end
  endgenerate
 
  // Create the Generate (G) Terms:  Gi=Ai*Bi
  // Create the Propagate Terms: Pi=Ai+Bi
  // Create the Carry Terms:
  genvar             jj;
  generate
    for (jj=0; jj<WIDTH; jj=jj+1) 
      begin
        assign w_G[jj]   = A[jj] & B[jj];
        assign w_P[jj]   = A[jj] | B[jj];
        assign w_C[jj+1] = w_G[jj] | (w_P[jj] & w_C[jj]);
      end
  endgenerate
   
  assign w_C[0] = 1'b0; // no carry input on first adder
 
  assign Sum = w_SUM;   // Verilog Concatenation
  assign Cout = w_C[WIDTH];
endmodule // carry_lookahead_adder