module top_module (
    input a,
    input b,
    output q );//

    assign q = a&b;

    initial begin
    $dumpfile("prj/icarus/circuit1.vcd");        
    $dumpvars(0,top_module);
    #2000 $finish();
    end
endmodule