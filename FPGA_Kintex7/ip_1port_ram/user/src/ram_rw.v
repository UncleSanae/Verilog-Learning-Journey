module ram_rw(

    input               clk,
    input               rst_n,

    output reg          ram_en,
    output              ram_we,
    output reg [4:0]    ram_addr,
    output reg [7:0]    ram_wr_data,

    input      [7:0]    ram_rd_data  

);

reg [5:0] rw_cnt;

assign ram_we = (rw_cnt <= 6'd31 && ram_en)?1'b1:1'b0;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        ram_en <= 1'b0;
    end
    else begin
        ram_en <= 1'b1;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        rw_cnt <= 6'd0;
    end
    else if(rw_cnt == 6'd63 && ram_en)begin
       rw_cnt <= 6'd0;
    end
    else if(ram_en)begin
        rw_cnt <= rw_cnt + 1;
    end
    else begin
        rw_cnt <= 6'd0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)begin
        ram_addr <= 5'b0;
    end
    else if(ram_addr == 5'd31 && ram_en) begin
        ram_addr <= 5'b0;
    end
    else if (ram_en) begin
        ram_addr <= ram_addr + 1'b1;
    end
    else begin
        ram_addr <= 5'b0; 
    end
end

always @(posedge clk or negedge rst_n) begin
    if(rst_n == 1'b0)begin
        ram_wr_data <= 8'b0; 
    end
    else if(ram_wr_data < 8'd31 && ram_we)begin
        ram_wr_data <= ram_wr_data + 1'b1;
    end
    else begin
        ram_wr_data <= 8'b0 ; 
    end
end
ila_0 your_instance_name (
	.clk(clk), // input wire clk


	.probe0(ram_en), // input wire [0:0]  probe0  
	.probe1(ram_we), // input wire [0:0]  probe1 
	.probe2(ram_addr), // input wire [4:0]  probe2 
	.probe3(ram_wr_data), // input wire [7:0]  probe3 
	.probe4(ram_rd_data) // input wire [7:0]  probe4
);

endmodule