//Shift4
module shift4(
    input clk,
    input areset,  
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q); 
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            q <= 4'd0;
        end 
        else if (load) begin  
            q <= data;
        end 
        else if (ena) begin
            q <= q >> 1; 
        end
    end
endmodule

//Rotate100
module rotate100(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q); 
    always @(posedge clk) begin
        if (load) begin
            q <= data; 
        end
        else if (ena == 2'b01) begin
            q <= {q[0], q[99:1]};
        end
        else if (ena == 2'b10) begin
            q <= {q[98:0], q[99]};
        end
    end
endmodule

//Shift18
module shift18(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    always @(posedge clk) begin
        if (load) begin
            q <= data;  
        end 
        else if (ena) begin
            case (amount)
                2'b00: q <= {q[62:0], 1'b0};          
                2'b01: q <= {q[55:0], 8'b0};          
                2'b10: q <= {q[63], q[63:1]};         
                2'b11: q <= {{8{q[63]}}, q[63:8]};    
            endcase
        end
    end
endmodule

//Lfsr5
module lfsr5(
    input clk,
    input reset,   
    output [4:0] q); 
    always @(posedge clk) begin
        if (reset) begin
            q <= 5'h1; 
        end 
        else begin
            q <= {q[0], q[4], q[3] ^ q[0], q[2], q[1]};
        end
    end
endmodule

//Mt2015 lfsr
module mt2015lfsr(
	input [2:0] SW,      
	input [1:0] KEY,     
	output [2:0] LEDR);  
    always @(posedge KEY[0]) begin
        if (KEY[1]) begin
            LEDR <= SW;
        end else begin
            LEDR[0] <= LEDR[2];
            LEDR[1] <= LEDR[0];
            LEDR[2] <= LEDR[1] ^ LEDR[2];
        end
    end
endmodule

//Lfsr32
module lfsr32(
    input clk,
    input reset,    
    output [31:0] q); 
    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; 
        end 
        else begin
            q <= {q[0],q[31:23],q[22] ^ q[0],q[21:3],q[2] ^ q[0],q[1] ^ q[0]};
        end
    end
endmodule

//Exams/m2014 q4k
module m2014 q4k(
    input clk,
    input resetn,   
    input in,
    output out);
    reg r1,r2,r3;
    always @(posedge clk)begin
        if(!resetn)begin
            {r1,r2,r3,out} <= 4'b0;
        end
        else begin
            {r1,r2,r3,out} <= {in,r1,r2,r3};
        end
    end 
endmodule

//Exams/2014 q4b
module 2014 q4b (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR); 
    MUXDFF m0(.clk(KEY[0]),.w(LEDR[1]),.R(SW[0]),.E(KEY[1]),.L(KEY[2]),.Q(LEDR[0]));
    MUXDFF m1(.clk(KEY[0]),.w(LEDR[2]),.R(SW[1]),.E(KEY[1]),.L(KEY[2]),.Q(LEDR[1]));
    MUXDFF m2(.clk(KEY[0]),.w(LEDR[3]),.R(SW[2]),.E(KEY[1]),.L(KEY[2]),.Q(LEDR[2]));
    MUXDFF m3(.clk(KEY[0]),.w(KEY[3]),.R(SW[3]),.E(KEY[1]),.L(KEY[2]),.Q(LEDR[3]));
endmodule
module MUXDFF (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q);
    always @(posedge clk) begin
        if (L) begin
            Q <= R;          
        end else if (E) begin
            Q <= w;          
        end else begin
            Q <= Q;        
        end
    end
endmodule

//Exams/ece241 2013 q12
module ece241 2013 q12 (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    reg [7:0] Q;
    always @(posedge clk) begin
        if (enable) begin
            Q <= {Q[6:0], S}; 
        end
    end
    assign Z = Q[{A, B, C}]; 
endmodule
