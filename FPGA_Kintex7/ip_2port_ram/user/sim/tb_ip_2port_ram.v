`timescale 1ns/1ps
module tb_ip_2port_ram();

parameter CLK_PERIOD = 10;
reg sys_clk_p;
reg sys_clk_n;
reg sys_rst_n;
initial begin
    sys_clk_p <= 1'b0;
    sys_clk_n <= 1'b1;
    sys_rst_n <= 1'b0;
    #200
    sys_rst_n <= 1'b1;
end
always #(CLK_PERIOD/2) sys_clk_p <= ~sys_clk_p;
always #(CLK_PERIOD/2) sys_clk_n <= ~sys_clk_n;

ip_2port_ram u_ip_2port_ram(
    .sys_clk_p 	(sys_clk_p  ),
    .sys_clk_n 	(sys_clk_n  ),
    .sys_rst_n 	(sys_rst_n  )
);

endmodule