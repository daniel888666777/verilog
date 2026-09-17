module top_module(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum
);
    wire sel;
    wire [15:0] w1,w2;
    add16 a1(.cin(1'b0),.cout(sel),.sum(sum[15:0]),.a(a[15:0]),.b(b[15:0]));
    add16 a2(.cin(1'b0),.sum(w1),.a(a[31:16]),.b(b[31:16]));
    add16 a3(.cin(1'b1),.sum(w2),.a(a[31:16]),.b(b[31:16]));
    assign sum[31:16] = sel ? w2 : w1;
endmodule
