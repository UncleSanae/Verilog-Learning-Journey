`include "../src/flow_led.v"
`timescale 1ns/1ns
module tb_flow_led ();
parameter CLK_PERIOD = 10;
reg sys_clk_p;
reg sys_clk_n;
reg sys_rst_n;
reg key_1;
wire [1:0]led;

always #(CLK_PERIOD/2)  sys_clk_p = ~sys_clk_p;
always #(CLK_PERIOD/2)  sys_clk_n = ~sys_clk_n;

initial begin
    sys_clk_p <= 1'b0;
    sys_clk_n <= 1'b1;
    sys_rst_n <= 1'b1;
    #200
    sys_rst_n <= 1'b0;
end
// output declaration of module flow_led
flow_led #(
    .MODE_1 	(0001  ),
    .MODE_2 	(0010  ),
    .MODE_3 	(0100  ),
    .MODE_4 	(1000  ))
u_flow_led(
    .sys_clk_p 	(sys_clk_p  ),
    .sys_clk_n 	(sys_clk_n  ),
    .sys_rst_n 	(sys_rst_n  ),
    .key_1     	(key_1      ),
    .led       	(led        )
);

initial begin
    $dumpfile("../data/tb_flow_led.vcd");
    $dumpvars(0,tb_flow_led);
    #1000 $finish();
end
endmodule