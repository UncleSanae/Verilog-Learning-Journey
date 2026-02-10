module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
    parameter SEARCH=0,F=1,X1=2,X2=3,X3=4,G1=5,G2=6,GPOS=7,GNEG=8;
    reg [3:0] state,nextState;
    always @(*) begin
        case (state)
            SEARCH: nextState <= F;
            F:  nextState <= X1;
            X1: nextState <= (x)?X2:X1;
            X2: nextState <= (x)?X2:X3;
            X3: nextState <= (x)?G1:X1;
            G1: nextState <= (y)?GPOS:G2;
            G2: nextState <= (y)?GPOS:GNEG;
            GPOS: nextState <= GPOS;
            GNEG: nextState <= GNEG;
            default:; 
        endcase
    end
    always @(posedge clk) begin
        if (~resetn) begin
            state <= SEARCH;
        end
        else begin
            state <= nextState;
        end
    end
    assign f = state == F;
    assign g = state == G1||state == G2||state == GPOS;
endmodule