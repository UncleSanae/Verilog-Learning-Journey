`timescale 1ns / 1ps
module tb_ip_clk_wiz();
parameter CLK_PERIOD = 10;
reg sys_clk_p;
reg sys_clk_n;
reg sys_rst_n;
wire clk_200m; 
wire clk_200m_180deg;
wire clk_100m; 
wire clk_25m; 
initial begin
sys_clk_p = 1'b0;
sys_clk_n = 1'b1;
sys_rst_n = 1'b1;
#200
sys_rst_n = 1'b0;
end
always #(CLK_PERIOD/2) sys_clk_p = ~sys_clk_p;
always #(CLK_PERIOD/2) sys_clk_n = ~sys_clk_n;
ip_clk_wiz u_ip_clk_wiz(
.sys_clk_p (sys_clk_p ),
.sys_clk_n (sys_clk_n ),
.sys_rst_n (sys_rst_n ),
.clk_200m (clk_200m ),
.clk_200m_180deg (clk_200m_180deg),
.clk_100m (clk_100m ),
.clk_25m (clk_25m ) 
);
endmodule