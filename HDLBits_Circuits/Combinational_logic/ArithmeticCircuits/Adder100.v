module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum 
);

    // 没错，就是这么简单
    assign {cout, sum} = a + b + cin;

endmodule