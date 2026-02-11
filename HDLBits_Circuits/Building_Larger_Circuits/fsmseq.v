module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    parameter A=0,B=1,C=2,D=3,FINISH=4;
    reg [2:0] state,nextState;
    always @(*) begin
        case (state)
            A: nextState <= (data)?B:A;
            B: nextState <= (data)?C:A;
            C: nextState <= (data)?C:D;
            D: nextState <= (data)?FINISH:A;
            FINISH: nextState <= FINISH;
            default:; 
        endcase
    end
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
        end
        else  begin
            state <= nextState;
        end
    end
    assign start_shifting = state == FINISH;
endmodule