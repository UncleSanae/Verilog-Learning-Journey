module top_module (
    input clk,
    input areset,
    input x,
    output reg z
); 
    parameter CARRY=0,OUT=1,STOP=2;
    reg state,nextState;
    always @(*) begin
        case (state)
            CARRY: nextState <= (x)?OUT:CARRY;
            OUT: nextState <= OUT;
            STOP: nextState <= (areset)?STOP:CARRY;
            default:; 
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STOP;
        end
        else begin
            state <= nextState;
        end
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            z <= 0;
        end
        else begin
            case (state)
                CARRY: z <= x;
                OUT: z <= ~x;
                default:  ;
            endcase
        end
    end
endmodule