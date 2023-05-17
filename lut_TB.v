`timescale 1ns / 1ps
module lut_TB;

    localparam n = 8;
    localparam q = 5;
    localparam AW = 8;
    localparam DW = 8;
    integer i;
    
    reg [n-1:0] a = 0;
    //reg Cin = 1;
    
    wire Cout;
    wire [n-1:0] y;
    
    //sigmoid_lut #(.AW(AW), .DW(DW), .DATA_WIDTH(n), .FRACT_WIDTH(q)) utt(a, y); 
    tanh_lut #(.AW(AW), .DW(DW), .DATA_WIDTH(n), .FRACT_WIDTH(q)) utt(a, y);
    
    initial begin
        for(i = 0; i < 2**n; i = i + 1) begin
                #(5) a = i;
        end
        $finish;
    end
    
endmodule
