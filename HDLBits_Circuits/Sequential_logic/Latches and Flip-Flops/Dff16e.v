module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg[15:0] q
);
    integer i;
    always @(posedge clk) begin
        if(~resetn) begin
            q <= {16{1'd0}};
        end
        else begin
            for (i = 0 ; i < 2 ; i = i + 1) begin
                if(byteena[i]) begin
                    q[i*8 +: 8] <= d[i*8 +: 8];
                end
            end
        end
    end
endmodule