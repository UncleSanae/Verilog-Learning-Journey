module top_module(
    input [31:0] a,
    input [31:0] b,
    output reg [31:0] sum
);
    wire cout1;
    wire cout2;
    wire cout3;
    wire [15:0] sum1;
    wire [15:0] sum2;
    add16 adder1(.cin(0),.a(a[15:0]),.b(b[15:0]),.sum(sum[15:0]),.cout(cout1));
    add16 adder2(.cin(1),.a(a[31:16]),.b(b[31:16]),.sum(sum1),.cout(cout2));
    add16 adder3(.cin(0),.a(a[31:16]),.b(b[31:16]),.sum(sum2),.cout(cout3));
    always @(*) begin
        case (cout1)
            0 : sum[31:16] = sum2 ;
            1 : sum[31:16] = sum1 ;
        endcase
    end
endmodule