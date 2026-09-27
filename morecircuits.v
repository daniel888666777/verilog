//Rule90  left neighbour ^ right neighbour
module rule90(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
    always @(posedge clk) begin
        if (load) begin
            q <= data; 
        end 
        else begin
            q <= {1'b0, q[511:1]} ^ {q[510:0], 1'b0};
        end
    end
endmodule

//Rule110
module rule110(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q);
    always @(posedge clk)begin
        if(load)begin
            q <= data;
        end
        else begin
            q <= (q^{q[510:0],1'b0})|(~{1'b0,q[511:1]}&q);
        end
    end
endmodule

//Conwaylife
module conwaylife(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q ); 
    
    reg [255:0] q_next;
    integer row, col;
    integer up, down, left, right;
    integer sum;

    always @(*) begin
        for (row = 0; row < 16; row = row + 1) begin
        for (col = 0; col < 16; col = col + 1) begin
           up    = (row == 15) ? 0  : row + 1; 
           down  = (row == 0)  ? 15 : row - 1; 
           left  = (col == 15) ? 0  : col + 1; 
           right = (col == 0)  ? 15 : col - 1;
           sum = q[up*16 + left] + q[up*16 + col] + q[up*16 + right] + q[row*16 + left] + q[row*16 + right] + q[down*16 + left] + q[down*16 + col] + q[down*16 + right];
                if (sum == 3) begin
                   q_next[row*16 + col] = 1'b1;
                end
                else if (sum == 2) begin
                   q_next[row*16 + col] = q[row*16 + col];
                end
                else begin
                   q_next[row*16 + col] = 1'b0;
                end     
            end
        end
    end
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end
        else begin
            q <= q_next;
        end
    end
endmodule
