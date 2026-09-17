module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output reg[7:0] q 
);
    wire [7:0] w1, w2, w3;
    
    my_dff8 inst1 ( .clk(clk), .d(d),  .q(w1) );
    my_dff8 inst2 ( .clk(clk), .d(w1), .q(w2) );
    my_dff8 inst3 ( .clk(clk), .d(w2), .q(w3) );
    
    always @(*) begin
        case(sel)
            1'b0: q = d;      
            1'b1: q = w1;     
            2'b10: q = w2;     
            2'b11: q = w3;     
        endcase
    end
endmodule
