module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
genvar i;
    generate
        for(i=0;i<100;i=i+1)begin : adder_block
            if(i==0)begin
                fadd FA(.a(a[i]),.b(b[i]),.cin(cin),.sum(sum[i]),.cout(cout[i]));
            end
            else begin
                fadd FA(.a(a[i]),.b(b[i]),.cin(cout[i-1]),.sum(sum[i]),.cout(cout[i]));
            end
        end
    endgenerate
endmodule
module fadd(input a,b,cin,output cout,sum);
    assign sum = a^b^cin;
    assign cout = (a&b)|(b&cin)|(a&cin);
endmodule
