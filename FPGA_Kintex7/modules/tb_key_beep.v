`timescale 1ns/1ns
module tb_key_beep();
parameter CLK_PERIOD = 10;
reg sys_clk;
reg sys_rst_n;
reg key_filter;
always #(CLK_PERIOD/2) sys_clk = ~sys_clk;
initial begin
    sys_clk <= 1'b0;
    sys_rst_n <= 1'b1;
    key_filter <= 1'b1;
    #200 
    sys_rst_n <= 1'b0;
    #200
    sys_rst_n <= 1'b1;
    #100
    key_filter <= 1'b0;
    #100
    key_filter <= 1'b1;
    #300
    key_filter <= 1'b0;
    #100
    key_filter <= 1'b1;
end
// output declaration of module key_beep
wire beep;
key_beep u_key_beep(
    .sys_clk    	(sys_clk     ),
    .sys_rst_n  	(sys_rst_n   ),
    .key_filter 	(key_filter  ),
    .beep       	(beep        )
);
initial begin
    $dumpfile("sim/tb_key_beep.vcd");
    $dumpvars(0,tb_key_beep);
    #2000 $finish();
end
endmodule