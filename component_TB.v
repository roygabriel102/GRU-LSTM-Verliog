`timescale 1ns / 1ps
module ComponentN_TB;

    localparam n = 4;
    localparam q = 2;
    integer i, j;
    
    reg [n-1:0] a = 0, b = 0;
    //reg Cin = 1;
    
    wire Cout;
    wire [n-1:0] y;
    
    //nbit_carrylookahead #(n) utt(.A(a), .B(b), .Cin(Cin), .Sum(y), .Cout(Cout));
    qmult #(.N(n),.Q(q)) utt(.a(a), .b(b), .q_result(y), .overflow(Cout));
    
    initial begin
        for(i = 0; i < 2**n; i = i + 1) begin
            for(j = 0; j < 2**n; j = j + 1) begin
                #(5) a = i;
                b = j;
            end
            
        end
        $finish;
    end
    
endmodule
