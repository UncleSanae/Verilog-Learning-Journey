module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    reg [255:0] next_q;
    integer i, j, x, y;
    reg [3:0] neighbors;
    integer cur_row, cur_col, nb_row, nb_col;

    always @(*) begin
        for(i=0; i<16; i=i+1) begin: rows
            for(j=0; j<16; j=j+1) begin: cols
                neighbors = 4'd0;
                for(y=-1; y<=1; y=y+1) begin
                    for(x=-1; x<=1; x=x+1) begin
                        if(x!=0 || y!=0) begin
                            nb_row = (i + y + 16) % 16;
                            nb_col = (j + x + 16) % 16;
                            neighbors = neighbors + q[nb_row*16 + nb_col];
                        end
                    end
                end
                case(neighbors)
                    2: next_q[i*16 + j] = q[i*16 + j];
                    3: next_q[i*16 + j] = 1'b1;
                    default: next_q[i*16 + j] = 1'b0;
                endcase
            end
        end
    end
    always @(posedge clk) begin
        if(load)
            q <= data;
        else
            q <= next_q;
    end
endmodule