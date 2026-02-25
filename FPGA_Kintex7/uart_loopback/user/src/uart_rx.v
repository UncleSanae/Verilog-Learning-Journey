module uart_rx(

    input               clk,
    input               rst_n,

    input               uart_rxd,
    output reg          uart_rx_done,
    output reg [7:0]    uart_rx_data
);
    
    parameter           CLK_FREQ = 100000000;
    parameter           UART_BPS = 115200;
    localparam          BUAD_CNT_MAX = CLK_FREQ/UART_BPS;

    reg                 uart_rxd_d0;
    reg                 uart_rxd_d1;
    reg                 uart_rxd_d2;

    reg                 rx_flag;
    reg [3:0]           rx_cnt;
    reg [15:0]          baud_cnt;
    reg [7:0]           rx_data_t; 

    wire                start_en;
    assign              start_en = uart_rxd_d2 & (~uart_rxd_d1) & (~rx_flag);

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            uart_rxd_d0 <= 1'b0;
            uart_rxd_d1 <= 1'b0;
            uart_rxd_d2 <= 1'b0;
        end
        else begin
            uart_rxd_d0 <= uart_rxd;
            uart_rxd_d1 <= uart_rxd_d0;
            uart_rxd_d2 <= uart_rxd_d1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            rx_flag <= 1'b0;
        end
        else if(start_en)begin
            rx_flag <= 1'b1;
        end
        else if((rx_cnt == 4'd9) && (baud_cnt == BUAD_CNT_MAX/2 - 1'b1))begin
            rx_flag <= 1'b0;
        end
        else begin
            rx_flag <= rx_flag;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            baud_cnt <= 16'd0;
        end
        else if(rx_flag)begin
            if(baud_cnt < BUAD_CNT_MAX)begin
                baud_cnt <= baud_cnt + 16'b1;
            end
            else begin
                baud_cnt <= 16'd0;
            end
        end
        else begin
            baud_cnt <= 16'd0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            rx_cnt <= 4'd0;
        end
        else if(rx_flag)begin
            if(baud_cnt == BUAD_CNT_MAX/2 - 1'b1)begin
                rx_cnt <= rx_cnt + 4'b1;
            end
            else begin
                rx_cnt <= rx_cnt;
            end
        end
        else begin
            rx_cnt <= 4'd0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            rx_data_t <= 8'd0;
        end
        else if(rx_flag)begin
            if(baud_cnt == BUAD_CNT_MAX/2 - 1'b1)begin
                case (rx_cnt)
                    4'd1:   rx_data_t[0] <= uart_rxd_d2;
                    4'd2:   rx_data_t[1] <= uart_rxd_d2;
                    4'd3:   rx_data_t[2] <= uart_rxd_d2;
                    4'd4:   rx_data_t[3] <= uart_rxd_d2;
                    4'd5:   rx_data_t[4] <= uart_rxd_d2;
                    4'd6:   rx_data_t[5] <= uart_rxd_d2;
                    4'd7:   rx_data_t[6] <= uart_rxd_d2;
                    4'd8:   rx_data_t[7] <= uart_rxd_d2;
                    default:;
                endcase
            end
            else begin
               rx_data_t <= rx_data_t; 
            end
        end
        else begin
            rx_data_t <= 8'd0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)begin
            uart_rx_done <= 1'b0;
            uart_rx_data <= 8'd0;
        end
        else if((rx_cnt == 4'd9) && (baud_cnt == BUAD_CNT_MAX/2 - 1'b1))begin
            uart_rx_done <= 1'b1;
            uart_rx_data <= rx_data_t;
        end
        else begin
            uart_rx_done <= 1'b0;
            uart_rx_data <= uart_rx_data;
        end
    end

endmodule