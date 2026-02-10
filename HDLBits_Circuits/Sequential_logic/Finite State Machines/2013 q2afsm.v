module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter NONE=0,A=1,B=2,C=3;
    reg[1:0] state,nextState;
    always @(*) begin
        case (state)
            NONE:begin
                nextState <= r[1]?A:(r[2]?B:(r[3]?C:NONE));
            end 
            A: nextState <= r[1]?A:NONE;
            B: nextState <= r[2]?B:NONE;
            C: nextState <= r[3]?C:NONE;
            default: ;
        endcase
    end
    always @(posedge clk) begin
        if (~resetn) begin
            state <= NONE;
        end
        else begin
            state <= nextState;
        end
    end
    assign g[1] = (state==A);
    assign g[2] = (state==B);
    assign g[3] = (state==C);
endmodule