module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);
    assign z=(y==3'd3)||(y==3'd4);
    assign Y0=(y==3'd0&&x==1)||
              (y==3'd1&&x==0)||
              (y==3'd2&&x==1)||
              (y==3'd3&&x==0)||
              (y==3'd4&&x==0);
endmodule