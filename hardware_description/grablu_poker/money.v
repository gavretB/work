module money(
clock,
reset_c,
bet_s,
updown,
money_r,
//
wager_o,
mih_o
);

input clock;
input reset_c;
input bet_s;
input [1:0] updown;
input [15:0] money_r;


output [15:0] wager_o;
output [15:0] mih_o;

wire clock;
wire reset_c;
wire bet_s;
wire [1:0] updown;
wire [15:0] money_r;

reg [15:0] wager_o;
reg [15:0] mih_o;

always @(posedge clock or negedge reset_c) begin
	if (~reset_c) begin
		// reset
		wager_o = 16'b0000000000001010;
		mih_o = 16'b0000001111101000;
	end
	else if (bet_s == 1'b1) begin
		mih_o = money_r;
		if (wager_o >= mih_o) begin
			wager_o = mih_o;
		end		
		if (updown == 2'b01 && wager_o < mih_o) begin
			wager_o = wager_o + 16'b0000000000001010;		
		end
		else if (updown == 2'b01 && wager_o == mih_o) begin
			wager_o = mih_o;
		end
		else if (updown == 2'b10 && wager_o > 16'b0000000000001010) begin
			wager_o = wager_o - 16'b0000000000001010;
		end
		else if (updown == 2'b10 && wager_o == 16'd10) begin
			wager_o = 16'd10;
		end
		else begin
			wager_o = wager_o;
		end
	end
	//mih_o = money_r;
end

endmodule