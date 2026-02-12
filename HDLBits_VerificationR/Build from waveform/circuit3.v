module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//
    wire [3:0]N = {a,b,c,d};
    assign q = (N==5)|(N==6)|(N==7)|(N==9)|(N==10)|(N==11)|(N==13)|(N==14)|(N==15);

endmodule
