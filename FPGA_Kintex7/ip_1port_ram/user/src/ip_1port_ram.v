module ip_1port_ram(
    input       sys_clk_p,
    input       sys_clk_n,
    input       sys_rst_n
);
wire        sys_clk;
wire        ram_en;
wire        ram_we;
wire [4:0]  ram_addr;
wire [7:0]  ram_wr_data;
wire [7:0]  ram_rd_data;

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

ram_rw u_ram_rw(
    .clk         	(sys_clk          ),
    .rst_n       	(sys_rst_n        ),
    .ram_en      	(ram_en       ),
    .ram_we      	(ram_we       ),
    .ram_addr    	(ram_addr     ),
    .ram_wr_data 	(ram_wr_data  ),
    .ram_rd_data 	(ram_rd_data  )
);

blk_mem_gen_0 my_blk_mem_gen_0 (
  .clka(sys_clk),    // input wire clka
  .ena(ram_en),      // input wire ena
  .wea(ram_we),      // input wire [0 : 0] wea
  .addra(ram_addr),  // input wire [4 : 0] addra
  .dina(ram_wr_data),    // input wire [7 : 0] dina
  .douta(ram_rd_data)  // output wire [7 : 0] douta
);


endmodule