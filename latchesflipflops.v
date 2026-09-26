//Exams/m2014 q4a 
module m2014 q4a (
    input d, 
    input ena,
    output q);
    always @(*)begin
        if(ena)begin
            q <= d;
        end
    end
endmodule

//Exams/m2014 q4b
module m2014 q4b (
    input clk,
    input d, 
    input ar,   
    output q);
    always @(posedge clk or posedge ar)begin
        if(ar)begin
            q <= 1'b0;
        end
        else begin
            q <= d;
        end
    end
endmodule

//Exams/m2014 q4c
module m2014 q4c (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q);
always @(posedge clk)begin
        if(r)begin
            q <= 1'b0;
        end
        else begin
            q <= d;
        end
    end
endmodule

//Exams/m2014 q4d
module m2014 q4d (
    input clk,
    input in, 
    output out);
    wire w1;
    assign w1 = in^out;
    always @(posedge clk)begin
            out <= w1;
    end
endmodule

//Mt2015 muxdff
module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    always @(posedge clk)begin
        if(L)begin
            Q <= r_in;
        end
        else begin
            Q <= q_in;
        end
    end
endmodule

//Exams/2014 q4a
module top_module (
    input clk,
    input w, R, E, L,
    output Q);
 always @(posedge clk)begin
        if(L)begin
            Q <= R;
        end
        else if(E) begin
            Q <= w;
        end
        else begin
            Q <= Q;
        end
    end
endmodule

//Exams/ece241 2014 q4
module ece241 2014 q4 (
    input clk,
    input x,
    output z); 
    wire w1,w2,w3,w4,w5,w6,w7,w8;
    assign w5 = ~w4;
    assign w8 = ~w7;
    assign w1 = w2^x;
    assign w3 = w5&x;
    assign w6 = w8|x;
    assign z = ~(w2|w4|w7);
    always @(posedge clk)begin
            w2 <= w1;
            w4 <= w3;
            w7 <= w6;
    end
endmodule

//Exams/ece241 2014 q4 (improve)
module ece241 2014 q4 _improve (
    input clk,
    input x,
    output z); 
    reg [2:0] q;
    always @(posedge clk)begin
        q[0] <= x^q[0];
        q[1] <= x&~q[1];
        q[2] <= x|~q[2];
    end
    assign z = ~(q[0]|q[1]|q[2]);
endmodule

//Exams/ece241 2013 q7
module ece241 2013 q7 (
    input clk,
    input j,
    input k,
    output Q); 
always @(posedge clk) begin
        case ({j, k})
            2'b00: Q <= Q;       
            2'b01: Q <= 1'b0;
            2'b10: Q <= 1'b1;
            2'b11: Q <= ~Q;
        endcase
end
endmodule

//Edgedetect
module edgedetect (
    input clk,
    input [7:0] in,
    output [7:0] pedge);
    reg [7:0] in_last;
    always @(posedge clk) begin
        in_last <= in;         
        pedge <= in & ~in_last; 
    end
endmodule

//Edgedetect2
module edgedetect2 (
    input clk,
    input [7:0] in,
    output [7:0] anyedge);
    reg [7:0] in_last;
    always @(posedge clk) begin
        in_last <= in;         
        anyedge <= in ^ in_last; 
    end
endmodule

//Edgecapture The output bit should be set after a 1 to 0 transition occurs.The output bit should be reset at the positive clock edge when reset is high. reset has precedence. 
module edgecapture (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out);
    reg [31:0] in_last;
    always @(posedge clk) begin
        in_last <= in;         
        if(reset)begin
            out <= 32'b0;
        end
        else begin
            out <= out|(~in & in_last);
        end
    end   
endmodule

//Dualedge
module dualedge (
    input clk,
    input d,
    output q);
    reg r1,r2;
    always @(posedge clk)begin
        r1 <= d^r2;
    end
    always @(negedge clk)begin
        r2 <= d^r1;
    end
    assign q = r1^r2;
endmodule
