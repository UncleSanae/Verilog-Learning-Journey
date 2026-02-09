module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah ); 
    parameter LEFT = 0 , RIGHT = 1,FALL_L = 2,FALL_R = 3 ;
    reg [1:0] state,nextState;
    always @(*) begin
        case (state)
            LEFT: nextState <= (ground)?((bump_left)?RIGHT:LEFT):FALL_L;
            RIGHT: nextState <= (ground)?((bump_right)?LEFT:RIGHT):FALL_R;
            FALL_L: nextState <= (ground)?LEFT:FALL_L;
            FALL_R: nextState <= (ground)?RIGHT:FALL_R;
            default:; 
        endcase
    end
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= LEFT;
        end
        else begin
            state <= nextState;
        end
    end
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
        end
        else begin
            case (nextState)
                LEFT:begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                end
                RIGHT:begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                end
                FALL_L:begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
                FALL_R:begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                end
                default: ;
            endcase
        end
    end
endmodule