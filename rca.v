module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    wire w1;
    assign sum = x+y;
endmodule
