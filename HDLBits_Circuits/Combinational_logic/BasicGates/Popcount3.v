module top_module( 
    input [2:0] in,
    output reg [1:0] out );
    integer i ;
    integer count;
    always @(*) begin
        count = 0;
        for (i = 0;i <3 ;i = i+1 ) begin
            if(in[i] == 1)begin
                count = count + 1;
            end   
         end
        out = count;
    end
           
endmodule