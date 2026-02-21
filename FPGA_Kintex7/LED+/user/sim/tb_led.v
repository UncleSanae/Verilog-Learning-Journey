`include "../src/led.v"
module tb_led();
    reg     key;
    wire    led;
    initial begin
        key <= 1'b1;
        #200
        key <= 1'b1;
        #400
        key <= 1'b0;
        #600
        key <= 1'b1;
        #800
        key <= 1'b0;
    end
    led sim_led (.key(key),.led(led));
    initial begin
    //$dumpfile("user/sim/led.vcd");        
    //$dumpvars(0, tb_led);
    #1000 $finish();
    end
endmodule
