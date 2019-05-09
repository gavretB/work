module decode (
inst,
fn3,
fn2,
Waddr,
Raddr1,
Raddr2,
kind,
_const,
sc,
disp,
addr
);

input	[18:0]	inst;
output	[2:0]	fn3;
output	[1:0]	fn2;
output	[2:0]	Waddr;
output	[2:0]	Raddr1;
output	[2:0]	Raddr2;
output	[3:0]	kind;
output	[7:0]	_const;
output	[2:0]	sc;
output	[7:0]	disp;
output	[11:0]	addr;

assign	kind = kind_decision(inst);
assign	fn3 = // reg_reg、reg_immedの場合
							(kind==4'b0000 || kind==4'b0001) ? fn3_decision(inst, kind):
							// その他
							3'bxxx;
assign	fn2 = // shift、mem_IO、Branchの場合
							(kind==4'b0010 || kind==4'b0011 || kind==4'b0100) ? fn2_decision(inst, kind):
							// その他
							2'bxx;
assign	Waddr = Waddr_decision(inst, kind);
assign	Raddr1 = // reg_reg、reg_immed、shift、mem_IOの場合
								 (kind==4'b0000 || kind==4'b0001 || kind==4'b0010 || kind == 4'b0011) ? Raddr1_decision(inst, kind):
								 // その他
								 3'bxxx;
assign	Raddr2 = // reg_regの場合
								 (kind==4'b0000) ? Raddr2_decision(inst, kind):
								 // その他
								 3'bxxx;
assign	_const = // reg_immedの場合
								 (kind==4'b0001) ? _const_decision(inst, kind):
								 // その他
								 8'bxxxxxxxx;
assign	sc = // shiftの場合
						 (kind==4'b0010) ? sc_decision(inst, kind):
						 // その他
						 3'bxxx;
assign	disp = // mem_IO、branchの場合
							 (kind==4'b0011 || kind==4'b0100) ? disp_decision(inst, kind):
							 // その他
							 8'bxxxxxxxx;
assign	addr = // jmp、jsbの場合
							 (kind==4'b0101 || kind==4'b0110) ? addr_decision(inst, kind):
							 // その他
							 12'bxxxxxxxxxxxx;
// 命令種
function [3:0] kind_decision;
input 	[18:0] inst;
	// reg_reg命令の場合
	if ( inst[18:17]==2'b00 ) begin
		kind_decision = 4'b0000;
	end
	// reg_immed命令の場合
	else if ( inst[18:17]==2'b01 ) begin
		kind_decision = 4'b0001;
	end
	// shift命令の場合
	else if ( inst[18:16]==3'b110 ) begin
		kind_decision = 4'b0010;
	end
	// mem_IO命令の場合
	else if ( inst[18:16]==3'b100 ) begin
		kind_decision = 4'b0011;
	end
	// branch命令の場合
	else if ( inst[18:16]==3'b101 ) begin
		kind_decision = 4'b0100;
	end
	// JMP命令の場合
	else if ( inst[18:14]==5'b11100 ) begin
		kind_decision = 4'b0101;
	end
	// JSB命令の場合
	else if ( inst[18:14]==5'b11101 ) begin
		kind_decision = 4'b0110;
	end
	// RET命令の場合
	else if ( inst[18:13]==6'b111100 ) begin
		kind_decision = 4'b0111;
	end
	// RETI命令の場合
	else if ( inst[18:13]==6'b111101 ) begin
		kind_decision = 4'b1000;
	end
	// ENAI命令の場合
	else if ( inst[18:13]==6'b111110 ) begin
		kind_decision = 4'b1001;
	end
	// DISI命令の場合
	else if ( inst[18:13]==6'b111111 ) begin
		kind_decision = 4'b1010;
	end
	// その他
	else begin
		kind_decision = 4'b1111;
	end
endfunction

function [2:0] fn3_decision;
input [18:0]	inst;
input	[3:0]		kind;
	// reg_reg, reg_immed命令の場合
	if (kind == 4'b0000 || kind ==4'b0001) begin
		fn3_decision = inst[16:14];
	end
	// その他
	else begin
		fn3_decision = 3'bxxx;
	end
endfunction

function [1:0] fn2_decision;
input [18:0]	inst;
input	[3:0]		kind;
	// shift, mem_IO, branch命令の場合
	if (kind==4'b0010 || kind==4'b0011 || kind==4'b0100) begin
		fn2_decision = inst[15:14];
	end
	// その他
	else begin
		fn2_decision = 2'bxx;
	end
endfunction

function [2:0] Waddr_decision;
input [18:0]	inst;
input	[3:0]		kind;
	// reg_reg, reg_immed, shift, mem_IO命令の場合
	if (kind==4'b0000 || kind==4'b0001 || kind==4'b0010 || kind==4'b0011) begin
		Waddr_decision = inst[13:11];
	end
	// その他
	else begin
		Waddr_decision = 3'bxxx;
	end
endfunction

function [2:0] Raddr1_decision;
input [18:0]	inst;
input	[3:0]		kind;
	// reg_reg, reg_immed, shift, mem_IO命令の場合
	if (kind==4'b0000 || kind==4'b0001 || kind==4'b0010 || kind==4'b0011) begin
		Raddr1_decision = inst[10:8];
	end
	// その他
	else begin
		Raddr1_decision = 3'bxxx;
	end
endfunction

function [2:0] Raddr2_decision;
input [18:0]	inst;
input	[3:0]		kind;
	// reg_reg命令の場合
	if (kind==4'b0000) begin
		Raddr2_decision = inst[7:5];
	end
	// その他
	else begin
		Raddr2_decision = 3'bxxx;
	end
endfunction

function [7:0] _const_decision;
input 	[18:0]	inst;
input	[3:0]	kind;
	// reg_immed命令の場合
	if (kind==4'b0001) begin
		_const_decision = inst[7:0];
	end
	// その他
	else begin
		_const_decision = 8'bxxxxxxxx;
	end
endfunction

function [2:0] sc_decision;
input [18:0]	inst;
input	[3:0]		kind;
	// shift命令の場合
	if (kind==4'b0010) begin
		sc_decision = inst[7:5];
	end
	// その他
	else begin
		sc_decision = 3'bxxx;
	end
endfunction

function [7:0] disp_decision;
input [18:0]	inst;
input	[3:0]		kind;
	// mem_IO, branch命令の場合
	if (kind==4'b0011 || kind==4'b100) begin
		disp_decision = inst[7:0];
	end
	// その他
	else begin
		disp_decision = 8'bxxxxxxxx;
	end
endfunction

function [11:0] addr_decision;
input [18:0]	inst;
input	[3:0]		kind;
	// JMP, JSB命令の場合
	if (kind==4'b0101 || kind==4'b0110) begin
		addr_decision = inst[11:0];
	end
	// その他
	else begin
		addr_decision = 12'bxxxxxxxxxxxx;
	end
endfunction

endmodule
