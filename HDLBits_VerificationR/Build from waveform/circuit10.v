module top_module (
    input clk,
    input a,
    input b,
    output q,
    output reg state  );
    assign q = a^b^state;
    always @(posedge clk) begin
        if (a&b) begin
            state <= 1;
        end
        else if (~(a|b)) begin
            state <= 0;
        end
    end
endmodule
