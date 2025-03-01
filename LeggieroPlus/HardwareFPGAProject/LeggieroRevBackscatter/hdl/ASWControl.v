///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: ASWControl.v
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


module ASWControl(CLK, pulse, rst_n, ASW);
input CLK, pulse, rst_n;
output reg ASW;

// initial states
initial begin
    ASW <= 1'b0;
end

always @ (posedge CLK)
begin
    if (~rst_n) begin
        ASW <= 1'b0;
    end
    else if (pulse)
    begin
        ASW <= !ASW;
    end
end

endmodule
