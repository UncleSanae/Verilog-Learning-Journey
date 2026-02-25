module fifo_rd(
        input       rd_clk , 
        input       rst_n ,
        input       rd_rst_busy ,
        input [7:0] fifo_rd_data,
        input       full ,
        input       almost_empty,
        output reg  fifo_rd_en 
    );

    reg full_d0;
    reg full_d1;

    always @(posedge rd_clk or negedge rst_n) begin
        if(!rst_n)begin
            full_d0 <= 1'b0;
            full_d1 <= 1'b0;
        end
        else begin
            full_d0 <= full;
            full_d1 <= full_d0;
        end
    end
    always @(posedge rd_clk or negedge rst_n) begin
        if(!rst_n)begin
            fifo_rd_en <= 1'b0;
        end
        else if(!rd_rst_busy)begin
            if(full_d1)begin
                fifo_rd_en <=1'b1;
            end
            else if (almost_empty)begin
                fifo_rd_en <= 1'b0;
            end
        end
        else begin
            fifo_rd_en <= 1'b0;
        end
    end

endmodule