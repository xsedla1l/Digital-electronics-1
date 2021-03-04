// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Wed Mar  3 17:09:31 2021
// Host        : LAPTOP-DP62DEB3 running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/Users/marek/Desktop/skola/4semester/DE1/Digital-electronics-1/Labs/hex_7seg/hex_7seg.sim/sim_1/synth/func/xsim/tb_hex_7seg_func_synth.v
// Design      : hex_7seg
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a50ticsg324-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* NotValidForBitStream *)
module hex_7seg
   (hex_i,
    seg_o);
  input [3:0]hex_i;
  output [6:0]seg_o;

  wire [3:0]hex_i;
  wire [3:0]hex_i_IBUF;
  wire [6:0]seg_o;
  wire [6:0]seg_o_OBUF;

  IBUF \hex_i_IBUF[0]_inst 
       (.I(hex_i[0]),
        .O(hex_i_IBUF[0]));
  IBUF \hex_i_IBUF[1]_inst 
       (.I(hex_i[1]),
        .O(hex_i_IBUF[1]));
  IBUF \hex_i_IBUF[2]_inst 
       (.I(hex_i[2]),
        .O(hex_i_IBUF[2]));
  IBUF \hex_i_IBUF[3]_inst 
       (.I(hex_i[3]),
        .O(hex_i_IBUF[3]));
  OBUF \seg_o_OBUF[0]_inst 
       (.I(seg_o_OBUF[0]),
        .O(seg_o[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h34D3)) 
    \seg_o_OBUF[0]_inst_i_1 
       (.I0(hex_i_IBUF[0]),
        .I1(hex_i_IBUF[2]),
        .I2(hex_i_IBUF[3]),
        .I3(hex_i_IBUF[1]),
        .O(seg_o_OBUF[0]));
  OBUF \seg_o_OBUF[1]_inst 
       (.I(seg_o_OBUF[1]),
        .O(seg_o[1]));
  LUT4 #(
    .INIT(16'h37D2)) 
    \seg_o_OBUF[1]_inst_i_1 
       (.I0(hex_i_IBUF[0]),
        .I1(hex_i_IBUF[2]),
        .I2(hex_i_IBUF[3]),
        .I3(hex_i_IBUF[1]),
        .O(seg_o_OBUF[1]));
  OBUF \seg_o_OBUF[2]_inst 
       (.I(seg_o_OBUF[2]),
        .O(seg_o[2]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h36DE)) 
    \seg_o_OBUF[2]_inst_i_1 
       (.I0(hex_i_IBUF[0]),
        .I1(hex_i_IBUF[2]),
        .I2(hex_i_IBUF[3]),
        .I3(hex_i_IBUF[1]),
        .O(seg_o_OBUF[2]));
  OBUF \seg_o_OBUF[3]_inst 
       (.I(seg_o_OBUF[3]),
        .O(seg_o[3]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hBCF6)) 
    \seg_o_OBUF[3]_inst_i_1 
       (.I0(hex_i_IBUF[0]),
        .I1(hex_i_IBUF[2]),
        .I2(hex_i_IBUF[3]),
        .I3(hex_i_IBUF[1]),
        .O(seg_o_OBUF[3]));
  OBUF \seg_o_OBUF[4]_inst 
       (.I(seg_o_OBUF[4]),
        .O(seg_o[4]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hCD20)) 
    \seg_o_OBUF[4]_inst_i_1 
       (.I0(hex_i_IBUF[0]),
        .I1(hex_i_IBUF[2]),
        .I2(hex_i_IBUF[3]),
        .I3(hex_i_IBUF[1]),
        .O(seg_o_OBUF[4]));
  OBUF \seg_o_OBUF[5]_inst 
       (.I(seg_o_OBUF[5]),
        .O(seg_o[5]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hC82C)) 
    \seg_o_OBUF[5]_inst_i_1 
       (.I0(hex_i_IBUF[0]),
        .I1(hex_i_IBUF[2]),
        .I2(hex_i_IBUF[3]),
        .I3(hex_i_IBUF[1]),
        .O(seg_o_OBUF[5]));
  OBUF \seg_o_OBUF[6]_inst 
       (.I(seg_o_OBUF[6]),
        .O(seg_o[6]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h30D6)) 
    \seg_o_OBUF[6]_inst_i_1 
       (.I0(hex_i_IBUF[0]),
        .I1(hex_i_IBUF[2]),
        .I2(hex_i_IBUF[3]),
        .I3(hex_i_IBUF[1]),
        .O(seg_o_OBUF[6]));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
