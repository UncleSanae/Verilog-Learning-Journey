module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output reg done); //
    parameter SEARCH = 0,READ1 = 1,READ2 = 2;
    reg [1:0]state,nextState;
    always @(*) begin
        case (state)
            SEARCH: nextState<= in[3]?READ1:SEARCH;
            READ1: nextState<= READ2;
            READ2: nextState <= SEARCH;
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
        end     
    end
    // State transition logic (combinational)

    // State flip-flops (sequential)
 
    // Output logic

endmodule