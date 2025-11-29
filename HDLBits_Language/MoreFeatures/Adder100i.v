module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    genvar i;
    generate
        for (i = 0;i<100 ;i = i+1 ) begin : adder100
            if(i == 0 )begin
                adder inst(.a(a[0]),.b(b[0]),.cin(cin),.sum(sum[0]),.cout(cout[0]));
            end
            else begin
                adder inst(.a(a[i]),.b(b[i]),.cin(cout[i-1]),.sum(sum[i]),.cout(cout[i]));
            end
        end
    endgenerate
endmodule

module adder(input a,b,cin, output cout,sum);
    assign {cout,sum} = a+b+cin;
endmodule