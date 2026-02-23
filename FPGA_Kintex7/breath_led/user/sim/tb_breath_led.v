`timescale 1ns/1ns
module tb_breath_led();

parameter CLK_PERIOD = 10;
parameter CNT_2US_MAX = 8'd2;
parameter CNT_2MS_MAX = 11'd10;
parameter CNT_2S_MAX = 11'd10;

reg sys_clk_p;
reg sys_clk_n;
reg sys_rst_n;

wire led;

initial begin
sys_clk_p <= 1'b0;
sys_clk_n <= 1'b1;
sys_rst_n <= 1'b0;
#200
sys_rst_n <= 1'b1;
end

always #(CLK_PERIOD/2) sys_clk_p = ~sys_clk_p;
always #(CLK_PERIOD/2) sys_clk_n = ~sys_clk_n;

// output declaration of module breath_led
breath_led #(
    .CNT_2US_MAX 	(CNT_2US_MAX),
    .CNT_2MS_MAX 	(CNT_2MS_MAX),
    .CNT_2S_MAX  	(CNT_2S_MAX))
u_breath_led(
    .sys_clk_p 	(sys_clk_p  ),
    .sys_clk_n 	(sys_clk_n  ),
    .sys_rst_n 	(sys_rst_n  ),
    .led       	(led        )
);

endmodule