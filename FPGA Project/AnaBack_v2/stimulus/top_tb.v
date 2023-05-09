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
// Targeted device: <Family::IGLOO> <Die::AGL250V2> <Package::100 VQFP>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>
`timescale 1ns/10ps

module top_tb;

parameter SYSCLK_PERIOD = 50;// 20MHZ

reg SYSCLK;
reg SW_901, SW_919;
reg DEC;

initial
begin
    SYSCLK = 1'b0;
    SW_901 = 1'b0;
    SW_919 = 1'b0;
    DEC = 1'b0;
end

//////////////////////////////////////////////////////////////////////
// Env Input
//////////////////////////////////////////////////////////////////////
initial
begin
    #(SYSCLK_PERIOD * 10 )
        SW_901 <= 1'b1;
    #(SYSCLK_PERIOD * 10 )
        SW_919 <= 1'b1;
    #(SYSCLK_PERIOD * 30)
        DEC <= 1'b1;
    #(SYSCLK_PERIOD * 600)
        DEC <= 1'b0;
    #(SYSCLK_PERIOD * 30)
        DEC <= 1'b1;
    #(SYSCLK_PERIOD * 600)
        DEC <= 1'b0;
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
    .SW1(SW_901),
    .SW2(SW_919),
    .DEC_IN(DEC),

    // Outputs
    .D901( ),
    .D919( ),
    .LED1( ),
    .ED_EN( ),
    .LED2( )

    // Inouts

);

endmodule

