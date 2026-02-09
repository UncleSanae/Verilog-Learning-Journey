module top_module(
    input clk,
    input in,
    input reset,
    output reg out); 
    parameter A = 0,B = 1,C = 2,D = 3;
    reg [1:0] state,nextState;
    always @(*) begin
        case (state)
            A:nextState <= (in)?B:A;
            B:nextState <= (in)?B:C;
            C:nextState <= (in)?D:A;
            D:nextState <= (in)?B:C;
            default:; 
        endcase
    end
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else begin
            state <= nextState;
        end
    end
    always @(posedge clk) begin
        if (reset) begin
            out <= 0;
        end
        else begin
            case (nextState)
                A: out <= 0;
                B: out <= 0;
                C: out <= 0;
                D: out <= 1;
                default: ;
            endcase
        end
    end
endmodule