module gru_lstm_cell(h_in, X, h_out);
	
	// X, c_in and h_in are assumed to be of 1x1. Change dimensions accordingly.
	
	//Parameters
	parameter DATA_WIDTH = 8;
	parameter FRACT_WIDTH = 5;
	//AW and DW should be equal to DATA_WIDTH ideally
	parameter AW = 8;			//for LUT memory size, ideally AW = DATA_WIDTH, is the exponential to determine amount of data elements, i.e. there will be 2^AW elements in the memory
	parameter DW = 8;			//for LUT memory size, datawidth for each element in the memory
	
	
	//h_in: tanh(o_in)
	input signed [DATA_WIDTH-1:0] h_in ;
	
    //X: current input
	input signed [DATA_WIDTH-1:0] X;
	
	//Weight arrays : {Wz, Wr, Wh, Uz, Ur, Uh} where each element will be of size 1 x 1
	wire signed [DATA_WIDTH-1:0] Wz, Wr, Wh, Uz, Ur, Uh;
	
	//Bias arrays : {bz, bu, bh} where each element will be of size 1 x 1
	wire signed [DATA_WIDTH-1:0] bz, br, bh;

    //Assign weights and biases
	//Random values assigned
	
	assign Wz=16'h0101;
	assign Wr=-16'h0101;
	assign Wh=16'h0101;

	assign Uz=16'h0101;
	assign Ur=-16'h0101;
	assign Uh=16'h0101;
	
	assign bz=16'h0101;
    assign br=-16'h0111;
	assign bh=16'h0101;

    //h_out : tanh(o_out)
	output wire signed [DATA_WIDTH-1:0] h_out;

    //function wires
	wire signed [DATA_WIDTH-1:0] zt, Zt, rt, Rt, ht, ht0, Ht, hto0, hto ;

	//functions
	ConcatMultAdd #(DATA_WIDTH, FRACT_WIDTH) C1 (X, h_in, Wz, Uz, bz, zt);
	ConcatMultAdd #(DATA_WIDTH, FRACT_WIDTH) C2 (X, h_in, Wr, Ur, br, rt);

	MultAdd #(DATA_WIDTH, FRACT_WIDTH) m1(Rt, h_in, bh, ht0);
	ConcatMultAdd #(DATA_WIDTH, FRACT_WIDTH) C3 (X, ht0, Wh, Uh, 0, ht);
	
	sigmoid_lut #(.AW(AW), .DW(DW), .N(DATA_WIDTH), .Q(FRACT_WIDTH)) s1(zt,Zt);
	sigmoid_lut #(.AW(AW), .DW(DW), .N(DATA_WIDTH), .Q(FRACT_WIDTH)) s2(rt,Rt);

	tanh_lut #(.AW(AW), .DW(DW), .N(DATA_WIDTH), .Q(FRACT_WIDTH)) t1(ht,Ht);

	wire cout1;
	carry_look_ahead_8bit a1(-1, Zt, 0, hto0, cout1); //is not n bit configurable (to fix)

	ConcatMultAdd #(DATA_WIDTH, FRACT_WIDTH) C4 (hto0, Zt, h_in, Ht, 0, hto);

	assign h_out = hto;
endmodule