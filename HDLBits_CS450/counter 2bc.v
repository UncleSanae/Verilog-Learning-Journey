module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg[1:0] state
);
    reg [1:0] nextState;
    parameter SNT=0,WNT=1,WT=2,ST=3;
    always @(*) begin
        case (state)
            SNT: nextState <= train_taken?WNT:SNT;
            WNT: nextState <= train_taken?WT:SNT;
            WT : nextState <= train_taken?ST:WNT;
            ST : nextState <= train_taken?ST:WT;
            default: ;
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WNT;
        end
        else if (train_valid) begin
            state <= nextState;
        end
    end
endmodule