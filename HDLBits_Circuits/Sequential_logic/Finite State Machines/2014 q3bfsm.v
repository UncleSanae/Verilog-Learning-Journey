module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
    );
    parameter A=3'b000,B=3'b001,C=3'b010,D='b011,E=3'b100;
    reg [2:0] state,nextState;
    always @(*) begin
        case (state)
            A: nextState <= (x)?B:A;
            B: nextState <= (x)?E:B;
            C: nextState <= (x)?B:C;
            D: nextState <= (x)?C:B;
            E: nextState <= (x)?E:D;
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
    assign z = (state == D)|(state == E);
endmodule