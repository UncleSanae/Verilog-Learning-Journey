module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//
    wire [3:0]N = {a,b,c,d};
    assign q = (N>=2 & N <= 7)|(N>=10 & N <= 15);

endmodule
