module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output reg z ); 
    parameter NONE=0,ONE=1,TWO=2,THREE=3;
    reg[1:0] state,nextState;
    always @(*) begin
        case (state)
            NONE:nextState <= (x)?ONE:NONE; 
            ONE:nextState <= (x)?ONE:TWO;
            TWO:nextState <= (x)?ONE:NONE;
            default: ;
        endcase
    end
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= NONE;
        end
        else begin
            state <= nextState;
        end
    end
    always @(posedge clk or negedge aresetn) begin
        z <= (state==TWO)&(x);
    end
endmodule