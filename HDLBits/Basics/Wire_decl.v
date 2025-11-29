`default_nettype none
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    wire aAndb = a & b;
    wire cAndd = c & d;
    wire outp= aAndb | cAndd;
    assign out = outp;
    assign out_n  = ~outp;
endmodule