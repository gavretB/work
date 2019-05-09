module register (
ck,
res,
ck2,
fn2,
kind,
Waddr,
Raddr1,
Raddr2,
Wdata,
load_d,
rd1,
rd2,
store_d
);

input		wire 				 	ck;
input		wire			  	res;
input   wire          ck2;
input 	wire 	[1:0] 	fn2;
input		wire 	[3:0]		kind;
input		wire 	[2:0]		Waddr;
input		wire 	[2:0]		Raddr1;
input		wire 	[2:0]		Raddr2;
input		wire 	[7:0]		Wdata;
input 	wire 	[7:0] 	load_d;
output 	wire	[7:0]		rd1;
output 	wire	[7:0]		rd2;
output 	wire	[7:0] 	store_d;
reg [7:0]	gpr[0:7];

always @(posedge ck or negedge res) begin
	if (res==1'b0) begin
	// リセットとの同期動作
		gpr[0] = 8'b00000000;
		gpr[1] = 8'b00000000;
		gpr[2] = 8'b00000000;
		gpr[3] = 8'b00000000;
		gpr[4] = 8'b00000000;
		gpr[5] = 8'b00000000;
		gpr[6] = 8'b00000000;
		gpr[7] = 8'b00000000;
	end
	else if (ck2==1'b0) begin
	// クロックとの同期動作
		// reg_reg, reg_immed, shift命令の場合
			if (kind==4'b0000 || kind==4'b0001 || kind==4'b0010) begin
				if (Waddr==3'b000) begin  // 書き込み先がレジスタ0の場合
					gpr[Waddr] = 8'b00000000;
				end
				else begin // 書き込み先がレジスタ0以外の場合
					gpr[Waddr] = Wdata;
				end
			end
			// mem_IO命令の場合
			else if (kind==4'b0011) begin
			  // ロード命令の場合
				if (fn2==2'b00) begin
				// ロード先がレジスタ0の場合
					if (Waddr==3'b000) begin
						gpr[Waddr] = 8'b00000000;
					end
					// ロード先がレジスタ0以外の場合
					else begin
						gpr[Waddr] = load_d;
					end
				end
			end
	end
end

assign	rd1 = gpr[Raddr1];
assign	rd2 = gpr[Raddr2];
assign  store_d = gpr[Waddr];

endmodule
