module ledpp(
    input       key1,
    input       key2,
    output      led1,
    output      led2
);

parameter num1 = 2'b00,num2 = 2'b01,out = 2'b10;
reg [1:0] state,next_state;
reg [1:0] numA = 2'b00,numB = 2'b00;
assign {led1,led2} = (state == num1)?numA:((state == num2)?numB:(numA+numB));
always @(*) begin
    case (state)
        2'b00 : next_state = num2 ;
        2'b01 : next_state = out ;
        default : next_state = num1 ; 
    endcase
end
always @(negedge key1) begin
    state <= next_state;
end
always @(negedge key2) begin
    case (state)
        2'b00 : numA = numA + 1;
        2'b01 : numB = numB + 1;
        default : begin 
            numA = 0;
            numB = 0;
        end
    endcase 
end
initial begin
    state = num1;
end
endmodule