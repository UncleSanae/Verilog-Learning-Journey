module top_module( 
    input [2:0] a, b,
    input cin,
    output [2:0] cout,
    output [2:0] sum );
    genvar i;
    generate
        for (i = 0;i < 3 ;i = i+1 ) begin : adder3
            if (i == 0) begin
                Fadd inst (.a(a[i]),.b(b[i]),.cin(cin),.cout(cout[i]),.sum(sum[i]));
            end
            else begin
                Fadd inst (.a(a[i]),.b(b[i]),.cin(cout[i-1]),.cout(cout[i]),.sum(sum[i]));
            end
        end
    endgenerate
endmodule

module Fadd( 
    input a, b, cin,
    output cout, sum );
    assign {cout,sum} = a+b+cin;
endmodule