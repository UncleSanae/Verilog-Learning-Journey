module top_module (
    input clk,
    input reset,      // Synchronous reset
    output reg shift_ena);
    reg [2:0]delay;
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;
            delay[2:0] <= 3'b111;
        end
        else begin
            shift_ena <= delay[0];
            delay[2:0] <= {1'b0,delay[2:1]};
        end
    end
endmodule
