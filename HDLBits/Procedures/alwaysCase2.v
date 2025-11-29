// synthesis verilog_input_version verilog_2001
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
    always @(*) begin
        casez (in)
            4'b???1: pos = 2'd0;  // 只要最低位是1，不管高位是啥，输出0
            4'b??10: pos = 2'd1;  // 最低位必须是0，第1位是1
            4'b?100: pos = 2'd2;
            4'b1000: pos = 2'd3;
            default: pos = 2'd0;
        endcase
    end
endmodule
