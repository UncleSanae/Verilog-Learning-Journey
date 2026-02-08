module top_module(
    input clk,
    input reset,
    output OneHertz,
    output[2:0] c_enable
);
    wire[3:0] out1,out2,out3;
    assign c_enable[0]=1'b1;
    assign c_enable[1]=(out1==4'd9)&&c_enable[0];
    assign c_enable[2]=(out2==4'd9)&&c_enable[1];
    assign OneHertz=(out3==4'd9)&&c_enable[2];
    bcdcount counter0(clk,reset,c_enable[0],out1);
    bcdcount counter1(clk,reset,c_enable[1],out2);
    bcdcount counter2(clk,reset,c_enable[2],out3);
endmodule