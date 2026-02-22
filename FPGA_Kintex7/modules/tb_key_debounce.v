`timescale 1ns/1ns
module tb_key_debounce();
parameter CLK_PERIOD = 10;
reg sys_clk;
reg sys_rst_n;
reg key;
wire key_filter;
always #(CLK_PERIOD/2) sys_clk = ~sys_clk;
initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b1;
    key <= 1'b1;
    #200 
    sys_rst_n <= 1'b0;
    #200
    sys_rst_n <= 1'b1;
    #100
    key <= 1'b0;
    #100
    key <= 1'b1;
    #300
    key <= 1'b0;
    #300
    key <= 1'b1;
end
// output declaration of module key_debounce
key_debounce #(
    .CNT_MAX 	(20))
u_key_debounce(
    .sys_clk    	(sys_clk     ),
    .sys_rst_n  	(sys_rst_n   ),
    .key        	(key         ),
    .key_filter 	(key_filter  )
);

initial begin
    $dumpfile("sim/tb_key_debounce.vcd");
    $dumpvars(0,tb_key_debounce);
    #2000 $finish();
end
endmodule