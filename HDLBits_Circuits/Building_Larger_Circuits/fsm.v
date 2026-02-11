module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    parameter T=0,T1=1,T11=2,T110=3,S=4,S1=5,S2=6,S3=7,C=8,D=9;
    reg [3:0]state,nextState;
    always @(*) begin
        case (state)
            T: nextState <= (data)?T1:T;
            T1: nextState <= (data)?T11:T;
            T11: nextState <= (data)?T11:T110;
            T110: nextState <= (data)?S:T;
            S : nextState <= S1;
            S1: nextState <= S2;
            S2: nextState <= S3;
            S3: nextState <= C;
            C: nextState <= done_counting?D:C;
            D: nextState <= ack?T:D; 
            default:; 
        endcase
    end
    always @(posedge clk) begin
        if (reset) begin
            state <= T;
        end
        else begin
            state <=  nextState;
        end
    end
    assign shift_ena = (state == S)||(state == S1)||(state == S2)||(state == S3);
    assign counting = state == C;
    assign done = state == D;
endmodule
