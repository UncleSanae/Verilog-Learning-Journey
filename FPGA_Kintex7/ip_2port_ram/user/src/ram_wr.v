module ram_wr(
    input       clk,
    input       rst_n,
    output reg     ram_wr_en,
    output      ram_wr_we,
    output reg[5:0]     ram_wr_addr,
    output [7:0]     ram_wr_data,
    output reg    rd_flag
);

assign ram_wr_we = ram_wr_en;

assign ram_wr_data = {2'b0,ram_wr_addr};

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        ram_wr_en <= 1'b0;
    end
    else begin
        ram_wr_en <= 1'b1;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        ram_wr_addr <= 6'd0;
    end
    else if(ram_wr_addr < 6'd63 && ram_wr_we)begin
        ram_wr_addr <= ram_wr_addr+1'b1;
    end
    else begin
        ram_wr_addr <= 6'd0;
    end
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        rd_flag <= 1'b0;
    end
    else if(ram_wr_addr == 6'd31)begin
        rd_flag <= 1'b1;
    end
    else begin
        rd_flag <= rd_flag;
    end
end


endmodule