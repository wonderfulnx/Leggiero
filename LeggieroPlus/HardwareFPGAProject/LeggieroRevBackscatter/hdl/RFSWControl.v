///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: RFSWControl.v
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

module RFSWControl( CLK, pulse, rst_n, SWEN);
input CLK, pulse, rst_n;
output reg SWEN;

// initial states
initial begin
    SWEN <= 1'b0;
end

always @ (posedge CLK)
begin
    if (~rst_n) begin
        SWEN <= 1'b0;
    end
    else if (pulse)
    begin
        SWEN <= !SWEN;
    end
end

endmodule

