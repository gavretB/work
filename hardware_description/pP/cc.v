module cc (
ck,
res,
ck2,
store_ex,
kind,
fn3,
Waddr,
Wdata,
rd1,
rd2,
_const,
int_c,
int_z,
cc_c,
cc_z
);

input		wire			 	 ck;
input 	wire 			 	 res;
input   wire         ck2;
input 	wire			 	 store_ex;
input		wire  [3:0]  kind;
input		wire  [2:0]  fn3;
input		wire	[2:0]	 Waddr;
input		wire  [7:0]  Wdata;
input		wire  [7:0]  rd1;
input		wire  [7:0]  rd2;
input		wire  [7:0]  _const;
input		wire			 	 int_c;
input 	wire			 	 int_z;
output 	reg				 	 cc_c;
output 	reg 			 	 cc_z;

wire [1:0] fn;
wire 			 ex;
wire 			 wd;
wire 			 rd1_s;
wire			 rd2_s;
wire 			 con;

assign	fn = // 加算の場合
						 (fn3==3'b000 || fn3==3'b001) ? 2'b01:
						 // 減算の場合
						 (fn3==3'b010 || fn3==3'b011) ? 2'b10:
						 // その他
						 2'b00;
assign	ex = // 繰り上がりまたは繰り下がりが発生したとき
						 (store_ex==1'b1) ? 1'b1: 1'b0;
assign	wd = // 演算結果が負のとき
						 (Wdata[7]==1'b1) ? 1'b1: 1'b0;
assign	rd1_s = // データ1が負のとき
							(rd1[7]==1'b1) ? 1'b1: 1'b0;
assign	rd2_s = // データ2が負のとき
							(rd2[7]==1'b1) ? 1'b1: 1'b0;
assign	con = // 即値が負の時
							(_const[7]==1'b1) ? 1'b1: 1'b0;

always @(posedge ck or negedge res) begin
	if (res==1'b0) begin
	// リセットとの同期動作
		cc_z = 1'b0;
		cc_c = 1'b0;
	end
	else if (ck2==1'b0) begin
	// クロックとの同期動作
		// RETI命令の場合
		if (kind==4'b1000) begin
			// ステータスの復帰
			cc_z = int_z;
			cc_c = int_c;
		end
		// reg_reg命令の場合
		else if (kind==4'b0000) begin
			// 加算の場合
			if (fn==2'b01) begin
				if (rd1_s==1'b0 && rd2_s==1'b0) begin // 正+正の場合
					if (ex==1'b0 && wd==1'b1) begin // 8:7 = 0:1 (繰り上がり)の場合
						cc_c=1'b1;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
					else begin // 8:7 = 0:1以外 (繰り上がりなし)の場合
						cc_c=1'b0;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
				end
				else if (rd1_s==1'b1 && rd2_s==1'b1) begin // 負+負の場合
					if (ex==1'b1 && wd==1'b0) begin // 8:7 = 1:0 (繰り下がりあり)の場合
						cc_c=1'b1;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
					else begin	// 8:7 = 1:0以外 (繰り下がりなし)の場合
						cc_c=1'b0;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
				end
				else begin // 正+負 or 負+正の場合
					cc_c=1'b0;
					// 演算結果が0または格納先がr0の場合
					if (Wdata==8'b00000000 || Waddr==3'b000) begin
						cc_z = 1'b1;
					end
					// その他
					else begin
						cc_z = 1'b0;
					end
				end
			end
			else if (fn==2'b10) begin // 減算の場合
				if (rd1_s==1'b0 && rd2_s==1'b1) begin // 正-負の場合
					if (ex==1'b0 && wd==1'b1) begin // 8:7 = 0:1 (繰り上がりあり)の場合
						cc_c=1'b1;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
					else begin // 8:7 = 0:1以外 (繰り上がりなし)の場合
						cc_c=1'b0;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
				end
				else if (rd1_s==1'b1 && rd2_s==1'b0) begin // 負-正の場合
					if (ex==1'b1 && wd==1'b0) begin // 8:7 = 1:0 (繰り下がりあり)の場合
						cc_c=1'b1;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
					else begin // 8:7 = 1:0以外 (繰り下がりなし)の場合
						cc_c=1'b0;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
				end
				else begin // 正-正 or 負-負の場合
					cc_c=1'b0;
					// 演算結果が0または格納先がr0の場合
					if (Wdata==8'b00000000 || Waddr==3'b000) begin
						cc_z = 1'b1;
					end
					// その他
					else begin
						cc_z = 1'b0;
					end
				end
			end
			else begin // 加算・減算以外の場合
				cc_c=1'b0;
				// 演算結果が0または格納先がr0の場合
				if (Wdata==8'b00000000 || Waddr==3'b000) begin
					cc_z = 1'b1;
				end
				// その他
				else begin
					cc_z = 1'b0;
				end
			end
		end
		else if (kind==4'b0001) begin // reg_immedの場合
			if (fn==2'b01) begin // 加算の場合
				if (rd1_s==1'b0 && con==1'b0) begin // 正+正の場合
					if (ex==1'b0 && wd==1'b1) begin // 8:7 = 0:1 (繰り上がりあり)の場合
						cc_c=1'b1;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
					else begin // 8:7 = 0:1以外 (繰り上がりなし)の場合
						cc_c=1'b0;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
				end
				else if (rd1_s==1'b1 && con==1'b1) begin // 負+負の場合
					if (ex==1'b1 && wd==1'b0) begin // 8:7 = 1:0 (繰り下がりあり)の場合
						cc_c=1'b1;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
					else begin // 8:7 = 1:0以外 (繰り下がりなし)の場合
						cc_c=1'b0;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
				end
				else begin // 正+負 or 負+正の場合
					cc_c=1'b0;
					// 演算結果が0または格納先がr0の場合
					if (Wdata==8'b00000000 || Waddr==3'b000) begin
						cc_z = 1'b1;
					end
					// その他
					else begin
						cc_z = 1'b0;
					end
				end
			end
			else if (fn==2'b10) begin // 減算の場合
				if (rd1_s==1'b0 && con==1'b1) begin // 正-負の場合
					if (ex==1'b0 && wd==1'b1) begin // 8:7 = 0:1 (繰り上がりあり)の場合
						cc_c=1'b1;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
					else begin // 8:7 = 0:1 (繰り上がりなし)の場合
						cc_c=1'b0;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
				end
				else if (rd1_s==1'b1 && con==1'b0) begin // 負-正の場合
					if (ex==1'b1 && wd==1'b0) begin // 8:7 = 1:0 (繰り下がりあり)の場合
						cc_c=1'b1;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
					else begin // 8:7 = 1:0以外 (繰り下がりなし)の場合
						cc_c=1'b0;
						// 演算結果が0または格納先がr0の場合
						if (Wdata==8'b00000000 || Waddr==3'b000) begin
							cc_z = 1'b1;
						end
						// その他
						else begin
							cc_z = 1'b0;
						end
					end
				end
				else begin // 正-正 or 負-負の場合
					cc_c=1'b0;
					// 演算結果が0または格納先がr0の場合
					if (Wdata==8'b00000000 || Waddr==3'b000) begin
						cc_z = 1'b1;
					end
					// その他
					else begin
						cc_z = 1'b0;
					end
				end
			end
			else begin // 加算・減算以外の場合
				cc_c=1'b0;
				// 演算結果が0または格納先がr0の場合
				if (Wdata==8'b00000000 || Waddr==3'b000) begin
					cc_z = 1'b1;
				end
				// その他
				else begin
					cc_z = 1'b0;
				end
			end
  	end
		else if (kind==4'b10) begin // shiftの場合
			if (ex==1'b1) begin
				cc_c = 1'b1;
				// 演算結果が0または格納先がr0の場合
				if (Wdata==8'b00000000 || Waddr==3'b000) begin
					cc_z = 1'b1;
				end
				// その他
				else begin
					cc_z = 1'b0;
				end
			end
			else begin
				cc_c = 1'b0;
				// 演算結果が0または格納先がr0の場合
				if (Wdata==8'b00000000 || Waddr==3'b000) begin
					cc_z = 1'b1;
				end
				// その他
				else begin
					cc_z = 1'b0;
				end
			end
		end
		else begin // reg_reg, reg_immed, shift以外の場合
			cc_c = cc_c;
			cc_z = cc_z;
		end
	end
end

endmodule
