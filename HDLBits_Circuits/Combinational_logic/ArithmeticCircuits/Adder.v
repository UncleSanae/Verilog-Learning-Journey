module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    genvar i;
    wire [4:0]cout;
    generate
        for (i = 0;i < 5 ;i = i+1 ) begin : adder3
            if (i == 0) begin
                Fadd inst (.a(x[i]),.b(y[i]),.cin(1'b0),.cout(cout[i]),.sum(sum[i]));
            end
            else if (i == 4) begin
                Fadd inst (.a(1'b0),.b(1'b0),.cin(cout[i-1]),.cout(cout[i]),.sum(sum[i]));
            end
            else begin
                Fadd inst (.a(x[i]),.b(y[i]),.cin(cout[i-1]),.cout(cout[i]),.sum(sum[i]));
            end
            
        end
    endgenerate
endmodule

module Fadd( 
    input a, b, cin,
    output cout, sum );
    assign {cout,sum} = a+b+cin;
endmodule