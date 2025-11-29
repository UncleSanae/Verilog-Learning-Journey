`timescale 1ns/1ns
module and_gate_tb;
    reg a;
    reg b;
    wire y;
    and_gate my_and_gate(
        .a(a),
        .b(b),
        .y(y)
    );
    initial begin
        $dumpfile("and_gate.vcd");
        $dumpvars(0,and_gate_tb);
    end
    initial begin
        a=0;b=0;
        #10;
        a=0;b=1;
        #10;
        a=1;b=0;
        #10;
        a=1;b=1;
        #10;
        $finish;
    end
    initial begin
        $monitor("Time=%t | a=%b b=%b | y=%b",$time,a,b,y);
    end
endmodule