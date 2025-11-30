module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output reg [15:0] out );
    wire [8:0][15:0] vec = {i, h, g, f, e, d, c, b, a};
    always @(*) begin
        if (sel <= 8) begin
            out = vec[sel];
        end
        else begin
            out = 16'hffff; 
        end
    end

endmodule
