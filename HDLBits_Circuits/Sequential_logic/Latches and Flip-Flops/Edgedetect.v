module top_module (
    input clk,
    input [7:0] in,
    output reg[7:0]  pedge
);
    reg [7:0] in_last = 8'd0;
    integer i;
    always @(posedge clk) begin
        in_last <= in;
        for (i = 0;i<8 ;i = i+1 ) begin
            pedge[i] <= (in[i])? (in[i]^in_last[i]):1'd0;
        end
    end
endmodule