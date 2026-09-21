module top_module (input x, input y, output z);
wire w1,w2,w3,w4,w5,w6;
    mt2015_q4a IA1(.x(x),.y(y),.z(w1));
    mt2015_q4a IA2(.x(x),.y(y),.z(w2));
    mt2015_q4b IB1(.x(x),.y(y),.z(w3));
    mt2015_q4b IB2(.x(x),.y(y),.z(w4));
    assign w5 = w1|w3;
    assign w6 = w2&w4;
    assign z = w5^w6;
endmodule
module mt2015_q4a(input x, input y, output z);
    assign z = (x^y) & x;
endmodule
module mt2015_q4b( input x, input y, output z );
assign z = ~x^y;
endmodule
