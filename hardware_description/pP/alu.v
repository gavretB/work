module alu (
fn3,
fn2,
rd1,
rd2,
kind,
_const,
sc,
Wdata,
store_ex
);

input	 wire  [2:0]	fn3;
input	 wire  [1:0]	fn2;
input	 wire  [7:0]	rd1;
input	 wire  [7:0]	rd2;
input	 wire  [3:0]	kind;
input	 wire  [7:0]	_const;
input	 wire  [2:0]	sc;
output wire  [7:0]	Wdata;
output wire         store_ex;

function [8:0] reg_reg;
input 	[7:0]	rd1, rd2;
input	[2:0]	fn3;
 	case(fn3)
		3'b000: reg_reg = rd1 + rd2;
		3'b001: reg_reg = rd1 + rd2;
    3'b010: reg_reg = rd1 - rd2;
    3'b011: reg_reg = rd1 - rd2;
    3'b100: reg_reg = rd1 & rd2;
    3'b101: reg_reg = rd1 | rd2;
    3'b110: reg_reg = rd1 ^ rd2;
    3'b111: reg_reg = ~(rd1 & rd2);
	endcase
endfunction

function [8:0] reg_immed;
input	[7:0]	rd1, _const;
input 	[2:0]	fn3;
 	case(fn3)
		3'b000: reg_immed = rd1 + _const;
		3'b001: reg_immed = rd1 + _const;
    3'b010: reg_immed = rd1 - _const;
    3'b011: reg_immed = rd1 - _const;
    3'b100: reg_immed = rd1 & _const;
    3'b101: reg_immed = rd1 | _const;
    3'b110: reg_immed = rd1 ^ _const;
    3'b111: reg_immed = ~(rd1 & _const);
	endcase
endfunction

function [7:0] shift;
input	[7:0]	rd1;
input	[2:0]	sc;
input	[1:0]	fn2;
	case(fn2)
		2'b00: shift = rd1 << sc;
		2'b01: shift = rd1 >> sc;
		2'b10: shift = (rd1 << sc%8) + (rd1 >> (8-sc%8));
    2'b11: shift = (rd1 >> sc%8) + (rd1 << (8-sc%8));
	endcase
endfunction

function [7:0] Wdata_decision;
input	[8:0]	reg_reg;
input [8:0] reg_immed;
input [7:0] shift;
input	[3:0]	kind;
	case( kind )
    // reg_reg命令の場合
		4'b0000: Wdata_decision = reg_reg[7:0];
    // reg_immed命令の場合
    4'b0001: Wdata_decision = reg_immed[7:0];
    // shift命令の場合
    4'b0010: Wdata_decision = shift;
    // その他
    default: Wdata_decision = 8'bxxxxxxxx;
	endcase
endfunction

function store_ex_decision;
input	[8:0]	reg_reg;
input [8:0] reg_immed;
input	[3:0]	kind;
input	[2:0]	fn3;
input	[1:0]	fn2;
input	[2:0]	sc;
input [7:0] rd1;
	case( kind )
    // reg_reg命令の場合
		4'b0000: store_ex_decision = // 値演算の場合
                                 (fn3==3'b000 || fn3==3'b001 || fn3==3'b010 || fn3==3'b011) ? reg_reg[8]:
                                 // 論理演算の場合
                                 1'b0;
    // reg_immed命令の場合
    4'b0001: store_ex_decision = // 値演算の場合
                                 (fn3==3'b000 || fn3==3'b001 || fn3==3'b010 || fn3==3'b011) ? reg_immed[8]:
                                 // 論理演算の場合
                                 1'b0;
    // shift命令の場合
    4'b0010: store_ex_decision = // シフト数が0の場合
                                 (sc == 3'b000) ? 1'b0:
                                 // 左シフト、ローテの場合
                                 (fn2==2'b00 || fn2==2'b10) ? rd1[8-sc]:
                                 // 右シフト、ローテの場合
                                 (fn2==2'b01 || fn2==2'b11) ? rd1[sc-1]:
                                 // その他
                                 1'bx;
    // その他
    default: store_ex_decision = 1'b0;
  endcase

endfunction

assign	Wdata = Wdata_decision (
                reg_reg(rd1, rd2, fn3),
                reg_immed(rd1, _const, fn3),
                shift(rd1, sc, fn2),
                kind
                );
assign	store_ex = store_ex_decision (
                   reg_reg(rd1, rd2, fn3),
                   reg_immed(rd1, _const, fn3),
                   kind,
                   fn3,
                   fn2,
                   sc,
                   rd1
                   );

endmodule
