module flow_led(
    input               sys_clk_p,
    input               sys_clk_n,
    input               sys_rst_n,
    input               key_1,
    output reg[1:0]     led
);
//时钟，计数器
reg [28:0] cnt;
wire sys_clk;
IBUFDS diff_clock(.I (sys_clk_p),.IB(sys_clk_n),.O (sys_clk));
//状态转换
parameter MODE_1=4'b0001,MODE_2=4'b0010,MODE_3=4'b0100,MODE_4=4'b1000;
wire[28:0] pause;
reg [3:0] st,next_st;
always @(*) begin
    case (st)
        MODE_1: next_st = MODE_2;
        MODE_2: next_st = MODE_3;
        MODE_3: next_st = MODE_4;
        default: next_st = MODE_1;
    endcase
end
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
        st <= MODE_1;
    end
    else if((!key_1)&&(cnt==(pause-29'd1)))begin
        st <= next_st;
    end
end
assign pause = st[0] ? 29'd5_0000_0000 :
               st[1] ? 29'd1_0000_0000 :
               st[2] ? 29'd5000_0000 :
               st[3] ? 29'd500_0000 : 29'd0;
//计数控制
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
        cnt <= 29'd0;
    end
    else if(cnt < (pause - 29'd1))begin
        cnt <= cnt + 29'd1;
    end
    else begin
        cnt <= 29'd0;
    end
end
//led控制
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
        led <= 2'b01;
    end
    else if(cnt == (pause - 29'd1))begin
        led <= {led[0],led[1]};
    end
    else begin
        led <= led;
    end
end
initial begin
    st <= MODE_1;
end
endmodule