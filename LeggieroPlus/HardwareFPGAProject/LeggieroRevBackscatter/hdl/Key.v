`include "Define.v"

module Key (
    input wire clk,
    input wire rst_n,
    
    input wire key_i,
    output reg key_pressed_pulse_o
);

localparam NO_PRESSED = 2'b00;
localparam PRESSING = 2'b01;
localparam PRESSED = 2'b11;
localparam NO_PRESSING = 2'b10;

localparam CNT_PER_US = 20;
localparam CNT_PER_MS = 20000;
localparam CNT_PRESS = CNT_PER_MS * 2;
localparam CNT_NO_PRESS = CNT_PER_US * 1;

reg [15: 0] g_counter_r;
reg [15: 0] next_g_counter_r;

reg [1: 0] status;
reg [1: 0] next_status;

always @(posedge clk) begin
    if (~rst_n) begin
        status <= NO_PRESSED;
        g_counter_r <= 16'b0;
    end else begin
        status <= next_status;
        g_counter_r <= next_g_counter_r;
    end
end 

always @(*) begin
    case (status)
        NO_PRESSED: begin
            if (key_i == `ENABLE_N) begin
                next_status = PRESSING;
                next_g_counter_r = 16'b0;
            end else begin
                next_status = NO_PRESSED;
                next_g_counter_r = 16'b0;
            end
        end
        PRESSING: begin
            if (key_i == `ENABLE_N) begin
                if (g_counter_r < CNT_PRESS - 1) begin
                    next_status = PRESSING;
                    next_g_counter_r = g_counter_r + 16'b1;
                end else begin
                    next_status = PRESSED;
                    next_g_counter_r = 16'b0;
                end
            end else begin
                next_status = NO_PRESSED;
                next_g_counter_r = 16'b0;
            end
        end 
        PRESSED: begin
            if (key_i == `DISABLE_N) begin
                next_status = NO_PRESSING;
                next_g_counter_r = 16'b0;
            end else begin
                next_status = PRESSED;
                next_g_counter_r = 16'b0;
            end
        end
        NO_PRESSING: begin
            if (key_i == `DISABLE_N) begin
                if (g_counter_r < CNT_PER_US - 1) begin
                    next_status = NO_PRESSING;
                    next_g_counter_r = g_counter_r + 16'b1;
                end else begin
                    next_status = NO_PRESSED;
                    next_g_counter_r = 16'b0;
                end
            end else begin
                next_status = PRESSED;
                next_g_counter_r = 16'b0;
            end
        end
        default: begin
            next_status = NO_PRESSED;
            next_g_counter_r = 16'b0;            
        end 
    endcase
end

always @(*) begin
    if (status == PRESSING && key_i == `ENABLE_N && g_counter_r == CNT_PRESS - 1) begin
        key_pressed_pulse_o = `ENABLE;
    end else begin
        key_pressed_pulse_o = `DISABLE;
    end
end

endmodule