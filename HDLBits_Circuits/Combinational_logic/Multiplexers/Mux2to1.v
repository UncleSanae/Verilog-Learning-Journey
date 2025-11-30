module top_module( 
    input a, b, sel,
    output out ); 
    wire [1:0] vec= {b,a};
    assign out = vec[sel];
endmodule