module top_module (
    input [4:0] a, b, c, d, e, f,
    output [7:0] w, x, y, z );
    assign w[7:3] = a;
    assign {w[2:0],x[7:6]} = b;
    assign x[5:1] = c;
    assign {x[0],y[7:4]} = d;
    assign {y[3:0],z[7]} = e;
    assign z[6:2] = f;
    assign z[1:0] = 2'b11;
endmodule

