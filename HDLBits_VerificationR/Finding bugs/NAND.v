module top_module (input a, input b, input c, output out);//
    wire O;
    assign out = ~O;
    andgate inst1 ( O, a, b, c ,1,1);

endmodule