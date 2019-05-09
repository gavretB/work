module bcd (
// input
cur_addr_b,
Wdata_b,
rd1_b,
rd2_b,
_const_b,
sc_b,
disp_b,
sp_b,
load_d_b,
store_d_b,

// output
cur_addr_d,
Wdata_d,
rd1_d,
rd2_d,
_const_d,
sc_d,
disp_d,
sp_d,
load_d_d,
store_d_d
);

input wire [11:0]   cur_addr_b;   // 現在アドレス
input wire [7:0]    Wdata_b;      // 演算結果
input wire [7:0]    rd1_b;
input wire [7:0]    rd2_b;
input wire [7:0]    _const_b;
input wire [2:0]    sc_b;
input wire [7:0]   disp_b;
input wire [2:0]    sp_b;
input wire [7:0]    load_d_b;
input wire [7:0]    store_d_b;
output wire [15:0]  cur_addr_d;
output wire [16:0]  Wdata_d;
output wire [16:0]  rd1_d;
output wire [16:0]  rd2_d;
output wire [16:0]  _const_d;
output wire [15:0]  sc_d;
output wire [16:0]  disp_d;
output wire [15:0]  sp_d;
output wire [16:0]  load_d_d;
output wire [16:0]  store_d_d;

assign cur_addr_d = bcd_16(cur_addr_b);
assign Wdata_d = signed_bcd_8(Wdata_b);
assign rd1_d = signed_bcd_8(rd1_b);
assign rd2_d = signed_bcd_8(rd2_b);
assign _const_d = signed_bcd_8(_const_b);
assign sc_d = bcd_8(sc_b);
assign disp_d = signed_bcd_8(disp_b);
assign sp_d = bcd_8(sp_b);
assign load_d_d = signed_bcd_8(load_d_b);
assign store_d_d = signed_bcd_8(store_d_b);

/*
assign Wdata_d[15:0] = // 負の数
                       (Wdata_b[7]==1'b1) ? bcd_8( (~Wdata_b+8'b00000001) ):
                       // 0または正の数
                       bcd_8(Wdata_b);
assign Wdata_d[16] = // 負の数
                     (Wdata_b[7]==1'b1) ? 1'b1:
                     // 0または正の数
                     1'b0;
assign rd1_d[15:0] = // 負の数
                     (rd1_b[7]==1'b1) ? bcd_8( (~rd1_b+8'b00000001) ):
                     // 0または正の数
                     bcd_8(rd1_b);
assign rd1_d[16] = // 負の数
                   (rd1_b[7]==1'b1) ? 1'b1:
                   // 0または正の数
                   1'b0;
assign rd2_d[15:0] = // 負の数
                     (rd2_b[7]==1'b1) ? bcd_8( (~rd2_b+8'b00000001) ):
                     // 0または正の数
                     bcd_8(rd2_b);
assign rd2_d[16] = // 負の数
                   (rd2_b[7]==1'b1) ? 1'b1:
                   // 0または正の数
                   1'b0;
assign _const_b[15:0] = // 負の数
                        (_const_b[7]==1'b1) ? bcd_8( (~_const_b+8'b00000001) );
                        // 0または正の数
                        bcd_8(_const_b);
assign _const_b[16] = // 負の数
                      (_const_b[7]==1'b1) ? 1'b1;
                      // 0または正の数
                      1'b0;
*/


// 8ビット以上用
function [15:0] bcd_16;
  input [7:0]  input_b;
  reg [15:0]  b1000;
  reg [15:0]  b100;
  reg [15:0]  b10;
  reg [15:0]  b1;

  begin
    b1000 = input_b / 16'd1000;
    b100 = input_b % 16'd1000 / 16'd100;
    b10 = input_b % 16'd1000 % 16'd100 / 16'd10;
    b1 = input_b % 16'd1000 % 16'd100 % 16'd10 / 16'd1;

    bcd_16[15:12] = b1000[3:0];
    bcd_16[11:8] = b100[3:0];
    bcd_16[7:4] = b10[3:0];
    bcd_16[3:0] = b1[3:0];
  end
endfunction

// 8ビット用
function [15:0] bcd_8;
  input [7:0]  input_b;
  reg [7:0]  b100;
  reg [7:0]  b10;
  reg [7:0]  b1;

  begin
    b100 = input_b / 8'd100;
    b10 = input_b % 8'd100 / 8'd10;
    b1 = input_b % 8'd100 % 8'd10 / 8'd1;

    bcd_8[15:12] = 4'b0000;
    bcd_8[11:8] = b100[3:0];
    bcd_8[7:4] = b10[3:0];
    bcd_8[3:0] = b1[3:0];
  end
endfunction

function [16:0] signed_bcd_16;
  input [15:0] input_b;
  reg [15:0]  signjudge;
  reg [15:0]  b1000;
  reg [15:0]  b100;
  reg [15:0]  b10;
  reg [15:0]  b1;

  begin
    signjudge = // 負の数
                (input_b[15]==1'b1) ? (~input_b+16'b00000001):
                // 0または正の数
                input_b;
    b1000 = signjudge / 16'd1000;
    b100 = signjudge % 16'd1000 / 16'd100;
    b10 = signjudge % 16'd1000 % 16'd100 / 16'd10;
    b1 = signjudge % 16'd1000 % 16'd100 % 16'd10 / 16'd1;
    signed_bcd_16[16] = input_b[15];
    signed_bcd_16[15:12] = b1000[3:0];
    signed_bcd_16[11:8] = b100[3:0];
    signed_bcd_16[7:4] = b10[3:0];
    signed_bcd_16[3:0] = b1[3:0];
  end
endfunction

function [16:0] signed_bcd_12;
  input [11:0] input_b;
  reg [11:0]  signjudge;
  reg [11:0]  b1000;
  reg [11:0]  b100;
  reg [11:0]  b10;
  reg [11:0]  b1;

  begin
    signjudge = // 負の数
                (input_b[11]==1'b1) ? (~input_b+12'b000000000001):
                // 0または正の数
                input_b;
    b1000 = signjudge / 12'd1000;
    b100 = signjudge % 12'd1000 / 12'd100;
    b10 = signjudge % 12'd1000 % 12'd100 / 12'd10;
    b1 = signjudge % 12'd1000 % 12'd100 % 12'd10 / 12'd1;
    signed_bcd_12[16] = input_b[11];
    signed_bcd_12[15:12] = b1000[3:0];
    signed_bcd_12[11:8] = b100[3:0];
    signed_bcd_12[7:4] = b10[3:0];
    signed_bcd_12[3:0] = b1[3:0];
  end
endfunction

function [16:0] signed_bcd_8;
  input [7:0] input_b;
  reg [7:0] signjudge;
  reg [7:0] b100;
  reg [7:0] b10;
  reg [7:0] b1;

  begin
    signjudge = // 負の数
                (input_b[7]==1'b1) ? (~input_b+8'b00000001):
                // 0または正の数
                input_b;
    b100 = signjudge / 8'd100;
    b10 = signjudge % 8'd100 / 8'd10;
    b1 = signjudge % 8'd100 % 8'd10 / 8'd1;
    signed_bcd_8[16] = input_b[7];
    signed_bcd_8[15:12] = 4'b0000;
    signed_bcd_8[11:8] = b100[3:0];
    signed_bcd_8[7:4] = b10[3:0];
    signed_bcd_8[3:0] = b1[3:0];
  end
endfunction

endmodule
