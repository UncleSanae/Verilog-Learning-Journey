module ip_2port_ram(
    input       sys_clk_p,
    input       sys_clk_n,
    input       sys_rst_n
);

    wire        sys_clk;
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

    wire ram_wr_en;
    wire ram_wr_we;
    wire [5:0] ram_wr_addr;
    wire [7:0] ram_wr_data;
    wire rd_flag;
    
    ram_wr u_ram_wr(
        .clk         	(sys_clk          ),
        .rst_n       	(sys_rst_n        ),
        .ram_wr_en   	(ram_wr_en    ),
        .ram_wr_we   	(ram_wr_we    ),
        .ram_wr_addr 	(ram_wr_addr  ),
        .ram_wr_data 	(ram_wr_data  ),
        .rd_flag     	(rd_flag      )
    );
    
    wire ram_rd_en;
    wire [5:0] ram_rd_addr;
    wire [7:0] ram_rd_data;
    
    ram_rd u_ram_rd(
        .clk         	(sys_clk          ),
        .rst_n       	(sys_rst_n        ),
        .rd_flag     	(rd_flag      ),
        .ram_rd_en   	(ram_rd_en    ),
        .ram_rd_addr 	(ram_rd_addr  )
    );
    

    blk_mem_gen_0 u_blk_mem_gen_0 (
        .clka(sys_clk),    // input wire clka
        .ena(ram_wr_en),      // input wire ena
        .wea(ram_wr_we),      // input wire [0 : 0] wea
        .addra(ram_wr_addr),  // input wire [5 : 0] addra
        .dina(ram_wr_data),    // input wire [7 : 0] dina
        .clkb(sys_clk),    // input wire clkb
        .enb(ram_rd_en),      // input wire enb
        .addrb(ram_rd_addr),  // input wire [5 : 0] addrb
        .doutb(ram_rd_data)  // output wire [7 : 0] doutb
    );

    ila_0 u_ila_0 (
        .clk(sys_clk), // input wire clk


        .probe0(ram_wr_en), // input wire [0:0]  probe0  
        .probe1(ram_wr_we), // input wire [0:0]  probe1 
        .probe2(ram_rd_en), // input wire [0:0]  probe2 
        .probe3(rd_flag), // input wire [0:0]  probe3 
        .probe4(ram_wr_addr), // input wire [5:0]  probe4 
        .probe5(ram_wr_data), // input wire [7:0]  probe5 
        .probe6(ram_rd_addr), // input wire [5:0]  probe6 
        .probe7(ram_rd_data) // input wire [7:0]  probe7
    );
endmodule