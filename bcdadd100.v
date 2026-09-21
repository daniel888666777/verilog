module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    wire [99:0] w1;
    genvar i;
    generate
        for(i=0;i<100;i=i+1)begin:bcdadd_block
            if(i==0)begin
                bcd_fadd BCD(.a(a[3:0]),.b(b[3:0]),.cin(cin),.cout(w1[0]),.sum(sum[3:0]));
            end
            else begin
                bcd_fadd BCD(.a(a[i*4+3:i*4]),.b(b[i*4+3:i*4]),.cin(w1[i-1]),.cout(w1[i]),.sum(sum[i*4+3:i*4]));
            end
        end
    endgenerate
    assign cout = w1[99];
endmodule
