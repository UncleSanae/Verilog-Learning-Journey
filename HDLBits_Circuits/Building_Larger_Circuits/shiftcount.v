module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg[3:0] q);
    always @(posedge clk) begin
        q[3:0] <= (shift_ena)?({q[2:0],data}):((count_ena)?(q[3:0]-1):q[3:0]);
    end
endmodule
