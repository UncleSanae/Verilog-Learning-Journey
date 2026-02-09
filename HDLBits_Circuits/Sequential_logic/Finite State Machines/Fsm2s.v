module top_module (
    input clk,
    input reset,
    input j,
    input k,
    output reg out
);
    localparam OFF = 0,ON = 1;
    reg state,nextState;
    always @(*) begin
        case (state)
            OFF:nextState = (j)?ON:OFF;
            ON: nextState = (k)?OFF:ON;
            default:; 
        endcase
    end
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end
        else begin
            state <= nextState;
        end
    end
    always @(posedge clk) begin
        if (reset) begin
            out <= OFF;
        end
        else begin
            out <= nextState;
        end
    end
endmodule