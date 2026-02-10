module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);
    assign Y2 = (y[1]&w==0);
    assign Y4 = (y[2]&w==1)||(y[3]&w==1)||(y[5]&w==1)||(y[6]&w==1);
endmodule