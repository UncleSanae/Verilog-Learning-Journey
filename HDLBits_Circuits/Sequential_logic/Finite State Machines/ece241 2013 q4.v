module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
); 
    parameter s0=0,s1=1,s2=2,s3=3;
    reg [1:0] state,nextState;
    always @(posedge clk) begin
        if (reset) begin
            state <= s0;
        end
        else begin
            state <= nextState;
        end
    end
    always @(posedge clk) begin
        if (reset) begin
            fr1 <= 1;
            fr2 <= 1;
            fr3 <= 1;
            dfr <= 1;
        end
        else begin
            case (nextState)
                s0: begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 1;
                    dfr <= 1;
                end
                s1: begin
                    fr1 <= 1;
                    fr2 <= 1;
                    fr3 <= 0;
                end
                s2: begin
                    fr1 <= 1;
                    fr2 <= 0;
                    fr3 <= 0;
                end
                s3: begin
                    fr1 <= 0;
                    fr2 <= 0;
                    fr3 <= 0;
                end
                default: ;
            endcase
            if ((nextState < state )&&~(nextState == s0)) begin
                dfr <= 1;
            end
            if ((nextState > state )&&~(nextState == s0)) begin
                dfr <= 0;
            end
        end
    end
    always @(*) begin
        casez (s[3:1])
            3'b1zz : begin
                nextState <= s3;
            end 
            3'bz1z : begin
                nextState <= s2;
            end
            3'bzz1 : begin
                nextState <= s1;
            end
            default: nextState <= s0;
        endcase
    end
endmodule