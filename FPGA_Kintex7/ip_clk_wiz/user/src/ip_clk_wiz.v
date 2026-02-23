module ip_clk_wiz(

input       sys_clk_p ,
input       sys_clk_n ,
input       sys_rst_n ,

output      clk_200m ,
output      clk_200m_180deg,
output      clk_100m ,
output      clk_25m
);

wire locked;

clk_wiz_0 clk_wiz_0(
    // Clock out ports
    .clk_out1(clk_200m),     // output clk_out1
    .clk_out2(clk_200m_180deg),     // output clk_out2
    .clk_out3(clk_100m),     // output clk_out3
    .clk_out4(clk_25m),     // output clk_out4
    // Status and control signals
    .reset(sys_rst_n), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1_p(sys_clk_p),    // input clk_in1_p
    .clk_in1_n(sys_clk_n)    // input clk_in1_n
);

endmodule