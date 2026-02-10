module top_module(
    input clk,
    input in,
    input reset,
    output reg[7:0] out_byte,
    output reg done
);
    //状态表
    parameter SEARCH_BEGIN=0,READ=1,CHECK=2,SEARCH_END=3,WRONG=4;
    reg[2:0]state,nextState;
    //读取时间（0-8）
    reg[3:0] readTime;
    reg check;
    //状态转换
    always @(*) begin
        case (state)
            SEARCH_BEGIN : nextState <= (~in)?READ:SEARCH_BEGIN;
            SEARCH_END : nextState <= (in)?SEARCH_BEGIN:WRONG;
            WRONG : nextState <= (in)?SEARCH_BEGIN:WRONG;
            READ : nextState <= (readTime >= 8)?CHECK:READ;
            CHECK : nextState <= SEARCH_END;
            default: ;
        endcase
    end
    //状态转移
    always @(posedge clk) begin
        if (reset) begin
            state <= SEARCH_BEGIN;
        end
        else begin
            state <= nextState;
        end
    end
    //状态操作
    always @(posedge clk) begin
        if (reset) begin
            done <= 0;
            readTime <= 0;
        end
        else begin
            case (nextState)
                SEARCH_BEGIN: begin
                    readTime <= 0;
                    if (state == SEARCH_END&&check) begin
                        done <= 1;
                    end
                    else begin
                        done <= 0;
                    end
                end
                SEARCH_END:begin
                    readTime <= 0;
                    done <= 0;
                    if (state == CHECK) begin
                        check <= (^out_byte[7:0])^in;
                    end
                end
                WRONG: begin
                    readTime <= 0;
                    done <= 0;
                end
                READ: begin
                    out_byte[readTime] <= in;
                    readTime <= readTime + 1;
                    done <= 0;
                end
                CHECK: begin
                    readTime <= 0;
                    done <= 0;
                    out_byte[7:0] <= {in,out_byte[7:1]};
                end
                default:; 
            endcase
        end
    end
endmodule