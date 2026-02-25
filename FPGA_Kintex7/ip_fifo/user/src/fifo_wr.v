module fifo_wr(
    input       wr_clk,
    input       rst_n,
    input       wr_rst_busy,
    input       empty,
    input       almost_full,
    output reg  fifo_wr_en,
    output reg[7:0] fifo_wr_data
);

    reg empty_d0;
    reg empty_d1;

    always @(posedge wr_clk or negedge rst_n) begin
        if(!rst_n)begin
            empty_d0 <= 1'b0;
            empty_d1 <= 1'b0;
        end
        else begin
            empty_d0 <= empty;
            empty_d1 <= empty_d0;
        end
    end
    always @(posedge wr_clk or negedge rst_n) begin
        if(!rst_n)begin
            fifo_wr_en <= 1'b0;
        end
        else if(!wr_rst_busy) begin
            if(empty_d1)begin
                fifo_wr_en <= 1'b1;
            end
            else if(almost_full) begin
                fifo_wr_en <= 1'b0;
            end
        end
        else begin
            fifo_wr_en <= 1'b0;
        end
    end
    always @(posedge wr_clk or negedge rst_n) begin
        if(!rst_n)begin
            fifo_wr_data <= 8'b0;
        end
        else if(fifo_wr_en && fifo_wr_data < 8'd254)begin
            fifo_wr_data <= fifo_wr_data + 8'b1;
        end
        else begin
            fifo_wr_data <= 8'b0;
        end
    end
endmodule