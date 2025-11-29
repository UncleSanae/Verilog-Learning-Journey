module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
    
);
    wire [15:0] cout1;
    wire [15:0] cout2;
    wire [31:0] bn = b^{32{sub}};
    add16 adder1(.cin(sub),.a(a[15:0]),.b(bn[15:0]),.sum(sum[15:0]),.cout(cout1));
    add16 adder2(.cin(cout1),.a(a[31:16]),.b(bn[31:16]),.sum(sum[31:16]),.cout(cout2));
endmodule