module top_module(
    input clk,
    input reset,    
    input in,
    output reg disc,
    output reg flag,
    output reg err
);
    parameter IDLE=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6,ERROR=7;
    reg[2:0] state,next_state;
    always@(*)begin
        case(state)
            IDLE:next_state=in?S1:IDLE;
            S1:  next_state=in?S2:IDLE;
            S2:  next_state=in?S3:IDLE;
            S3:  next_state=in?S4:IDLE;
            S4:  next_state=in?S5:IDLE;
            S5:  next_state=in?S6:IDLE;
            S6:  next_state=in?ERROR:IDLE;
            ERROR:next_state=in?ERROR:IDLE;
            default:next_state=IDLE;
        endcase
    end
    always@(posedge clk)begin
        if(reset)begin
            state<=IDLE;
            disc<=0;
            flag<=0;
            err<=0;
        end else begin
            state<=next_state;
            disc<=(state==S5&&!in);
            flag<=(state==S6&&!in);
            err<=(next_state==ERROR);
        end
    end

endmodule