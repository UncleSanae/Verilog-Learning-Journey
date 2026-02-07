module top_module (
	input clk,
	input L,
	input r_in,
	input q_in,
	output reg Q);
    wire [1:0] mux = {r_in,q_in};
    always @(posedge clk) begin
        Q <= mux[L];
    end
endmodule
