module top_module(
    input clk,
    input [7:0] in,
    input reset,
    output reg[23:0] out_bytes,
    output reg done);
    parameter SEARCH = 0,READ1 = 1,READ2 = 2;
    reg [1:0]state,nextState;
    reg [23:0] read_bytes;
    always @(*) begin
        case (state)
            SEARCH: begin
                nextState<= in[3]?READ1:SEARCH;
            end
            READ1: begin
                nextState<= READ2;
            end
            READ2: begin
                nextState <= SEARCH;
            end
            default: ;
        endcase
    end
    always @(posedge clk) begin
        if (reset) begin
            state <= SEARCH;
        end
        else begin
            state <= nextState;
            done <= (state == READ2);
            case (nextState)
                SEARCH: out_bytes <= {read_bytes[23:8],in};
                READ1:  read_bytes[23:16] <= in;
                READ2:  read_bytes[15:8] <= in;
                default: ;
            endcase
        end     
    end
endmodule