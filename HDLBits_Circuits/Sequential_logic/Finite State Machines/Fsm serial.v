module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output reg done
); 
    parameter SEARCH_BEGIN=0,READ=1,SEARCH_END = 2,WRONG = 3;
    reg[1:0]state,nextState;
    reg[3:0] readTime;
    always @(*) begin
        case (state)
            SEARCH_BEGIN : nextState <= (~in)?READ:SEARCH_BEGIN;
            SEARCH_END : nextState <= (in)?SEARCH_BEGIN:WRONG;
            WRONG : nextState <= (in)?SEARCH_BEGIN:WRONG;
            READ : nextState <= (readTime >= 8)?SEARCH_END:READ;
            default: ;
        endcase
    end
    always @(posedge clk) begin
        if (reset) begin
            state <= SEARCH_BEGIN;
        end
        else begin
            state <= nextState;
        end
    end
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
            readTime <= 0;
        end
        else begin
            case (nextState)
                SEARCH_BEGIN: begin
                    readTime <= 0;
                    if (state == SEARCH_END) begin
                        done <= 1;
                    end
                    else begin
                        done <= 0;
                    end
                end
                SEARCH_END:begin
                    readTime <= 0;
                    done <= 0;
                end
                WRONG: begin
                    readTime <= 0;
                    done <= 0;
                end
                READ: begin
                    readTime <= readTime + 1;
                    done <= 0;
                end
                default:; 
            endcase
        end
    end
endmodule