module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); 
    genvar i;
    generate
        for(i=0;i<4;i=i+1)begin:instances
            MUXDFF inst(
                .clk(KEY[0]),
                .w(i==3?KEY[3]:LEDR[i+1]),
                .R(SW[i]),
                .E(KEY[1]),
                .L(KEY[2]),
                .Q(LEDR[i])
            );
        end
    endgenerate

endmodule

module MUXDFF (
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

