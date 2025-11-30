module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);
    wire cout[7:0];
    assign overflow = cout[7]^cout[6];
    genvar i;
    generate
        for (i = 0;i < 8 ;i = i+1 ) begin : adder8
            if (i == 0) begin
                Fadd inst (.a(a[i]),.b(b[i]),.cin(1'b0),.cout(cout[i]),.sum(s[i]));
            end
            else begin
                Fadd inst (.a(a[i]),.b(b[i]),.cin(cout[i-1]),.cout(cout[i]),.sum(s[i]));
            end
        end
    endgenerate

endmodule

module Fadd( 
    input a, b, cin,
    output cout, sum );
    assign {cout,sum} = a+b+cin;
endmodule