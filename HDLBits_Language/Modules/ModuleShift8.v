module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);

    wire [7:0] q1,q2,q3;
    wire [3:0][7:0]vec = {q3,q2,q1,d};
    my_dff8 insta(.clk(clk),.d(d),.q(q1));
    my_dff8 instb(.clk(clk),.d(q1),.q(q2));
    my_dff8 instc(.clk(clk),.d(q2),.q(q3));
    assign q = vec[sel];

endmodule