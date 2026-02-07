module top_module (
    input clk,
    input w, R, E, L,
    output reg Q
);
    wire d;
    wire [1:0] mux1 = {w,Q};
    wire [1:0] mux2 = {R,mux1[E]};
    assign d = mux2[L];
    always @(posedge clk) begin
        Q <= d;
    end
endmodule