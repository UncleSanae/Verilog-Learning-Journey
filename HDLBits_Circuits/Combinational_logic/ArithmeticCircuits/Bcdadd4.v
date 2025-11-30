module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    genvar i;
    wire [3:0]coutreg;
    assign cout = coutreg[3];
    generate
        for (i =0 ;i<4 ;i = i +1 ) begin : Bcd4
            if (i == 0) begin
                bcd_fadd inst (.a(a >> i*4),.b(b >> i *4),.cin(cin),.cout(coutreg[i]),.sum(sum[i*4 +: 4]));
            end
            else begin
                bcd_fadd inst (.a(a >> i*4),.b(b >> i *4),.cin(coutreg[i-1]),.cout(coutreg[i]),.sum(sum[i*4 +: 4]));
            end
        end
    endgenerate
endmodule

module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );
endmodule