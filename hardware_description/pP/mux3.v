module mux3 (
A3,
A4,
B0,
B1,
B2,
B3,
B4,
C0,
C1,
C2,
C3,
C4,
D0,
D1,
D2,
seg_cur0,
seg_cur1,
seg_cur2,
seg_cur3,
seg_kind0,
seg_kind1,
seg_kind2,
seg_kind3,
seg_fn3_0,
seg_fn3_1,
seg_fn3_2,
seg_fn2_0,
seg_fn2_1,
seg_wd0,
seg_wd1,
seg_wd2,
seg_wd3,
seg_wd4,
seg_rd1_0,
seg_rd1_1,
seg_rd1_2,
seg_rd1_3,
seg_rd1_4,
seg_rd2_0,
seg_rd2_1,
seg_rd2_2,
seg_rd2_3,
seg_rd2_4,
seg_con0,
seg_con1,
seg_con2,
seg_con3,
seg_con4,
seg_sc0,
seg_sc1,
seg_sc2,
seg_sc3,
seg_disp0,
seg_disp1,
seg_disp2,
seg_disp3,
seg_disp4,
seg_z,
seg_c,
seg_sp0,
seg_sp1,
seg_sp2,
seg_sp3,
seg_load0,
seg_load1,
seg_load2,
seg_load3,
seg_load4,
seg_store0,
seg_store1,
seg_store2,
seg_store3,
seg_store4,
seg_en,
seg_ack,
segR0,
segR1,
segR2,
segR3,
segL0,
segL1,
segL2,
segL3
);

input wire       A3;
input wire       A4;
input wire       B0;
input wire       B1;
input wire       B2;
input wire       B3;
input wire       B4;
input wire       C0;
input wire       C1;
input wire       C2;
input wire       C3;
input wire       C4;
input wire       D0;
input wire       D1;
input wire       D2;
input wire [7:0] seg_cur0;
input wire [7:0] seg_cur1;
input wire [7:0] seg_cur2;
input wire [7:0] seg_cur3;
input wire [7:0] seg_kind0;
input wire [7:0] seg_kind1;
input wire [7:0] seg_kind2;
input wire [7:0] seg_kind3;
input wire [7:0] seg_fn3_0;
input wire [7:0] seg_fn3_1;
input wire [7:0] seg_fn3_2;
input wire [7:0] seg_fn2_0;
input wire [7:0] seg_fn2_1;
input wire [7:0] seg_wd0;
input wire [7:0] seg_wd1;
input wire [7:0] seg_wd2;
input wire [7:0] seg_wd3;
input wire [7:0] seg_wd4;
input wire [7:0] seg_rd1_0;
input wire [7:0] seg_rd1_1;
input wire [7:0] seg_rd1_2;
input wire [7:0] seg_rd1_3;
input wire [7:0] seg_rd1_4;
input wire [7:0] seg_rd2_0;
input wire [7:0] seg_rd2_1;
input wire [7:0] seg_rd2_2;
input wire [7:0] seg_rd2_3;
input wire [7:0] seg_rd2_4;
input wire [7:0] seg_con0;
input wire [7:0] seg_con1;
input wire [7:0] seg_con2;
input wire [7:0] seg_con3;
input wire [7:0] seg_con4;
input wire [7:0] seg_sc0;
input wire [7:0] seg_sc1;
input wire [7:0] seg_sc2;
input wire [7:0] seg_sc3;
input wire [7:0] seg_disp0;
input wire [7:0] seg_disp1;
input wire [7:0] seg_disp2;
input wire [7:0] seg_disp3;
input wire [7:0] seg_disp4;
input wire [7:0] seg_z;
input wire [7:0] seg_c;
input wire [7:0] seg_sp0;
input wire [7:0] seg_sp1;
input wire [7:0] seg_sp2;
input wire [7:0] seg_sp3;
input wire [7:0] seg_load0;
input wire [7:0] seg_load1;
input wire [7:0] seg_load2;
input wire [7:0] seg_load3;
input wire [7:0] seg_load4;
input wire [7:0] seg_store0;
input wire [7:0] seg_store1;
input wire [7:0] seg_store2;
input wire [7:0] seg_store3;
input wire [7:0] seg_store4;
input wire [7:0] seg_en;
input wire [7:0] seg_ack;
output wire [7:0] segR0;
output wire [7:0] segR1;
output wire [7:0] segR2;
output wire [7:0] segR3;
output wire [7:0] segL0;
output wire [7:0] segL1;
output wire [7:0] segL2;
output wire [7:0] segL3;

assign segR0 = // A0
               // A1
               // A2
               // A3
               (~A3) ? seg_kind0:
               // A4
               (~A4) ? seg_fn3_0:
               // B0
               (~B0) ? seg_wd0:
               // B1
               (~B1) ? seg_rd1_0:
               // B2
               (~B2) ? seg_rd2_0:
               // B3
               (~B3) ? seg_con0:
               // B4
               (~B4) ? seg_sc0:
               // C0
               (~C0) ? seg_disp0:
               // C1
               (~C1) ? seg_z:
               // C2
               (~C2) ? seg_c:
               // C3
               (~C3) ? seg_sp0:
               // C4
               (~C4) ? seg_load0:
               // D0
               (~D0) ? seg_store0:
               // D1
               (~D1) ? seg_en:
               // D2
               (~D2) ? seg_ack:
               // D3
               // D4
               // それ以外の時、常にcur_addr
               seg_cur0;
assign segR1 = // A0
               // A1
               // A2
               // A3
               (~A3) ? seg_kind1:
               // A4
               (~A4) ? seg_fn3_1:
               // B0
               (~B0) ? seg_wd1:
               // B1
               (~B1) ? seg_rd1_1:
               // B2
               (~B2) ? seg_rd2_1:
               // B3
               (~B3) ? seg_con1:
               // B4
               (~B4) ? seg_sc1:
               // C0
               (~C0) ? seg_disp1:
               // C1
               (~C1) ? 8'b00000000:
               // C2
               (~C2) ? 8'b00000000:
               // C3
               (~C3) ? seg_sp1:
               // C4
               (~C4) ? seg_load1:
               // D0
               (~D0) ? seg_store0:
               // D1
               (~D1) ? 8'b00000000:
               // D2
               (~D2) ? 8'b00000000:
               // D3
               // D4
               // それ以外の時、常にcur_addr
               seg_cur1;
assign segR2 = // A0
               // A1
               // A2
               // A3
               (~A3) ? seg_kind2:
               // A4
               (~A4) ? seg_fn3_2:
               // B0
               (~B0) ? seg_wd2:
               // B1
               (~B1) ? seg_rd1_2:
               // B2
               (~B2) ? seg_rd2_2:
               // B3
               (~B3) ? seg_con2:
               // B4
               (~B4) ? seg_sc2:
               // C0
               (~C0) ? seg_disp2:
               // C1
               (~C1) ? 8'b00000000:
               // C2
               (~C2) ? 8'b00000000:
               // C3
               (~C3) ? seg_sp2:
               // C4
               (~C4) ? seg_load2:
               // D0
               (~D0) ? seg_store2:
               // D1
               (~D1) ? 8'b00000000:
               // D2
               (~D2) ? 8'b00000000:
               // D3
               // D4
               // それ以外の時、常にcur_addr
               seg_cur2;
assign segR3 = // A0
               // A1
               // A2
               // A3
               (~A3) ? seg_kind3:
               // A4
               (~A4) ? 8'b00000000:
               // B0
               (~B0) ? seg_wd3:
               // B1
               (~B1) ? seg_rd1_3:
               // B2
               (~B2) ? seg_rd2_3:
               // B3
               (~B3) ? seg_con3:
               // B4
               (~B4) ? seg_sc3:
               // C0
               (~C0) ? seg_disp3:
               // C1
               (~C1) ? 8'b00000000:
               // C2
               (~C2) ? 8'b00000000:
               // C3
               (~C3) ? seg_sp3:
               // C4
               (~C4) ? seg_load3:
               // D0
               (~D0) ? seg_store3:
               // D1
               (~D1) ? 8'b00000000:
               // D2
               (~D2) ? 8'b00000000:
               // D3
               // D4
               // それ以外の時、常にcur_addr
               seg_cur3;
assign segL0 = // A0
               // A1
               // A2
               // A3
               (~A3) ? 8'b00000000:
               // A4
               (~A4) ? 8'b00000000:
               // B0
               (~B0) ? seg_wd4:
               // B1
               (~B1) ? seg_rd1_4:
               // B2
               (~B2) ? seg_rd2_4:
               // B3
               (~B3) ? seg_con4:
               // B4
               (~B4) ? 8'b00000000:
               // C0
               (~C0) ? seg_disp4:
               // C1
               (~C1) ? 8'b00000000:
               // C2
               (~C2) ? 8'b00000000:
               // C3
               (~C3) ? 8'b00000000:
               // C4
               (~C4) ? seg_load4:
               // D0
               (~D0) ? seg_store4:
               // D1
               (~D1) ? 8'b00000000:
               // D2
               (~D2) ? 8'b00000000:
               // D3
               // D4
               // それ以外の時、常にcur_addr
               8'b00000000;
assign segL1 = // A0
               // A1
               // A2
               // A3
               // A4
               // B0
               // B1
               // B2
               // B3
               // B4
               // C0
               // C1
               // C2
               // C3
               // C4
               // D0
               // D1
               // D2
               // D3
               // D4
               // それ以外の時、常にcur_addr
               8'b00000000;
assign segL2 = // A0
               // A1
               // A2
               // A3
               // A4
               // B0
               // B1
               // B2
               // B3
               // B4
               // C0
               // C1
               // C2
               // C3
               // C4
               // D0
               // D1
               // D2
               // D3
               // D4
               // それ以外の時、常にcur_addr
               8'b00000000;
assign segL3 = // A0
               // A1
               // A2
               // A3
               // A4
               // B0
               // B1
               // B2
               // B3
               // B4
               // C0
               // C1
               // C2
               // C3
               // C4
               // D0
               // D1
               // D2
               // D3
               // D4
               // それ以外の時、常にcur_addr
               8'b00000000;

endmodule
