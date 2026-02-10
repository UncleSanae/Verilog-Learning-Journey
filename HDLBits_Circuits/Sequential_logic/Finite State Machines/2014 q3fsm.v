module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output reg z
);
    parameter A=2'd0,B1=2'd1,B2=2'd2,B3=2'd3;
    reg [1:0]state,nextState;
    reg [1:0] data;
    always @(*) begin
        case (state)
            A: nextState <= (s)?B1:A;
            B1: nextState <= B2;
            B2: nextState <= B3;
            B3: nextState <= B1;
            default: ; 
        endcase
    end
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            z <= 0;
            data <= 2'b0;
        end
        else begin
            state <= nextState;
            case (state)
                B1: begin
                    data[0] <= w;
                    z <= 0;
                end
                B2: begin
                    data[1] <= w;
                    z <= 0;
                end
                B3: z <= ((data[0]+data[1]+w) == 2);
                default: ;
            endcase
        end
    end
    
endmodule