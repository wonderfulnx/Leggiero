///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: Modulator.v
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

module modulator(EN, CLK, DEC_IN, rst_n, ASW_OUT);
input EN, CLK, DEC_IN, rst_n;
output reg ASW_OUT;

// indicate whether have seen a packet:
//    0 -> have not seen a packet before
//    1 -> have seen the packet
reg current_status;
reg [31:0] clk_counter;

initial begin
    clk_counter <= 32'd0;
    current_status <= 0;
    ASW_OUT <= 1'b0;
end

always @(posedge CLK)
begin
    if (~rst_n) begin
        clk_counter <= 32'd0;
        current_status <= 0;
        ASW_OUT <= 1'b0;
    end
    else if (~EN) begin
        clk_counter <= 32'd0;
        current_status <= 0;
        ASW_OUT <= 1'b0;
    end
    else if (DEC_IN) begin
        if (current_status == 1'b0)
        begin
            current_status <= 1'b1;
            clk_counter <= clk_counter + 1;
            ASW_OUT <= 1'b0;
        end
        else begin
            clk_counter <= clk_counter + 1;
            // Every count stands for 50ns
            // 719 for 36us, and 799 for 40us
            // for synchronization error: [-600, -450, -300, -150, 0, 150, 300, 450, 600]ns
            // the count would add [-12, -9, -6, -3, 0, 3, 6, 9, 12]
            // Final is:
            //          [707, 710, 713, 716, 719, 722, 725, 728, 731]
            //          [787, 790, 793, 796, 799, 802, 805, 808, 811]
            if (clk_counter <= 32'd719)
                ASW_OUT <= 1'b0;
            else if (clk_counter <= 32'd799)
                ASW_OUT <= 1'b1;
            else
                ASW_OUT <= 1'b0;
        end
    end
    else
    begin
        clk_counter <= 32'd0;
        current_status <= 0;
        ASW_OUT <= 1'b0;
    end
end

endmodule
