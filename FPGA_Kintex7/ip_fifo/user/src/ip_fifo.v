module ip_fifo(
    input       sys_clk_p,
    input       sys_clk_n,
    input       sys_rst_n
);
    wire        clk_100m;
    wire        clk_200m;
    wire        locked;
    wire        rst_n;
    wire        wr_rst_busy;
    wire        rd_rst_busy;
    wire        fifo_wr_en;
    wire        fifo_rd_en;
    wire [7:0]  fifo_wr_data;
    wire [7:0]  fifo_rd_data;
    wire        almost_full;
    wire        almost_empty;
    wire        full;
    wire        empty;
    wire [7:0]  wr_data_count;
    wire [7:0]  rd_data_count;
    //************************
    assign      rst_n = sys_rst_n & locked;
    
    clk_wiz_0 u_clk_wiz_0(
        // Clock out ports
        .clk_out1(clk_100m),     // output clk_out1
        .clk_out2(clk_200m),     // output clk_out2
        // Status and control signals
        .locked(locked),       // output locked
        // Clock in ports
        .clk_in1_p(sys_clk_p),    // input clk_in1_p
        .clk_in1_n(sys_clk_n)    // input clk_in1_n
    );

    fifo_generator_0 u_fifo_generator_0 (
        .rst(~rst_n),                      // input wire rst
        .wr_clk(clk_100m),                // input wire wr_clk
        .rd_clk(clk_200m),                // input wire rd_clk
        .din(fifo_wr_data),                      // input wire [7 : 0] din
        .wr_en(fifo_wr_en),                  // input wire wr_en
        .rd_en(fifo_rd_en),                  // input wire rd_en
        .dout(fifo_rd_data),                    // output wire [7 : 0] dout
        .full(full),                    // output wire full
        .almost_full(almost_full),      // output wire almost_full
        .empty(empty),                  // output wire empty
        .almost_empty(almost_empty),    // output wire almost_empty
        .rd_data_count(rd_data_count),  // output wire [7 : 0] rd_data_count
        .wr_data_count(wr_data_count),  // output wire [7 : 0] wr_data_count
        .wr_rst_busy(wr_rst_busy),      // output wire wr_rst_busy
        .rd_rst_busy(rd_rst_busy)      // output wire rd_rst_busy
    );

    // output declaration of module fifo_wr
    fifo_wr u_fifo_wr(
        .wr_clk       	(clk_100m       ),
        .rst_n        	(rst_n         ),
        .wr_rst_busy  	(wr_rst_busy   ),
        .empty        	(empty         ),
        .almost_full  	(almost_full   ),
        .fifo_wr_en   	(fifo_wr_en    ),
        .fifo_wr_data 	(fifo_wr_data  )
    );
    
    fifo_rd u_fifo_rd(
        .rd_clk       	(clk_200m       ),
        .rst_n        	(rst_n         ),
        .rd_rst_busy  	(rd_rst_busy   ),
        .fifo_rd_data 	(fifo_rd_data  ),
        .full         	(full          ),
        .almost_empty 	(almost_empty  ),
        .fifo_rd_en   	(fifo_rd_en    )
    );
    
    

    ila_0 u_ila_0 (
        .clk(clk_100m), // input wire clk


        .probe0(fifo_wr_en), // input wire [0:0]  probe0  
        .probe1(fifo_wr_data), // input wire [7:0]  probe1 
        .probe2(almost_full), // input wire [0:0]  probe2 
        .probe3(full), // input wire [0:0]  probe3 
        .probe4(wr_data_count) // input wire [7:0]  probe4
    );

    ila_1 u_ila_1 (
        .clk(clk_200m), // input wire clk


        .probe0(fifo_rd_en), // input wire [0:0]  probe0  
        .probe1(fifo_rd_data), // input wire [7:0]  probe1 
        .probe2(almost_empty), // input wire [0:0]  probe2 
        .probe3(empty), // input wire [0:0]  probe3 
        .probe4(rd_data_count) // input wire [7:0]  probe4
    );
endmodule