module management(
clock,
reset_c,	
wager_o,
mih_o,
hand_r,
game_s,
highlow_r,
//bet_c,
money_r
);

input clock;
input reset_c;
input [15:0] wager_o;
input [15:0] mih_o;
input [3:0] hand_r;
input [1:0] game_s;
input [1:0] highlow_r;
//input bet_c;

output [15:0] money_r;

wire clock;
wire reset_c;
wire [15:0] wager_o;
wire [15:0] mih_o;
wire [3:0] hand_r;
wire [1:0] game_s;
wire [1:0] highlow_r;
//wire bet_c;

reg [15:0] money_r;
reg [15:0] money1;
reg	[15:0] money2;
reg [15:0] wager1;
//reg [15:0] wager2;
//reg [1:0] manage;


always @(posedge clock or negedge reset_c) begin
	if (~reset_c) begin
		// reset
		money_r = 16'd1000;
		money1 = 16'd1000;
		money2 = 16'b0;
		wager1 = 16'b0;
		//wager2 = 16'b0;
	end
	else if (game_s == 2'b01 /*&& hand_r != 4'b1111*/) begin
		//money1 = mih_o;
		money2 = mih_o - wager_o;
		if (hand_r == 4'b0010 || hand_r == 4'b0011) begin //ツーペア、スリーペア
			wager1 = wager_o; //1倍
			money1 = money2 + wager1;
		end
		else if (hand_r == 4'b0100) begin //ストレート
			wager1 = wager_o * 16'b0000000000000010; //2倍
			money1 = money2 + wager1;
		end
		else if (hand_r == 4'b0101) begin //フラッシュ
			wager1 = wager_o * 16'b0000000000000100; //4倍
			money1 = money2 + wager1;
		end
		else if (hand_r == 4'b0110) begin //フルハウス
			wager1 = wager_o * 16'b0000000000000101; //5倍
			money1 = money2 + wager1;
		end
		else if (hand_r == 4'b0111) begin //フォーカード
			wager1 = wager_o * 16'b0000000000001010; //10倍
			money1 = money2 + wager1;
		end
		else if (hand_r == 4'b1000) begin //ストレートフラッシュ
			wager1 = wager_o * 16'b0000000000001111; //15倍
			money1 = money2 + wager1;
		end
		else if (hand_r == 4'b1010) begin //ロイヤルストレートフラッシュ
			wager1 = wager_o * 16'b0000000001100100; //100倍
			money1 = money2 + wager1;
		end
		else if (hand_r == 4'b0000 || hand_r == 4'b0001) begin
			money1 = money2;
		end
		else begin
			wager1 = wager1;
		end
		money_r = money1;
	end
	else if (game_s == 2'b11 /*&& highlow_r != 2'b00*/) begin

		if (highlow_r == 2'b01) begin //Win
			wager1 = wager1 * 2'b10;
			money1 = money2 + wager1;
		end
		else if (highlow_r == 2'b10) begin //Draw
			wager1 = wager1;
			money1 = money2 + wager1;
		end
		else if (highlow_r == 2'b11) begin //Lose
			money1 = money2;
		end
		else begin
			wager1 = wager1;
		end
		money_r = money1;
	end
	money1 = money1;
	//money_r = money1;
end

endmodule