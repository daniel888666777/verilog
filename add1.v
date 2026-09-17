module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire w1;
    add16 a1(.cin( 1'b0),.cout(w1),.a(a[15:0]),.b(b[15:0]),.sum(sum[15:0]));
    add16 a2(.cin(w1),.a(a[31:16]),.b(b[31:16]),.sum( sum[31:16]));
endmodule
