module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg[7:0] hh,
    output reg[7:0] mm,
    output reg[7:0] ss); 
    wire s1,s2,m1,m2,h1,h2;
    assign s1 = (ss[3:0] == 4'd9);
    assign s2 = ((ss[7:4] == 4'd5)&&s1);
    assign m1 = ((mm[3:0]==4'd9)&&s2);
    assign m2 = ((mm[7:4]==4'd5)&&m1);
    assign h1 = ((hh[3:0]==4'd9)&&m2);
    always @(posedge clk) begin
        //重置
        if (reset) begin
            pm <= 0;
            hh[7:4] <= 4'd1;
            hh[3:0] <= 4'd2;
            mm[7:4] <= 4'd0;
            mm[3:0] <= 4'd0;
            ss[7:4] <= 4'd0;
            ss[3:0] <= 4'd0;
        end
        else if (ena) begin
            //秒个位
            if (s1) begin
                ss[3:0] <= 4'd0;
            end
            else begin
                ss[3:0] <= ss[3:0] + 1;
            end
            //秒十位
            if (s2) begin
                ss[7:4] <= 4'd0;
            end
            else if(s1) begin
                ss[7:4] <= ss[7:4] + 1;
            end
            //分个位
            if (m1) begin
                mm[3:0] <= 4'd0;
            end
            else if (s2) begin
                mm[3:0] <= mm[3:0] + 1;
            end
            //分十位
            if (m2) begin
                mm[7:4] <= 4'd0;
            end
            else if(m1) begin
                mm[7:4] <= mm[7:4] + 1;
            end
            //时
            if ((hh[7:4]==4'd1)&&(hh[3:0]==4'd2)&&m2) begin
                hh[7:4] <= 4'd0;
                hh[3:0] <= 4'd1;
            end
            else if ((hh[3:0]==4'd9)&&m2) begin
                hh[3:0] <= 4'd0;
                hh[7:4] <= 1;
            end
            else if (m2) begin
                hh[3:0] <= hh[3:0] + 1;
            end
            //pm
            if ((hh[7:4]==4'd1)&&(hh[3:0]==4'd1)&&m2) begin
                pm <= ~pm;
            end
        end
    end
endmodule