///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: modulator.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::IGLOO> <Die::AGL250V2> <Package::100 VQFP>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module modulator(EN, CLK, DEC_IN, D919);
input EN, CLK, DEC_IN;
output reg D919;

// indicate whether have seen a packet:
//    0 -> have not seen a packet before
//    1 -> have seen the packet
reg current_status;
reg [31:0] clk_counter;

initial begin
    clk_counter <= 32'd0;
    current_status <= 0;
    D919 <= 1'b1;
end

always @(posedge CLK)
begin
    if (~EN)
    begin
        clk_counter <= 32'd0;
        current_status <= 0;
        D919 <= 1'b1;
    end
    else if (DEC_IN)
    begin
        if (current_status == 0)
        begin
            current_status <= 1;
            clk_counter <= clk_counter + 1;
            D919 <= 1'b1;
        end
        else
        begin
            clk_counter <= clk_counter + 1;
            // Every count stands for 50ns
            // 719 for 36us, and 799 for 40us
            // for synchronization error: [-600, -450, -300, -150, 0, 150, 300, 450, 600]ns
            // the count would add [-12, -9, -6, -3, 0, 3, 6, 9, 12]
            // Final is:
            //          [707, 710, 713, 716, 719, 722, 725, 728, 731]
            //          [787, 790, 793, 796, 799, 802, 805, 808, 811]
            if (clk_counter <= 32'd719)
                D919 <= 1'b1;
            else if (clk_counter <= 32'd799)
                D919 <= 1'b0;
            else
                D919 <= 1'b1;
        end
    end
    else
    begin
        clk_counter <= 32'd0;
        current_status <= 0;
        D919 <= 1'b1;
    end
end

endmodule

