///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: top_tb.v
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

`timescale 1ns/10ps

module top_tb;

parameter SYSCLK_PERIOD = 50;// 20MHZ

reg SYSCLK;
reg NSYSRESET;
reg BTN_0;
reg BTN_1;

initial
begin
    SYSCLK = 1'b0;
    NSYSRESET = 1'b0;
    BTN_0 = 1'b1;
    BTN_1 = 1'b1;
end

//////////////////////////////////////////////////////////////////////
// Reset Pulse
//////////////////////////////////////////////////////////////////////
initial
begin
    #(SYSCLK_PERIOD * 10 )
        BTN_0 = 1'b0;
    #(SYSCLK_PERIOD * 1000 )
        BTN_0 = 1'b1;
    #(SYSCLK_PERIOD * 1050 )
        BTN_1 = 1'b0;
    #(SYSCLK_PERIOD * 2060 )
        BTN_1 = 1'b1;
end


//////////////////////////////////////////////////////////////////////
// Clock Driver
//////////////////////////////////////////////////////////////////////
always @(SYSCLK)
    #(SYSCLK_PERIOD / 2.0) SYSCLK <= !SYSCLK;


//////////////////////////////////////////////////////////////////////
// Instantiate Unit Under Test:  top
//////////////////////////////////////////////////////////////////////
top top_0 (
    // Inputs
    .CLKA(SYSCLK),
    .BTN0(BTN_0),
    .BTN1(BTN_1),
    .RSTBTN(NSYSRESET),

    // Outputs
    .EDEN( ),
    .RFSWA( ),
    .RFSWB( ),
    .ASWSEL( )

    // Inouts

);

endmodule

