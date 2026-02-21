`include "../src/led++.v"
`timescale 1ns/1ps
module tb_ledpp();
    reg key1,key2;
    wire led1,led2;
    initial begin
        key1 = 1'b1;
        key2 = 1'b1;
        #10
        key2 = 1'b0;
        #10
        key2 = 1'b1;
        #10
        key2 = 1'b0;
        #10
        key2 = 1'b1;
        #10
        key1 = 1'b0;
        #10
        key1 = 1'b1;
        #10
        key2 = 1'b0;
        #10
        key2 = 1'b1;
        #10
        key1 = 1'b0;
        #10
        key1 = 1'b1;
        #10
        key2 = 1'b0;
        #10
        key2 = 1'b1;
    end
    ledpp sim_led (.key1(key1),.led1(led1),.key2(key2),.led2(led2));
    initial begin
        $dumpfile("user/sim/ledpp.vcd");        
        $dumpvars(0, tb_ledpp);
        #150 $finish();
    end
endmodule