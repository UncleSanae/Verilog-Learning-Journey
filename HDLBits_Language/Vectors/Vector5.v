module top_module (
    input a, b, c, d, e,
    output reg[24:0] out );//
    wire [4:0]vec = {a,b,c,d,e};
    // The output is XNOR of two vectors created by 
    // concatenating and replicating the five inputs.
    // assign out = ~{ ... } ^ { ... };
    integer i;
    integer j;
    always @(*) begin
        for(i = 4 ; i >=  0; i = i - 1)begin
            for(j = 4;j >= 0; j = j - 1)begin
                out[i*5+j] = ~(vec[i]^vec[j]);
            end
        end
    end
endmodule