module int_reg (
ck,
res,
int_req,
ck2,
one_addr,
cc_z,
cc_c,
kind,
int_pc,
int_z,
int_c,
int_en,
int_ack
);

input	 wire          ck;          // クロック信号
input  wire          res;         // リセット信号
input  wire          int_req;     // 割り込み要求信号
input  wire          ck2;
input  wire          cc_z;        // ゼロフラグ
input  wire          cc_c;        // キャリーフラグ
input  wire  [11:0]  one_addr;    // 復帰先アドレス信号
input	 wire  [3:0]   kind;        // 命令種信号
output reg   [11:0]  int_pc;      // 割り込みpc信号
output reg	         int_z;       // 割り込みcc_z信号
output reg           int_c;       // 割り込みcc_c信号
output reg           int_en;      // 割り込み待機信号
output reg           int_ack;     // 割り込み実行信号

always @(posedge ck or negedge res) begin
  if (res==1'b0) begin
  // リセットとの同期動作(DISIと同様)
    int_en = 1'b0;
    int_ack = 1'b0;
  end else if (ck2==1'b0) begin
  // クロックとの同期動作
    if (kind==4'b1001) begin
    // ENAI命令の場合
      int_en = 1'b1;
    end
    else if (kind==4'b1010) begin
    // DISI命令の場合
      int_en = 1'b0;
    end
    // 割り込み発生の場合(ENAI状態かつ割り込み要求)
    if (int_en==1'b1 && int_req==1'b0 && ck2==1'b0) begin
    // pc及びccの退避
      int_pc = one_addr;
      int_z = cc_z;
      int_c = cc_c;
      int_ack = 1;
    end
    else if (kind==4'b1000) begin
    // 割り込みなしの場合
      int_ack = 0;
    end
  end
end

endmodule
