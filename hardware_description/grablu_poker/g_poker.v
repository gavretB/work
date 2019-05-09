module g_poker(
	clock,
	reset,
	xreset,
	bet,
	betup,
	betdw,
	start,
	hold0,
	hold1,
	hold2,
	hold3,
	hold4,
	draw,
	double,
	high,
	low,
	suit,
	hand,
	segR,
	segR_sel,
	segL,
	segL_sel
);

input wire clock;
input wire xreset;
input wire reset;
input wire bet;
input wire betup;
input wire betdw;
input wire start;
input wire hold0;
input wire hold1;
input wire hold2;
input wire hold3;
input wire hold4;
input wire draw;
input wire double;
input wire high;
input wire low;
input wire suit;
input wire hand;

output wire [7:0] segR;
output wire [3:0] segR_sel;
output wire [7:0] segL;
output wire [3:0] segL_sel;

wire reset_co;
wire bet_co;
wire betup_co;
wire betdw_co;
wire start_co;
wire hold_co0;
wire hold_co1;
wire hold_co2;
wire hold_co3;
wire hold_co4;
wire draw_co;
wire double_co;
wire high_co;
wire low_co;

wire reset_c;
wire bet_c;
wire betup_c;
wire betdw_c;
wire start_c;
wire hold_c0;
wire hold_c1;
wire hold_c2;
wire hold_c3;
wire hold_c4;
wire draw_c;
wire double_c;
wire high_c;
wire low_c;
wire suit_c;
wire hand_c;

wire bet_s;
wire [1:0] updown;

wire [15:0] wager_o;
wire [15:0] mih_o;
wire [15:0] money_r;

wire [15:0] wager_b;
wire [15:0] mih_b;

wire [1:0] game_s;
wire [1:0] d_count;

wire [3:0] Pnum0;
wire [3:0] Pnum1;
wire [3:0] Pnum2;
wire [3:0] Pnum3;
wire [3:0] Pnum4;
wire [3:0] Pnum5;
wire [3:0] Pnum6;
wire [3:0] Pnum7;
wire [3:0] Pnum8;
wire [3:0] Pnum9;
wire [2:0] suit0;
wire [2:0] suit1;
wire [2:0] suit2;
wire [2:0] suit3;
wire [2:0] suit4;
wire [2:0] suit5;
wire [2:0] suit6;
wire [2:0] suit7;
wire [2:0] suit8;
wire [2:0] suit9;

wire hold_o0;
wire hold_o1;
wire hold_o2;
wire hold_o3;
wire hold_o4;
wire draw_s;
wire pjudge;


wire [3:0] nnum0;
wire [3:0] nnum1;
wire [3:0] nnum2;
wire [3:0] nnum3;
wire [3:0] nnum4;
wire [2:0] nsuit0;
wire [2:0] nsuit1;
wire [2:0] nsuit2;
wire [2:0] nsuit3;
wire [2:0] nsuit4;

wire [3:0] hand_r;
wire dchance1;

wire [3:0] Dnum0;
wire [3:0] Dnum1;

wire [1:0] highlow;

wire [1:0] highlow_r;
wire [1:0] highlow_ro;
wire dchance2;

wire [7:0] seg_w0;
wire [7:0] seg_w1;
wire [7:0] seg_w2;
wire [7:0] seg_w3;
wire [7:0] seg_m0;
wire [7:0] seg_m1;
wire [7:0] seg_m2;
wire [7:0] seg_m3;
wire [7:0] seg_h;
wire [7:0] seg_pn0;
wire [7:0] seg_pn1;
wire [7:0] seg_pn2;
wire [7:0] seg_pn3;
wire [7:0] seg_pn4;
wire [7:0] seg_nn0;
wire [7:0] seg_nn1;
wire [7:0] seg_nn2;
wire [7:0] seg_nn3;
wire [7:0] seg_nn4;
wire [7:0] seg_s0;
wire [7:0] seg_s1;
wire [7:0] seg_s2;
wire [7:0] seg_s3;
wire [7:0] seg_s4;
wire [7:0] seg_ns0;
wire [7:0] seg_ns1;
wire [7:0] seg_ns2;
wire [7:0] seg_ns3;
wire [7:0] seg_ns4;
wire [7:0] seg_dn0;
wire [7:0] seg_dn1;
wire [7:0] seg_dr0;
wire [7:0] seg_dr1;
wire [7:0] seg_dr2;
wire [7:0] seg_dr3;
wire [3:0] select;

wire [7:0] segR0;
wire [7:0] segR1;
wire [7:0] segR2;
wire [7:0] segR3;
wire [7:0] segL0;
wire [7:0] segL1;
wire [7:0] segL2;
wire [7:0] segL3;

chattering chat_reset(
	.clk(clock),
	.rest(xreset),
	.in(reset),
	.out(reset_co)
);

chattering chat_bet(
	.clk(clock),
	.rest(xreset),
	.in(bet),
	.out(bet_co)
);

chattering chat_betup(
	.clk(clock),
	.rest(xreset),
	.in(betup),
	.out(betup_co)
);

chattering chat_betdw(
	.clk(clock),
	.rest(xreset),
	.in(betdw),
	.out(betdw_co)
);

chattering chat_start(
	.clk(clock),
	.rest(xreset),
	.in(start),
	.out(start_co)
); 

chattering chat_hold0(
	.clk(clock),
	.rest(xreset),
	.in(hold0),
	.out(hold_co0)
);

chattering chat_hold1(
	.clk(clock),
	.rest(xreset),
	.in(hold1),
	.out(hold_co1)
);

chattering chat_hold2(
	.clk(clock),
	.rest(xreset),
	.in(hold2),
	.out(hold_co2)
);

chattering chat_hold3(
	.clk(clock),
	.rest(xreset),
	.in(hold3),
	.out(hold_co3)
);

chattering chat_hold4(
	.clk(clock),
	.rest(xreset),
	.in(hold4),
	.out(hold_co4)
);

chattering chat_draw(
	.clk(clock),
	.rest(xreset),
	.in(draw),
	.out(draw_co)
);

chattering chat_double(
	.clk(clock),
	.rest(xreset),
	.in(double),
	.out(double_co)
);

chattering chat_high(
	.clk(clock),
	.rest(xreset),
	.in(high),
	.out(high_co)
);

chattering chat_low(
	.clk(clock),
	.rest(xreset),
	.in(low),
	.out(low_co)
);

oneshot onereset(
	.clk(clock),
	.rest(xreset),
	.in(reset_co),
	.out(reset_c)
);

oneshot onebet(
	.clk(clock),
	.rest(xreset),
	.in(bet_co),
	.out(bet_c)
);

oneshot onbetup(
	.clk(clock),
	.rest(xreset),
	.in(betup_co),
	.out(betup_c)
);

oneshot onebetdw(
	.clk(clock),
	.rest(xreset),
	.in(betdw_co),
	.out(betdw_c)
);

oneshot onestart(
	.clk(clock),
	.rest(xreset),
	.in(start_co),
	.out(start_c)
); 

oneshot onehold0(
	.clk(clock),
	.rest(xreset),
	.in(hold_co0),
	.out(hold_c0)
);

oneshot onehold1(
	.clk(clock),
	.rest(xreset),
	.in(hold_co1),
	.out(hold_c1)
);

oneshot onehold2(
	.clk(clock),
	.rest(xreset),
	.in(hold_co2),
	.out(hold_c2)
);

oneshot onehold3(
	.clk(clock),
	.rest(xreset),
	.in(hold_co3),
	.out(hold_c3)
);

oneshot onehold4(
	.clk(clock),
	.rest(xreset),
	.in(hold_co4),
	.out(hold_c4)
);

oneshot onedraw(
	.clk(clock),
	.rest(xreset),
	.in(draw_co),
	.out(draw_c)
);

oneshot onedouble(
	.clk(clock),
	.rest(xreset),
	.in(double_co),
	.out(double_c)
);

oneshot onehigh(
	.clk(clock),
	.rest(xreset),
	.in(high_co),
	.out(high_c)
);

oneshot onelow(
	.clk(clock),
	.rest(xreset),
	.in(low_co),
	.out(low_c)
);

//
chattering chat_suit(
	.clk(clock),
	.rest(xreset),
	.in(suit),
	.out(suit_c)
);

chattering chat_hand(
	.clk(clock),
	.rest(xreset),
	.in(hand),
	.out(hand_c)
);


fsm_game U_fsm_game(
	.clock(clock),
	.reset_c(reset_c),
	.bet_c(bet_c),
	.betup_c(betup_c),
	.betdw_c(betdw_c),
	.start_c(start_c),
	.hold_c0(hold_c0),
	.hold_c1(hold_c1),
	.hold_c2(hold_c2),
	.hold_c3(hold_c3),
	.hold_c4(hold_c4),
	.draw_c(draw_c),
	.double_c(double_c),
	.high_c(high_c),
	.low_c(low_c),
	//.money_c(money_c),
	.suit_c(suit_c),
	.hand_c(hand_c),
	.dchance1(dchance1),
	.dchance2(dchance2),
	.bet_s(bet_s),
	.updown(updown),
	.hold_o0(hold_o0),
	.hold_o1(hold_o1),
	.hold_o2(hold_o2),
	.hold_o3(hold_o3),
	.hold_o4(hold_o4),
	.draw_s(draw_s),
	.game_s(game_s),
	.highlow(highlow),
	.select(select)
);

money U_money(
	.clock(clock),
	.reset_c(reset_c),
	.bet_s(bet_s),
	.updown(updown),
	.money_r(money_r),
	.wager_o(wager_o),
	.mih_o(mih_o)
);

bcd U_bcd(
	.wager_o(wager_o),
	.mih_o(mih_o),
	.wager_b(wager_b),
	.mih_b(mih_b)
);

random U_random(
	.clock(clock),
	.reset_c(reset_c),
	.game_s(game_s),
	//.double_c(double_c),
	.d_count(d_count),
	.dchance1(dchance1),
	.dchance2(dchance2),
	.Pnum0(Pnum0),
	.Pnum1(Pnum1),
	.Pnum2(Pnum2),
	.Pnum3(Pnum3),
	.Pnum4(Pnum4),
	.Pnum5(Pnum5),
	.Pnum6(Pnum6),
	.Pnum7(Pnum7),
	.Pnum8(Pnum8),
	.Pnum9(Pnum9),
	.suit0(suit0),
	.suit1(suit1),
	.suit2(suit2),
	.suit3(suit3),
	.suit4(suit4),
	.suit5(suit5),
	.suit6(suit6),
	.suit7(suit7),
	.suit8(suit8),
	.suit9(suit9),
	.Dnum0(Dnum0),
	.Dnum1(Dnum1)
);

draw U_draw(
	.clock(clock),
	.reset_c(reset_c),
	.hold_o0(hold_o0),
	.hold_o1(hold_o1),
	.hold_o2(hold_o2),
	.hold_o3(hold_o3),
	.hold_o4(hold_o4),
	.draw_s(draw_s),
	.Pnum0(Pnum0),
	.Pnum1(Pnum1),
	.Pnum2(Pnum2),
	.Pnum3(Pnum3),
	.Pnum4(Pnum4),
	.Pnum5(Pnum5),
	.Pnum6(Pnum6),
	.Pnum7(Pnum7),
	.Pnum8(Pnum8),
	.Pnum9(Pnum9),
	.suit0(suit0),
	.suit1(suit1),
	.suit2(suit2),
	.suit3(suit3),
	.suit4(suit4),
	.suit5(suit5),
	.suit6(suit6),
	.suit7(suit7),
	.suit8(suit8),
	.suit9(suit9),
	.nnum0(nnum0),
	.nnum1(nnum1),
	.nnum2(nnum2),
	.nnum3(nnum3),
	.nnum4(nnum4),
	.nsuit0(nsuit0),
	.nsuit1(nsuit1),
	.nsuit2(nsuit2),
	.nsuit3(nsuit3),
	.nsuit4(nsuit4),
	.pjudge(pjudge)	
);

Pjudge U_Pjudge(
	.clock(clock),
	.reset_c(reset_c),
	.nnum0(nnum0),
	.nnum1(nnum1),
	.nnum2(nnum2),
	.nnum3(nnum3),
	.nnum4(nnum4),
	.nsuit0(nsuit0),
	.nsuit1(nsuit1),
	.nsuit2(nsuit2),
	.nsuit3(nsuit3),
	.nsuit4(nsuit4),
	.pjudge(pjudge),
	.hand_r(hand_r),
	.dchance1(dchance1)
);

Djudge U_Djudge(
	.clock(clock),
	.reset_c(reset_c),
	.bet_c(bet_c),
	.Dnum0(Dnum0),
	.Dnum1(Dnum1),
	.highlow(highlow),
	.highlow_r(highlow_r),
	.highlow_ro(highlow_ro),
	.dchance2(dchance2),
	.d_count(d_count)
);

management U_management(
	.clock(clock),
	.reset_c(reset_c),	
	.wager_o(wager_o),
	.mih_o(mih_o),
	.hand_r(hand_r),
	.game_s(game_s),
	.highlow_r(highlow_r),
	.money_r(money_r)
);

segment U_segment(
	.hold_o0(hold_o0),
	.hold_o1(hold_o1),
	.hold_o2(hold_o2),
	.hold_o3(hold_o3),
	.hold_o4(hold_o4),
	.Pnum0(Pnum0),
	.Pnum1(Pnum1),
	.Pnum2(Pnum2),
	.Pnum3(Pnum3),
	.Pnum4(Pnum4),
	.suit0(suit0),
	.suit1(suit1),
	.suit2(suit2),
	.suit3(suit3),
	.suit4(suit4),	
	.nnum0(nnum0),
	.nnum1(nnum1),
	.nnum2(nnum2),
	.nnum3(nnum3),
	.nnum4(nnum4),
	.nsuit0(nsuit0),
	.nsuit1(nsuit1),
	.nsuit2(nsuit2),
	.nsuit3(nsuit3),
	.nsuit4(nsuit4),
	.hand_r(hand_r),
	.Dnum0(Dnum0),
	.Dnum1(Dnum1),
	.highlow(highlow),
	.highlow_ro(highlow_ro),
	.wager_b(wager_b),
	.mih_b(mih_b),
	.seg_w0(seg_w0),
	.seg_w1(seg_w1),
	.seg_w2(seg_w2),
	.seg_w3(seg_w3),
	.seg_m0(seg_m0),
	.seg_m1(seg_m1),
	.seg_m2(seg_m2),
	.seg_m3(seg_m3),
	.seg_h(seg_h),
	.seg_pn0(seg_pn0),
	.seg_pn1(seg_pn1),
	.seg_pn2(seg_pn2),
	.seg_pn3(seg_pn3),
	.seg_pn4(seg_pn4),
	.seg_nn0(seg_nn0),
	.seg_nn1(seg_nn1),
	.seg_nn2(seg_nn2),
	.seg_nn3(seg_nn3),
	.seg_nn4(seg_nn4),
	.seg_s0(seg_s0),
	.seg_s1(seg_s1),
	.seg_s2(seg_s2),
	.seg_s3(seg_s3),
	.seg_s4(seg_s4),
	.seg_ns0(seg_ns0),
	.seg_ns1(seg_ns1),
	.seg_ns2(seg_ns2),
	.seg_ns3(seg_ns3),
	.seg_ns4(seg_ns4),
	.seg_dn0(seg_dn0),
	.seg_dn1(seg_dn1),
	.seg_dr0(seg_dr0),
	.seg_dr1(seg_dr1),
	.seg_dr2(seg_dr2),
	.seg_dr3(seg_dr3)
);

mux1 U_mux1(
	.seg_w0(seg_w0),
	.seg_w1(seg_w1),
	.seg_w2(seg_w2),
	.seg_w3(seg_w3),
	.seg_m0(seg_m0),
	.seg_m1(seg_m1),
	.seg_m2(seg_m2),
	.seg_m3(seg_m3),
	.seg_h(seg_h),
	.seg_pn0(seg_pn0),
	.seg_pn1(seg_pn1),
	.seg_pn2(seg_pn2),
	.seg_pn3(seg_pn3),
	.seg_pn4(seg_pn4),
	.seg_nn0(seg_nn0),
	.seg_nn1(seg_nn1),
	.seg_nn2(seg_nn2),
	.seg_nn3(seg_nn3),
	.seg_nn4(seg_nn4),	
	.seg_s0(seg_s0),
	.seg_s1(seg_s1),
	.seg_s2(seg_s2),
	.seg_s3(seg_s3),
	.seg_s4(seg_s4),
	.seg_ns0(seg_ns0),
	.seg_ns1(seg_ns1),
	.seg_ns2(seg_ns2),
	.seg_ns3(seg_ns3),
	.seg_ns4(seg_ns4),
	.seg_dn0(seg_dn0),
	.seg_dn1(seg_dn1),
	.seg_dr0(seg_dr0),
	.seg_dr1(seg_dr1),
	.seg_dr2(seg_dr2),
	.seg_dr3(seg_dr3),
	.select(select),
	.segR0(segR0),
	.segR1(segR1),
	.segR2(segR2),
	.segR3(segR3),
	.segL0(segL0),
	.segL1(segL1),
	.segL2(segL2),
	.segL3(segL3)
);

dynamic_display dR (
.CLK    (clock),
.RSTN   (reset_c),
.SEG_A_0 (segR3),
.SEG_B_0 (segR2),
.SEG_C_0 (segR1),
.SEG_D_0 (segR0),
.SEG_A (segR),
.SEG_SEL (segR_sel)
);

dynamic_display dL (
.CLK    (clock),
.RSTN   (reset_c),
.SEG_A_0 (segL3),
.SEG_B_0 (segL2),
.SEG_C_0 (segL1),
.SEG_D_0 (segL0),
.SEG_A (segL),
.SEG_SEL (segL_sel)
);

endmodule