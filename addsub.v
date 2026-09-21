module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);
    wire w1;
    wire [31:0] w2;
    assign w2 = b ^ {32{sub}};
    add16 a1 ( .cin(sub), .cout(w1), .a(a[15:0]),  .b(w2[15:0]),  .sum(sum[15:0]) );
    add16 a2 ( .cin(w1),.a(a[31:16]), .b(w2[31:16]), .sum(sum[31:16]) );
endmodule
