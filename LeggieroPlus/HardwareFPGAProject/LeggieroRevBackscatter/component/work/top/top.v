//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sat Aug 31 16:40:19 2024
// Version: v11.9 SP6 11.9.6.7
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// top
module top(
    // Inputs
    BTN0,
    BTN1,
    CLKA,
    DECT_IN,
    RSTBTN,
    // Outputs
    ASWSEL,
    DECT_OUT,
    EDEN,
    LED1,
    LED2,
    RFSWA,
    RFSWB
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  BTN0;
input  BTN1;
input  CLKA;
input  DECT_IN;
input  RSTBTN;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output ASWSEL;
output DECT_OUT;
output EDEN;
output LED1;
output LED2;
output RFSWA;
output RFSWB;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   ASWSEL_net_0;
wire   BTN0;
wire   BTN1;
wire   CLKA;
wire   CLKGEN_0_GLA;
wire   DECT_IN;
wire   EDEN_net_0;
wire   Key_0_key_pressed_pulse_o;
wire   Key_1_key_pressed_pulse_o;
wire   LED1_net_0;
wire   PKT_DECT_0_dect_out;
wire   RFSWA_net_0;
wire   RFSWB_net_0;
wire   RSTBTN;
wire   EDEN_net_1;
wire   RFSWA_net_1;
wire   RFSWB_net_1;
wire   ASWSEL_net_1;
wire   LED1_net_1;
wire   EDEN_net_2;
wire   PKT_DECT_0_dect_out_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   VCC_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net = 1'b1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign EDEN_net_1                = EDEN_net_0;
assign EDEN                      = EDEN_net_1;
assign RFSWA_net_1               = RFSWA_net_0;
assign RFSWA                     = RFSWA_net_1;
assign RFSWB_net_1               = RFSWB_net_0;
assign RFSWB                     = RFSWB_net_1;
assign ASWSEL_net_1              = ASWSEL_net_0;
assign ASWSEL                    = ASWSEL_net_1;
assign LED1_net_1                = LED1_net_0;
assign LED1                      = LED1_net_1;
assign EDEN_net_2                = EDEN_net_0;
assign LED2                      = EDEN_net_2;
assign PKT_DECT_0_dect_out_net_0 = PKT_DECT_0_dect_out;
assign DECT_OUT                  = PKT_DECT_0_dect_out_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_0(
        // Inputs
        .A ( CLKGEN_0_GLA ),
        .B ( LED1_net_0 ),
        // Outputs
        .Y ( RFSWA_net_0 ) 
        );

//--------ASWControl
ASWControl ASWControl_0(
        // Inputs
        .CLK   ( CLKGEN_0_GLA ),
        .pulse ( Key_1_key_pressed_pulse_o ),
        .rst_n ( RSTBTN ),
        // Outputs
        .ASW   ( EDEN_net_0 ) 
        );

//--------CLKGEN
CLKGEN CLKGEN_0(
        // Inputs
        .POWERDOWN ( VCC_net ),
        .CLKA      ( CLKA ),
        // Outputs
        .LOCK      (  ),
        .GLA       ( CLKGEN_0_GLA ) 
        );

//--------INV
INV INV_0(
        // Inputs
        .A ( RFSWA_net_0 ),
        // Outputs
        .Y ( RFSWB_net_0 ) 
        );

//--------Key
Key Key_0(
        // Inputs
        .clk                 ( CLKGEN_0_GLA ),
        .rst_n               ( RSTBTN ),
        .key_i               ( BTN0 ),
        // Outputs
        .key_pressed_pulse_o ( Key_0_key_pressed_pulse_o ) 
        );

//--------Key
Key Key_1(
        // Inputs
        .clk                 ( CLKGEN_0_GLA ),
        .rst_n               ( RSTBTN ),
        .key_i               ( BTN1 ),
        // Outputs
        .key_pressed_pulse_o ( Key_1_key_pressed_pulse_o ) 
        );

//--------modulator
modulator modulator_0(
        // Inputs
        .EN      ( EDEN_net_0 ),
        .CLK     ( CLKGEN_0_GLA ),
        .DEC_IN  ( PKT_DECT_0_dect_out ),
        .rst_n   ( RSTBTN ),
        // Outputs
        .ASW_OUT ( ASWSEL_net_0 ) 
        );

//--------PKT_DECT
PKT_DECT PKT_DECT_0(
        // Inputs
        .clk      ( CLKGEN_0_GLA ),
        .rst_n    ( RSTBTN ),
        .dect_in  ( DECT_IN ),
        // Outputs
        .dect_out ( PKT_DECT_0_dect_out ) 
        );

//--------RFSWControl
RFSWControl RFSWControl_0(
        // Inputs
        .CLK   ( CLKGEN_0_GLA ),
        .pulse ( Key_0_key_pressed_pulse_o ),
        .rst_n ( RSTBTN ),
        // Outputs
        .SWEN  ( LED1_net_0 ) 
        );


endmodule
