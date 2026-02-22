module key_debounce(
    //按键消抖模块
    //时钟输入
    input       sys_clk,
    //复位输入
    input       sys_rst_n,
    //按键输入
    input       key,
    //按键输出
    output reg  key_filter
);

//等待时间20ms
parameter CNT_MAX = 21'd200_0000;
//寄存器
//计数器
reg [20:0] cnt;
//按键延迟
reg        key_d0;
reg        key_d1;
//按键延迟寄存器
//延迟储存两个时钟沿，作为变化监测
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
        key_d0 <= 1'b1;
        key_d1 <= 1'b1;
    end
    else begin
        key_d0 <= key;
        key_d1 <= key_d0;
    end
end
//按键消抖
//检测按键是否变化，如果变化启动计数器
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
        cnt <= 21'd0;
    end
    else begin
        if(key_d0 != key_d1)begin
            cnt <= CNT_MAX;
        end
        else begin
            if(cnt > 21'd0)begin
                cnt <= cnt - 1'b1;
            end
            else begin
                cnt <= 21'd0;
            end
        end
    end
end
//送出检测值
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
        key_filter <= 1'b1;
    end
    else if(cnt == 21'd2)begin
        key_filter <= key_d1;
    end
    else begin
        key_filter <= key_filter;
    end
end
endmodule