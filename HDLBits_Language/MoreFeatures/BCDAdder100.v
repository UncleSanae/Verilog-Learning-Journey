module top_module( 
    input [399:0] a, b,
    input cin,
    output cout,
    output [399:0] sum );
    genvar i ;
    wire[99:0] coutReg;
    generate
        for (i = 0;i<100 ;i = i+1 ) begin : BCDAdder100
            if (i == 0) begin
                bcd_fadd inst (.a(a[((i+1)*4-1):i*4]),.b(b[((i+1)*4-1):i*4]),.cin(cin),.cout(coutReg[i]),.sum(sum[((i+1)*4-1):i*4]));
            end
            else begin
                bcd_fadd inst (.a(a[((i+1)*4-1):i*4]),.b(b[((i+1)*4-1):i*4]),.cin(coutReg[i-1]),.cout(coutReg[i]),.sum(sum[((i+1)*4-1):i*4]));
            end
            
        end
    endgenerate
    assign cout = coutReg[99];
endmodule

module bcd_fadd (input[3:0]a,b,input cin,output reg cout,output reg [3:0]sum);
    always @(*) begin
        if (a+b+cin >= 10) begin
            cout = 1;
            sum = a+b+cin -10;
        end
        else begin
            cout = 0;
            sum = a+b+cin;
        end
    end
endmodule