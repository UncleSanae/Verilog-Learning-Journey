module breath_led(
    input       sys_clk_p,
    input       sys_clk_n,
    input       sys_rst_n,

    output reg  led
);


parameter       CNT_2US_MAX = 8'd200;
parameter       CNT_2MS_MAX = 11'd1000;
parameter       CNT_2S_MAX = 11'd1000;

reg [7:0] cnt_2us;
reg [10:0] cnt_2ms;
reg [10:0] cnt_2s;


reg inc_dec_flag;


wire sys_clk;


IBUFDS #(
    .CAPACITANCE("DONT_CARE"), // "LOW", "NORMAL", "DONT_CARE" (Virtex-4 only)
    .DIFF_TERM("FALSE"),       // Differential Termination (Virtex-4/5, Spartan-3E/3A)
    .IBUF_DELAY_VALUE("0"),    // Specify the amount of added input delay for
    .IFD_DELAY_VALUE("AUTO"),  // Specify the amount of added delay for input
    .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
) IBUFDS_inst (
    .O(sys_clk),  // Buffer output
    .I(sys_clk_p),  // Diff_p buffer input (connect directly to top-level port)
    .IB(sys_clk_n) // Diff_n buffer input (connect directly to top-level port)
);

always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
        cnt_2us <= 8'd0;
        cnt_2ms <= 11'd0;
        cnt_2s  <= 11'd0;
        inc_dec_flag <= 1'b0;
    end
    else begin
        if(cnt_2us == (CNT_2US_MAX-8'd1))begin
            cnt_2us <= 8'd0;
            if(cnt_2ms == (CNT_2MS_MAX-11'd1))begin
                cnt_2ms <= 11'd0;
                if(cnt_2s == (CNT_2S_MAX-11'd1))begin
                    cnt_2s <= 11'd0;
                    inc_dec_flag <= ~inc_dec_flag;
                end
                else begin
                    cnt_2s <= cnt_2s + 11'd1;
                end
            end
            else begin
                cnt_2ms <= cnt_2ms + 11'd1;
            end
        end
        else begin
            cnt_2us <= cnt_2us + 8'd1;
        end
    end
end

always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n)begin
        led <= 1'b0;
    end
    else begin
        if(((inc_dec_flag == 1'b1) && (cnt_2ms >= cnt_2s)) || ((inc_dec_flag == 1'b0) && (cnt_2ms <= cnt_2s)))begin
            led <= 1'b1;
        end
        else begin
            led <= 1'b0;
        end
    end
end

ila_0 your_instance_name (
	.clk(sys_clk), // input wire clk
	.probe0(sys_rst_n), // input wire [0:0]  probe0  
	.probe1(cnt_2us), // input wire [7:0]  probe1 
	.probe2(cnt_2ms), // input wire [10:0]  probe2 
	.probe3(cnt_2s), // input wire [10:0]  probe3 
	.probe4(inc_dec_flag), // input wire [0:0]  probe4 
	.probe5(led) // input wire [0:0]  probe5
);

endmodule