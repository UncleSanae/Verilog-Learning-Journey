module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
    parameter A=0,B=1,C=2,D=3,E=4,F=5;
    reg [2:0] state,nextState;
    always @(*) begin
        case (state)
            A: nextState <= (w)?B:A;
            B: nextState <= (w)?C:D;
            C: nextState <= (w)?E:D;
            D: nextState <= (w)?F:A;
            E: nextState <= (w)?E:D;
            F: nextState <= (w)?C:D; 
            default: ;
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
    assign z = (state == E)||(state == F);
endmodule