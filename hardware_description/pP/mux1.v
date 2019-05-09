module mux1 (
int_req,
disp_addr,
one_addr,
fn2,
kind,
cc_z,
cc_c,
addr,
stack_d,
int_pc,
int_en,
int_ack,
next_addr
);

input  wire 					int_req;
input	 wire	 [11:0]		disp_addr;
input	 wire	 [11:0]		one_addr;
input	 wire	 [1:0]		fn2;
input	 wire	 [3:0]		kind;
input	 wire						cc_z;
input	 wire						cc_c;
input	 wire	 [11:0]		addr;
input	 wire	 [11:0]		stack_d;
input  wire	 [11:0]		int_pc;
input  wire						int_en;
input  wire						int_ack;
output wire	 [11:0] 	next_addr;

function [11:0] branch;
input	[1:0]		fn2;
input					cc_z, cc_c;
input	[11:0]	disp_addr, one_addr;
	case(fn2)
		// bz
		2'b00: branch = (cc_z==1'b1) ? disp_addr: one_addr;
		// bnz
		2'b01: branch = (cc_z==1'b0) ? disp_addr: one_addr;
		// bc
		2'b10: branch = (cc_c==1'b1) ? disp_addr: one_addr;
		// bnc
		2'b11: branch = (cc_c==1'b0) ? disp_addr: one_addr;
	endcase
endfunction

assign next_addr = // 割り込み発生(ENAI状態かつ割り込み要求)かつ割り込み処理中でない場合
									 (int_en==1'b1 && int_req==1'b0 && int_ack==1'b0) ? 12'b000000000001:
									 // 条件分岐命令の場合
									 (kind==4'b0100) ? branch(fn2, cc_z, cc_c, disp_addr, one_addr):
									 // JMP, JSB命令の場合
									 (kind==4'b0101 || kind==4'b0110) ? addr:
									 // RET命令の場合(サブルーチンからの復帰)
									 (kind==4'b0111) ? stack_d:
									 // RETI命令の場合(割り込みからの復帰)
									 (kind==4'b1000) ? int_pc:
									 // その他
									 one_addr;
endmodule
