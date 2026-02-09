module top_module(
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out); 
    parameter A=0, B=1, C=2, D=3;
    always @(*) begin
        case (state)
            A:next_state <= (in)?B:A;
            B:next_state <= (in)?B:C;
            C:next_state <= (in)?D:A;
            D:next_state <= (in)?B:C;
            default: ;
        endcase
        case (state)
            A,B,C: out <= 0; 
            D : out <= 1;
            default: ;
        endcase
    end

endmodule