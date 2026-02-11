module top_module(
    input clk,
    input reset,
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack
);
    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, COUNT=8, DONE=9;
    reg [3:0] state, next_state;
    reg [3:0] shift_reg;
    reg [9:0] delay_cnt;
    reg [3:0] count_reg;
    always @(*) begin
        case(state)
            S:    next_state = (data) ? S1 : S;
            S1:   next_state = (data) ? S11 : S;
            S11:  next_state = (data) ? S11 : S110;
            S110: next_state = (data) ? B0 : S; 
            B0:   next_state = B1;
            B1:   next_state = B2;
            B2:   next_state = B3;
            B3:   next_state = COUNT;
            COUNT: next_state = (count_reg == 0 && delay_cnt == 0) ? DONE : COUNT;
            DONE: next_state = (ack) ? S : DONE;
            default: next_state = S;
        endcase
    end
    always @(posedge clk) begin
        if(reset) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end
    always @(posedge clk) begin
        if(reset) begin
            shift_reg <= 0;
        end else if(state == B0 || state == B1 || state == B2 || state == B3) begin
            shift_reg <= {shift_reg[2:0], data};
        end
    end
    always @(posedge clk) begin
        if(reset) begin
            count_reg <= 0;
            delay_cnt <= 0;
        end 
        else if(state == COUNT) begin
            if(delay_cnt == 0) begin
                count_reg <= count_reg - 1;
                delay_cnt <= 999;
            end else begin
                delay_cnt <= delay_cnt - 1;
            end
        end 
        else if(state == B3) begin
            count_reg <= {shift_reg[2:0], data};
            delay_cnt <= 999;
        end
    end
    assign count = count_reg;
    assign counting = (state == COUNT);
    assign done = (state == DONE);
endmodule