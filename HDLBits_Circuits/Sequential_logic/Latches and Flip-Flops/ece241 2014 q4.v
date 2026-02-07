module top_module (
    input clk,
    input x,
    output z
); 
    reg ff1,ff2,ff3;
    always @(posedge clk) begin
        ff1 <= x^ff1;
        ff2 <= x&~ff2;
        ff3 <= x | ~ff3;
    end
    assign z =~(ff1 | ff2 | ff3);
endmodule