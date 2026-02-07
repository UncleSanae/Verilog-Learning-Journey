module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output reg q);
    always @(posedge clk) begin
        if (r) begin
            q <= 1'd0;
        end
        else begin
            q <= d;
        end
    end
endmodule