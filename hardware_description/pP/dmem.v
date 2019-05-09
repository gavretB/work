module dmem (
ck,
res,
ck2,
kind,
fn2,
rd1,
disp,
store_d,
load_d
);

input	 wire			 	 ck;
input  wire			   res;
input  wire        ck2;
input	 wire	[3:0]	 kind;
input	 wire [1:0]	 fn2;
input	 wire	[7:0]	 rd1;
input	 wire	[7:0]	 disp;
input	 wire	[7:0]  store_d;
output wire	[7:0]  load_d;

reg	[7:0]	dmem[0:255];

always @(posedge ck or negedge res) begin
	if (res==1'b0) begin
	end
	// クロックとの同期動作
	else if (ck2==1'b0) begin
			// mem_IO命令の場合
			if (kind==4'b0011) begin
				// ストア命令の場合
				if (fn2==2'b01) begin
					dmem[rd1 + disp] = store_d;
				end
			end
	end
end

assign load_d = dmem[rd1 + disp];

endmodule
