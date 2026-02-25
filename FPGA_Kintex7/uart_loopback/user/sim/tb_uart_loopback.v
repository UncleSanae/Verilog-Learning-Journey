`timescale 1ns/1ns
module tb_uart_loopback();

    reg     sys_clk_p;
    reg     sys_clk_n;
    reg     sys_rst_n;
    reg     uart_rxd;
    wire    uart_txd;
    initial begin
        sys_clk_p <= 1'b0;
        sys_clk_n <= 1'b1;
        sys_rst_n <= 1'b0;
        uart_rxd <= 1'b1;
        #200    
        sys_rst_n <= 1'b1;
        #1000
        uart_rxd <= 1'b0;
        #8680
        uart_rxd <= 1'b1;
        #8680
        uart_rxd <= 1'b0;
        #8680
        uart_rxd <= 1'b1;
        #8680
        uart_rxd <= 1'b0;
        #8680
        uart_rxd <= 1'b1;
        #8680
        uart_rxd <= 1'b0;
        #8680
        uart_rxd <= 1'b1;
        #8680
        uart_rxd <= 1'b0;
        #8680
        uart_rxd <= 1'b1;
        #8680
        uart_rxd <= 1'b1;
    end
    always #5 sys_clk_p = ~ sys_clk_p;
    always #5 sys_clk_n = ~ sys_clk_n;
    
    uart_loopback #(
        .CLK_PERIOD 	(100000000  ),
        .UART_BPS   	(115200     ))
    u_uart_loopback(
        .sys_clk_p 	(sys_clk_p  ),
        .sys_clk_n 	(sys_clk_n  ),
        .sys_rst_n 	(sys_rst_n  ),
        .uart_rxd  	(uart_rxd   ),
        .uart_txd  	(uart_txd   )
    );
    
endmodule