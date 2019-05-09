module stack (
ck,
res,
ck2,
kind,
one_addr,
stack_d,
sp
);

input	 wire					ck;
input	 wire					res;
input  wire         ck2;
input	 wire	 [3:0]	kind;
input	 wire	 [11:0]	one_addr;
output wire	 [11:0] stack_d;
output reg	 [2:0]	sp;

reg	[11:0]	stack[0:3];

always @(posedge ck or negedge res) begin
	if (res==1'b0) begin
	// リセットとの同期動作
		sp = 3'b000;
	end
	else if (ck2==1'b0) begin
	// クロックとの同期動作
			// JSB命令かつエントリが4より小さい場合
			if (kind==4'b0110 && sp<3'b100) begin
				stack[sp] = one_addr;
				sp = sp + 3'b001;
			end
			// RET命令かつエントリが0より大きい場合
			else if (kind==4'b0111 && sp>3'b000) begin
				sp = sp - 3'b001;
			end
	end
end

assign stack_d = (sp>=3'b001) ? stack[sp-1]: 12'bxxxxxxxxxxxx;

endmodule
