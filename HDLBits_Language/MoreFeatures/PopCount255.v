module top_module( 
    input [254:0] in,
    output reg [7:0] out );
    integer i;
    integer count;
    always @(*) begin
        count = 0;
        for (i = 0 ; i < $bits(in);i++ ) begin
            count = count + ((in[i] == 1)? 1:0);
        end
        out = count;
    end
endmodule