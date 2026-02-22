module top_key_beep(
    //按键控制蜂鸣器顶层设�?
    //差分时钟
    input       sys_clk_p,
    input       sys_clk_n,
    //复位信号
    input       sys_rst_n,
    //按键信号
    input       key,
    //蜂鸣�?
    output      beep
);
parameter CNT_MAX = 21'd200_2000;
//差分时钟转单端时�?
wire sys_clk;
IBUFDS #(
    .CAPACITANCE("DONT_CARE"), // "LOW", "NORMAL", "DONT_CARE" (Virtex-4 only)
    .DIFF_TERM("FALSE"),       // Differential Termination (Virtex-4/5, Spartan-3E/3A)
    .IBUF_DELAY_VALUE("0"),    // Specify the amount of added input delay for
    .IFD_DELAY_VALUE("AUTO"),  // Specify the amount of added delay for input
    .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
) IBUFDS_inst (
    .O(sys_clk),  // Buffer output
    .I(sys_clk_p),  // Diff_p buffer input (connect directly to top-level port)
    .IB(sys_clk_n) // Diff_n buffer input (connect directly to top-level port)
);
//按键消抖
// output declaration of module key_debounce
wire key_filter;
key_debounce #(
    .CNT_MAX 	(CNT_MAX))
u_key_debounce(
    .sys_clk    	(sys_clk     ),
    .sys_rst_n  	(sys_rst_n   ),
    .key        	(key         ),
    .key_filter 	(key_filter  )
);
//蜂鸣器控�?
// output declaration of module key_beep
key_beep u_key_beep(
    .sys_clk    	(sys_clk     ),
    .sys_rst_n  	(sys_rst_n   ),
    .key_filter 	(key_filter  ),
    .beep       	(beep        )
);

endmodule