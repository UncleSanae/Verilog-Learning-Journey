module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging ); 
    parameter LEFT=0,RIGHT=1,DIG_L=2,DIG_R=3,FALL_L=4,FALL_R=5,SPLAT=6,DEAD=7;
    reg [2:0]state,nextState;
    reg [20:0] fallDistance;
    always @(*) begin
        case (state)
            0: nextState <= ground?(dig?DIG_L:(bump_left?RIGHT:LEFT)):FALL_L;
            1: nextState <= ground?(dig?DIG_R:(bump_right?LEFT:RIGHT)):FALL_R;
            2: nextState <= ground?DIG_L:FALL_L;
            3: nextState <= ground?DIG_R:FALL_R;
            4: nextState <= ((fallDistance >= 20)&&ground)?DEAD:(ground?LEFT:FALL_L);
            5: nextState <= ((fallDistance >= 20)&&ground)?DEAD:(ground?RIGHT:FALL_R);
            6: nextState <= DEAD;
            7: nextState <= DEAD;
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
    always@(posedge clk or posedge areset)begin
        if (areset) begin
            fallDistance <= 0;
        end 
        else if(state==FALL_L||state==FALL_R) begin 
            fallDistance <= fallDistance+1;
        end
        else begin
            fallDistance <= 0;
        end
    end
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end
        else begin
            case (nextState)
                LEFT:begin
                    walk_left <= 1;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
                RIGHT:begin
                    walk_left <= 0;
                    walk_right <= 1;
                    aaah <= 0;
                    digging <= 0;
                end
                FALL_L:begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end
                FALL_R:begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end
                DIG_L:begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
                DIG_R:begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 1;
                end
                SPLAT:begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 1;
                    digging <= 0;
                end
                DEAD:begin
                    walk_left <= 0;
                    walk_right <= 0;
                    aaah <= 0;
                    digging <= 0;
                end
                default: ;
            endcase
        end
    end
endmodule
