///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: PKT_DECT.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::IGLOO> <Die::AGLN125V5> <Package::100 VQFP>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module PKT_DECT(
    input wire clk,
    input wire rst_n,
    input wire dect_in,
    output reg dect_out
);

localparam NO_PACKET = 2'b00;
localparam IN_PACKET = 2'b11;
localparam IN_TO_NO_PACKET = 2'b10;

localparam CNT_PER_US = 20;
localparam CNT_NO_PACKET = CNT_PER_US * 20;

reg [15:0] g_counter_r;
reg [15:0] next_g_counter_r;

reg [1:0] status;
reg [1:0] next_status;

initial begin
    g_counter_r <= 16'b0;
    next_g_counter_r <= 16'b0;
    status <= NO_PACKET;
    next_status <= NO_PACKET;
end

always @(posedge clk) begin
    if (~rst_n) begin
        status <= NO_PACKET;
        g_counter_r <= 16'b0;
    end else begin
        status <= next_status;
        g_counter_r <= next_g_counter_r;
    end
end

always @(*) begin
    case (status)
        NO_PACKET: begin
            if (dect_in == 1'b1) begin
                next_status = IN_PACKET;
                next_g_counter_r = 16'b0;
            end else begin
                next_status = NO_PACKET;
                next_g_counter_r = 16'b0;
            end
        end
        IN_PACKET: begin
            if (dect_in == 1'b0) begin
                next_status = IN_TO_NO_PACKET;
                next_g_counter_r = 16'b0;
            end else begin
                next_status = IN_PACKET;
                next_g_counter_r = 16'b0;
            end
        end
        IN_TO_NO_PACKET: begin
            if (dect_in == 1'b0) begin
                if (g_counter_r < CNT_NO_PACKET - 1) begin
                    next_status = IN_TO_NO_PACKET;
                    next_g_counter_r = g_counter_r + 16'b1;
                end else begin
                    next_status = NO_PACKET;
                    next_g_counter_r = 16'b0;
                end
            end else begin
                next_status = IN_PACKET;
                next_g_counter_r = 16'b0;
            end
        end
        default: begin
            next_status = NO_PACKET;
            next_g_counter_r = 16'b0;
        end
    endcase
end

always @(*) begin
    if (status == NO_PACKET) begin
        dect_out = 1'b0;
    end else begin
        dect_out = 1'b1;
    end
end

endmodule