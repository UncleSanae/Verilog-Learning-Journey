module uart_loopback(
    input       sys_clk_p,
    input       sys_clk_n,
    input       sys_rst_n,

    input       uart_rxd,
    output      uart_txd
);

    parameter   CLK_PERIOD = 100000000;
    parameter   UART_BPS = 115200;


    wire        sys_clk;
    wire        uart_rx_done;
    wire [7:0]  uart_tx_data;

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
    
    uart_rx #(
        .CLK_FREQ 	(CLK_PERIOD),
        .UART_BPS 	(UART_BPS))
    u_uart_rx(
        .clk          	(sys_clk       ),
        .rst_n        	(sys_rst_n     ),
        .uart_rxd     	(uart_rxd      ),
        .uart_rx_done 	(uart_rx_done  ),
        .uart_rx_data 	(uart_tx_data  )
    );

    // output declaration of module uart_t
    uart_tx #(
        .CLK_PERIOD 	(CLK_PERIOD),
        .UART_BPS   	(UART_BPS))
    u_uart_tx(
        .clk          	(sys_clk           ),
        .rst_n        	(sys_rst_n         ),
        .uart_tx_en   	(uart_rx_done  ),
        .uart_tx_data 	(uart_tx_data  ),
        .uart_txd     	(uart_txd      ),
        .uart_tx_busy 	( )
    );
    
    
endmodule