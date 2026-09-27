//Count15
module count15 (
    input clk,
    input reset,      
    output [3:0] q);
    always @(posedge clk)begin
        if(reset)begin
            q <= 4'b0000;
        end
        else begin
            q <= q+4'b0001;
        end
    end
endmodule

//Count10
module count10 (
    input clk,
    input reset,        
    output [3:0] q);
    always @(posedge clk)begin
        if(reset)begin
            q <= 4'b0000;
        end
        else if(q == 4'b1001)begin
            q <= 4'b0000;
        end
        else begin
            q <= q+4'b0001;
        end
    end
endmodule

//Count1to10
module count1to10 (
    input clk,
    input reset,
    output [3:0] q);
    always @(posedge clk)begin
        if(reset)begin
            q <= 4'd1;
        end
        else if(q == 4'd10)begin
            q <= 4'd1;
        end
        else begin
            q <= q+4'd1;
        end
    end
endmodule

//Countslow
module countslow (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    always @(posedge clk)begin
        if(reset)begin
            q <=4'd0;
        end
        else if (slowena) begin
          if (q == 4'd9)begin
            q <= 4'd0;
          end
          else begin
            q <= q+ 4'd1;
          end
        end
    end
endmodule

//Exams/ece241 2014 q7a
module ece2412014q7a (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d); 
    assign c_enable = enable;
    assign c_d = 4'd1;
    assign  c_load = reset|(enable&&(Q==4'd12));
    count4 count(.clk(clk),.enable(c_enable),.load(c_load),.d(c_d),.Q(Q));
endmodule

//Exams/ece241 2014 q7b
module ece2412014q7b (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable); 
    wire [3:0] w0,w1,w2;
    assign c_enable[0] = 1'b1;
    assign c_enable[1] = (w0 == 4'd9);
    assign c_enable[2] = (w0 == 4'd9 && w1 == 4'd9 );
    assign OneHertz = (w0 == 4'd9 && w1 == 4'd9 && w2 == 4'd9);
    bcdcount counter0 (.clk(clk),.reset(reset),.enable(c_enable[0]),.Q(w0));
    bcdcount counter1 (.clk(clk),.reset(reset),.enable(c_enable[1]),.Q(w1));
    bcdcount counter2 (.clk(clk),.reset(reset),.enable(c_enable[2]),.Q(w2));
endmodule

//Countbcd
module countbcd (
    input clk,
    input reset,   
    output [3:1] ena,
    output [15:0] q);
    assign ena[1] = (q[3:0] == 4'd9);
    assign ena[2] = (q[3:0] == 4'd9 && q[7:4] == 4'd9);
    assign ena[3] = (q[3:0] == 4'd9 && q[7:4] == 4'd9 && q[11:8] == 4'd9);
    counter d1(.clk(clk),.reset(reset),.ena(1'b1),.q(q[3:0]));
    counter d2(.clk(clk),.reset(reset),.ena(ena[1]),.q(q[7:4]));
    counter d3(.clk(clk),.reset(reset),.ena(ena[2]),.q(q[11:8]));
    counter d4(.clk(clk),.reset(reset),.ena(ena[3]),.q(q[15:12]));
endmodule
module counter (
    input clk,
    input reset,
    input ena,
    output reg [3:0] q);
    always @(posedge clk) begin
        if (reset) begin
            q <= 4'd0;
        end else if (ena) begin
            if (q == 4'd9)begin
                q <= 4'd0;
            end
            else begin
                q <= q + 4'd1;
            end
        end
    end
endmodule

//Count clock
module countclock (
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    wire w1,w2;
    assign w1 = ena && (ss == 8'h59);
    assign w2 = w1 && (mm == 8'h59);
    bcd_count60 s(.clk(clk),.reset(reset),.ena(ena),.q(ss));
    bcd_count60 m(.clk(clk),.reset(reset),.ena(w1),.q(mm));
    always @(posedge clk) begin
        if(reset)begin
            pm <= 1'b0;
            hh <= 8'h12;
        end
        if (w2) begin
            if (hh[7:0] == 8'h11) begin
               pm <= ~pm;
            end
            if (hh[7:0] == 8'h12)begin
                hh <= 8'h01;
            end
            else if (hh[3:0] == 4'd9) begin
                hh[3:0] <= 4'd0;
                hh[7:4] <= hh[7:4]+4'd1;
            end
            else begin
                hh[3:0] <= hh[3:0]+4'd1;
            end
        end
    end     
endmodule
module bcd_count60 (
    input clk,
    input reset,
    input ena,
    output reg [7:0] q);
    always @(posedge clk) begin
        if (reset) begin
            q <= 8'h00;
        end 
        else if (ena) begin
            if (q[3:0] == 4'd9) begin
                q[3:0] <= 4'd0;
                if (q[7:4] == 4'd5) begin
                    q[7:4] <= 4'd0;
                end 
                else begin
                    q[7:4] <= q[7:4] + 4'd1;
                end
            end
            else begin
                q[3:0] <= q[3:0] + 4'd1;
            end
        end
    end
endmodule
