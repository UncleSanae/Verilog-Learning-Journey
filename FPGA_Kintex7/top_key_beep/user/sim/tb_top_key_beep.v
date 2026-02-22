`timescale 1ns/1ns
//`include "../src/top_key_beep.v"
module tb_top_key_beep();

parameter CLK_PERIOD = 10;
reg sys_clk_p;
reg sys_clk_n;
reg sys_rst_n;
reg key;
wire beep;
always #(CLK_PERIOD/2) sys_clk_p = ~sys_clk_p;
always #(CLK_PERIOD/2) sys_clk_n = ~sys_clk_n;
initial begin
    sys_clk_p <= 1'b0;
    sys_clk_n <= 1'b1;
    sys_rst_n <= 1'b1;
    key <= 1'b1;
    #200 
    sys_rst_n <= 1'b0;
    #200 
    sys_rst_n <= 1'b1;
    #20
    key <= 1'b0;
    #20 
    key <= 1'b1;
    #20
    key <= 1'b0;
    #20 
    key <= 1'b1;
    #20
    key <= 1'b0;
    #500
    key <= 1'b1;
    #1000
    key <= 1'b0;
    #20 
    key <= 1'b1;
    #20
    key <= 1'b0;
    #500
    key <= 1'b1;
end
// output declaration of module top_key_beep
// output declaration of module top_key_beep
top_key_beep #(
    .CNT_MAX 	(21'd20))
u_top_key_beep(
    .sys_clk_p 	(sys_clk_p  ),
    .sys_clk_n 	(sys_clk_n  ),
    .sys_rst_n 	(sys_rst_n  ),
    .key       	(key        ),
    .beep      	(beep       )
);

initial begin
    //$dumpfile("sim/tb_top_key_beep.vcd");
    //$dumpvars(0,tb_top_key_beep);
    // #2000 $finish();
end
endmodule