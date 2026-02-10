module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
    assign Y1 = (y[0]&w==1);
    assign Y3 = (y[1]&w==0)||(y[2]&w==0)||(y[4]&w==0)||(y[5]&w==0);
endmodule