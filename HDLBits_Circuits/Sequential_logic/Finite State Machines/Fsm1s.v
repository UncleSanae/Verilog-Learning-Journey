module top_module(
    input clk,
    input reset,    // Asynchronous reset to state B
    input in,
    output reg out);
    parameter A=0, B=1; 
    reg state, next_state;
    //状态转换
    always @(*) begin
        case (state)
            A: next_state =(in)?A:B; 
            default: next_state =(in)?B:A;
        endcase
    end
    //状态传递
    always @(posedge clk) begin    
        if (reset) begin
            state <= B;
        end
        else begin
            state <= next_state;
        end
    end
    //输出
    always @(posedge clk) begin    
        if (reset) begin
            out <= 1;
        end
        else begin
            case (next_state)
                A: out <= 0; 
                default: out <= 1;
            endcase
        end
    end
endmodule