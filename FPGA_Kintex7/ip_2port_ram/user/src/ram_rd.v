module ram_rd(
    input       clk,
    input       rst_n,
    input       rd_flag,
    output      ram_rd_en,
    output  reg[5:0]    ram_rd_addr
);

assign ram_rd_en = rd_flag;

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        ram_rd_addr <= 6'd0;
    end
    else if(ram_rd_en && ram_rd_addr < 6'd63)begin
        ram_rd_addr <= ram_rd_addr + 1'b1;
    end
    else begin
        ram_rd_addr <= 6'd0;
    end
end
endmodule