module top_module ();
    reg clk;
    reg reset;
    reg t;
    wire q;
    tff dut (
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );
    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        reset = 0;
        t = 0;
        #10;
        reset = 1;
        #10;
        reset = 0;
        t = 1;
        #10; 
        t = 0; 
        #10 $finish;
    end

endmodule