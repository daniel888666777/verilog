module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
  wire and_1abc;
  wire and_1def;
  wire and_2ab;
  wire and_2cd;
    assign p1y = and_1abc | and_1def;
    assign p2y = and_2ab | and_2cd;
    assign and_1abc = p1a & p1b & p1c;
    assign and_1def =  p1d & p1e &  p1f;
    assign and_2ab = p2a & p2b;
    assign and_2cd = p2c & p2d;
endmodule
