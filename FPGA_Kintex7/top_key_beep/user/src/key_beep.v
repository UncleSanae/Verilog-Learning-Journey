module key_beep(
    //按键控制蜂鸣器
    //时钟
    input       sys_clk,
    input       sys_rst_n,
    //消抖后按键信号
    input       key_filter,
    //蜂鸣器
    output reg  beep
);
    //按键信号延迟
    reg key_filter_d0;
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n)begin
            key_filter_d0 <= 1'b1;
        end
        else begin
            key_filter_d0 <= key_filter;           
        end
    end
    //有效按压信号
    wire neg_key_filter;
    assign neg_key_filter = (~key_filter)&key_filter_d0;
    //蜂鸣器翻转
    always @(posedge sys_clk or negedge sys_rst_n) begin
        if(!sys_rst_n)begin
            beep <= 1'b0;
        end
        else begin
            if(neg_key_filter)begin
                beep <= ~beep;
            end
            else begin
                beep <= beep;
            end
        end
    end
endmodule