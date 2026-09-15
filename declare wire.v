`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
   wire and_ab;
   wire and_cd;
   wire or_x;
    assign out = or_x;
    assign out_n = ~out;
    assign or_x = and_ab| and_cd;
    assign and_ab = a&b;
    assign and_cd = c&d;
endmodule
