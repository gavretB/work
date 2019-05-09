module fsm_game(
clock,
reset_c,
bet_c,
betup_c,
betdw_c,
start_c,
hold_c0,
hold_c1,
hold_c2,
hold_c3,
hold_c4,
draw_c,
double_c,
high_c,
low_c,
//money_c,
suit_c,
hand_c,
dchance1,
dchance2,
//
bet_s,
updown,
hold_o0,
hold_o1,
hold_o2,
hold_o3,
hold_o4,
draw_s,
game_s,
highlow,
select
);

input clock;
input reset_c;
input bet_c;
input betup_c;
input betdw_c;
input start_c;
input hold_c0;
input hold_c1;
input hold_c2;
input hold_c3;
input hold_c4;
input draw_c;
input double_c;
input high_c;
input low_c;
//input money_c;
input suit_c;
input hand_c;
input dchance1;
input dchance2;

output bet_s;
output [1:0] updown;
output [3:0] select;
output hold_o0;
output hold_o1;
output hold_o2;
output hold_o3;
output hold_o4;
output draw_s;
output [1:0] game_s;
output [1:0] highlow;

wire clock;
wire reset_c;
wire bet_c;
wire betup_c;
wire betdw_c;
wire start_c;
wire hold_c0;
wire hold_c1;
wire hold_c2;
wire hold_c3;
wire hold_c4;
wire draw_c;
wire double_c;
wire high_c;
wire low_c;
//wire money_c;
wire suit_c;
wire hand_c;
wire dchance1;
wire dchance2;

reg bet_s;
reg [1:0] updown;
reg [3:0] select;
reg hold_o0;
reg hold_o1;
reg hold_o2;
reg hold_o3;
reg hold_o4;
reg draw_s;
reg [1:0] game_s;
reg [1:0] highlow;
reg [2:0] cur;

parameter s0 = 0;
parameter s1 = 1;
parameter s2 = 2;
parameter s3 = 3;
parameter s4 = 4;
parameter s5 = 5;

// s0:初期、s1:賭け金設定、s2:pゲーム開始、s3:p判定、s4:dup開始、s5:d判定
always @(posedge clock or negedge reset_c) begin
	if (~reset_c) begin
		cur = s0;
		bet_s 	= 1'b0;
		updown 	= 2'b00;
		hold_o0 = 1'b0;
		hold_o1 = 1'b0;
		hold_o2 = 1'b0;
		hold_o3 = 1'b0;
		hold_o4 = 1'b0;
		draw_s = 1'b0;
		game_s = 2'b00;
		highlow = 2'b0;
		select = 4'b0000;			
	end
	else begin
		case(cur)
			s0:begin
				if (~bet_c) begin
					cur = s1;
					bet_s = 1'b1;
					select = 4'b0001;
				end
				else begin
					cur = s0;
					select = 4'b0000;
				end
			end
			s1:begin
				if (~betup_c) begin
					cur = s1;
					bet_s = 1'b1;
					updown = 2'b01;
					select = 4'b0001;						
				end
				else if (~betdw_c) begin
					cur = s1;
					bet_s = 1'b1;
					updown = 2'b10;
					select = 4'b0001;								
				end
				else if (~start_c) begin
					cur = s2;
					bet_s = 1'b0;
					updown = 2'b00;
					select = 4'b0010;
					game_s = 2'b01;
				end 
				else begin
					cur = s1;
					bet_s = 1'b1;
					updown = 2'b00;
					select = 4'b0001;
				end
			end
			s2:begin
				if (~hold_c0) begin
					cur = s2;
					hold_o0 = ~hold_o0;
					select = 4'b0010;				
				end
				else if (~hold_c1) begin
					cur = s2;
					hold_o1 = ~hold_o1;
					select = 4'b0010;				
				end
				else if (~hold_c2) begin
					cur = s2;
					hold_o2 = ~hold_o2;
					select = 4'b0010;				
				end
				else if (~hold_c3) begin
					cur = s2;
					hold_o3 = ~hold_o3;
					select = 4'b0010;				
				end
				else if (~hold_c4) begin
					cur = s2;
					hold_o4 = ~hold_o4;
					select = 4'b0010;				
				end
				else if (suit_c == 1'b0) begin
					cur = s2;					
					select = 4'b0011;				
				end
				else if (~draw_c) begin
					cur = s3;
					draw_s = 1'b1;
					select = 4'b0100;
				end
				else begin
					cur = s2;
					select = 4'b0010;
				end
			end
			s3:begin
				if (dchance1 == 1'b1 && ~double_c) begin
					cur = s4;
					game_s = 2'b10;
					draw_s = 1'b0;
					select = 4'b0101;
				end
				else if (suit_c == 1'b0) begin
					cur =s3;
					select = 4'b1011;
				end
				else if (hand_c == 1'b0) begin
					cur = s3;
					select = 4'b0110;
				end
				else if (~bet_c) begin
					cur = s1;
					bet_s = 1'b1;
					game_s = 2'b00;
					draw_s = 1'b0;
					hold_o0 = 1'b0;
					hold_o1 = 1'b0;
					hold_o2 = 1'b0;
					hold_o3 = 1'b0;
					hold_o4 = 1'b0;
					select = 4'b0001;				
				end
				else begin
					cur = s3;
					select = 4'b0100;
				end
			end
			s4:begin
				if (~high_c) begin
					cur = s5;
					highlow = 2'b01;
					game_s = 2'b11;
					select = 4'b1101;
				end
				else if (~low_c) begin
					cur = s5;
					highlow = 2'b10;
					game_s = 2'b11;
					select = 4'b1101;
				end
				else begin
					cur = s4;
					highlow = 2'b00;
					select = 4'b0101;
				end
			end
			s5:begin
				if (dchance2 == 1'b1 && ~double_c) begin
					cur = s4;
					game_s = 2'b10;
					highlow = 2'b00;
					select = 4'b0101;
				end
				else if (dchance2 == 1'b0 && ~double_c) begin
					cur = s1;
					bet_s = 1'b1;
					game_s = 2'b00;
					hold_o0 = 1'b0;
					hold_o1 = 1'b0;
					hold_o2 = 1'b0;
					hold_o3 = 1'b0;
					hold_o4 = 1'b0;
					highlow = 2'b00;
					select = 4'b0001;
				end
				else if (~bet_c) begin
					cur = s1;
					bet_s = 1'b1;
					game_s = 2'b00;
					hold_o0 = 1'b0;
					hold_o1 = 1'b0;
					hold_o2 = 1'b0;
					hold_o3 = 1'b0;
					hold_o4 = 1'b0;
					highlow = 2'b00;
					select = 4'b0001;					
				end
				else if (hand_c == 1'b0) begin
					cur = s5;
					select = 4'b0111;
				end
				else begin
					cur = s5;
					game_s = 2'b11;
					highlow = 2'b00;
					select = 4'b1101;	
				end			
			end
		endcase
	end
end

endmodule