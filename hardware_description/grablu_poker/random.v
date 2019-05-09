module random(
clock,
reset_c,
//double_c,
dchance1,
dchance2,
d_count,
game_s,

Pnum0,
Pnum1,
Pnum2,
Pnum3,
Pnum4,
Pnum5,
Pnum6,
Pnum7,
Pnum8,
Pnum9,
suit0,
suit1,
suit2,
suit3,
suit4,
suit5,
suit6,
suit7,
suit8,
suit9,
Dnum0,
Dnum1
);

input clock;
input reset_c;
//input double_c;
input dchance1;
input dchance2;
input [1:0] d_count;
input [1:0] game_s;

output [3:0] Pnum0;
output [3:0] Pnum1;
output [3:0] Pnum2;
output [3:0] Pnum3;
output [3:0] Pnum4;
output [3:0] Pnum5;
output [3:0] Pnum6;
output [3:0] Pnum7;
output [3:0] Pnum8;
output [3:0] Pnum9;
output [2:0] suit0;
output [2:0] suit1;
output [2:0] suit2;
output [2:0] suit3;
output [2:0] suit4;
output [2:0] suit5;
output [2:0] suit6;
output [2:0] suit7;
output [2:0] suit8;
output [2:0] suit9;
output [3:0] Dnum0;
output [3:0] Dnum1;

wire clock;
wire reset_c;
//wire double_c;
wire dchance1;
wire dchance2;
wire [1:0] d_count;
wire [1:0] game_s;

reg [3:0] Pnum0;
reg [3:0] Pnum1;
reg [3:0] Pnum2;
reg [3:0] Pnum3;
reg [3:0] Pnum4;
reg [3:0] Pnum5;
reg [3:0] Pnum6;
reg [3:0] Pnum7;
reg [3:0] Pnum8;
reg [3:0] Pnum9;
reg [2:0] suit0;
reg [2:0] suit1;
reg [2:0] suit2;
reg [2:0] suit3;
reg [2:0] suit4;
reg [2:0] suit5;
reg [2:0] suit6;
reg [2:0] suit7;
reg [2:0] suit8;
reg [2:0] suit9;
reg [3:0] Dnum0;
reg [3:0] Dnum1;

reg [3:0] rand_n0;
reg [3:0] rand_n1;
reg [3:0] rand_n2;
reg [3:0] rand_n3;
reg [3:0] rand_n4;
reg [3:0] rand_n5;
reg [3:0] rand_n6;
reg [3:0] rand_n7;
reg [3:0] rand_n8;
reg [3:0] rand_n9;
reg [3:0] rand_dn0;
reg [3:0] rand_dn1;
reg [3:0] rand_dn2;
reg [3:0] rand_dn3;
reg [3:0] rand_dn4;
reg [3:0] rand_dn5;
reg [2:0] rand_s0;
reg [2:0] rand_s1;
reg [2:0] rand_s2;
reg [2:0] rand_s3;
reg [2:0] rand_s4;
reg [2:0] rand_s5;
reg [2:0] rand_s6;
reg [2:0] rand_s7;
reg [2:0] rand_s8;
reg [2:0] rand_s9;
reg [7:0] count;



always @(posedge clock or negedge reset_c) begin
	if (~reset_c) begin
		// reset
		count = 0;
		rand_n0 = 1;
		rand_n1 = 1;
		rand_n2 = 1;
		rand_n3 = 1;
		rand_n4 = 1;
		rand_n5 = 1;
		rand_n6 = 1;
		rand_n7 = 1;
		rand_n8 = 1;
		rand_n9 = 1;
		rand_s0 = 1;
		rand_s1 = 1;
		rand_s2 = 1;
		rand_s3 = 1;
		rand_s4 = 1;
		rand_s5 = 1;
		rand_s6 = 1;
		rand_s7 = 1;
		rand_s8 = 1;
		rand_s9 = 1;
		rand_dn0 = 1;
		rand_dn1 = 1;
		rand_dn2 = 1;
		rand_dn3 = 1;
		rand_dn4 = 1;
		rand_dn5 = 1;
		
	end
	else if (game_s == 2'b01) begin
		Pnum0 = rand_n0;
		Pnum1 = rand_n1;
		Pnum2 = rand_n2;
		Pnum3 = rand_n3;
		Pnum4 = rand_n4;
		Pnum5 = rand_n5;
		Pnum6 = rand_n6;
		Pnum7 = rand_n7;
		Pnum8 = rand_n8;
		Pnum9 = rand_n9;
		suit0 = rand_s0;
		suit1 = rand_s1;
		suit2 = rand_s2;
		suit3 = rand_s3;
		suit4 = rand_s4;
		suit5 = rand_s5;
		suit6 = rand_s6;
		suit7 = rand_s7;
		suit8 = rand_s8;
		suit9 = rand_s9;

	end
	else if (game_s == 2'b10 && d_count == 2'b0 && dchance1 == 1'b1 /*&& ~double_c*/) begin
		Dnum0 = rand_dn0;
		Dnum1 = rand_dn1;
	end
	else if (game_s == 2'b10 && d_count == 2'b01 && dchance2 == 1'b1 /*&& ~double_c*/) begin
		Dnum0 = rand_dn2;
		Dnum1 = rand_dn3;
	end
	else if (game_s == 2'b10 && d_count == 2'b10 && dchance2 == 1'b1 /*&& ~double_c*/) begin
		Dnum0 = rand_dn4;
		Dnum1 = rand_dn5;
	end
	else begin
		//pnum
		if (count == 8'b11111111) begin
			count = 8'b0;
		end
		count = count + 1'b1;


		rand_n0 = rand_n0 + 1'b1;
		if (rand_n0 == 4'd14) begin
			rand_n0 = 4'b0001;
		end

		if (count % 2 == 0) begin
			rand_n1 = rand_n1 + 1'b1;
		end
		if (rand_n1 == 4'd14) begin
			rand_n1 = 4'b0001;
		end		

		if (count % 3 == 0) begin
			rand_n2 = rand_n2 + 1'b1;
		end
		if (rand_n2 == 4'd14) begin
			rand_n2 = 4'b0001;
		end		

		if (count % 5 == 0) begin
			rand_n3 = rand_n3 + 1'b1;
		end
		if (rand_n3 == 4'd14) begin
			rand_n3 = 4'b0001;
		end		

		if (count % 7 == 0) begin
			rand_n4 = rand_n4 + 1'b1;
		end
		if (rand_n4 == 4'd14) begin
			rand_n4 = 4'b0001;
		end		

		if (count % 11 == 0) begin
			rand_n5 = rand_n5 + 1'b1;
		end
		if (rand_n5 == 4'd14) begin
			rand_n5 = 4'b0001;
		end		

		if (count % 13 == 0) begin
			rand_n6 = rand_n6 + 1'b1;
		end
		if (rand_n6 == 4'd14) begin
			rand_n6 = 4'b0001;
		end		
		
		if (count % 17 == 0) begin
			rand_n7 = rand_n7 + 1'b1;
		end
		if (rand_n7 == 4'd14) begin
			rand_n7 = 4'b0001;
		end		

		if (count % 19 == 0) begin
			rand_n8 = rand_n8 + 1'b1;
		end
		if (rand_n8 == 4'd14) begin
			rand_n8 = 4'b0001;
		end		
		
		if (count % 23 == 0) begin
			rand_n9 = rand_n9 + 1'b1;
		end
		if (rand_n9 == 4'd14) begin
			rand_n9 = 4'b0001;
		end		

		//suit

		rand_s0 = rand_s0 + 1'b1;
		if (rand_s0 == 3'd5) begin
			rand_s0 = 3'b001;
		end		

		if (count % 2 == 0) begin
			rand_s1 = rand_s1 + 1'b1;
		end
		if (rand_s1 == 3'd5) begin
			rand_s1 = 3'b001;
		end		

		if (count % 3 == 0) begin
			rand_s2 = rand_s2 + 1'b1;
		end
		if (rand_s2 == 3'd5) begin
			rand_s2 = 3'b001;
		end		

		if (count % 5 == 0) begin
			rand_s3 = rand_s3 + 1'b1;
		end
		if (rand_s3 == 3'd5) begin
			rand_s3 = 3'b001;
		end		

		if (count % 7 == 0) begin
			rand_s4 = rand_s4 + 1'b1;
		end
		if (rand_s4 == 3'd5) begin
			rand_s4 = 3'b001;
		end		

		if (count % 11 == 0) begin
			rand_s5 = rand_s5 + 1'b1;
		end
		if (rand_s5 == 3'd5) begin
			rand_s5 = 3'b001;
		end		

		if (count % 13 == 0) begin
			rand_s6 = rand_s6 + 1'b1;
		end
		if (rand_s6 == 3'd5) begin
			rand_s6 = 3'b001;
		end		
		
		if (count % 17 == 0) begin
			rand_s7 = rand_s7 + 1'b1;
		end
		if (rand_s7 == 3'd5) begin
			rand_s7 = 3'b001;
		end		

		if (count % 19 == 0) begin
			rand_s8 = rand_s8 + 1'b1;
		end
		if (rand_s8 == 3'd5) begin
			rand_s8 = 3'b001;
		end		
		
		if (count % 23 == 0) begin
			rand_s9 = rand_s9 + 1'b1;
		end
		if (rand_s9 == 3'd5) begin
			rand_s9 = 3'b001;
		end		

		//dnum
		rand_dn0 = rand_dn0 + 1'b1;
		if (rand_dn0 == 4'd14) begin
			rand_dn0 = 4'b0001;
		end

		if (count % 2 == 0) begin
			rand_dn1 = rand_dn1 + 1'b1;
		end
		if (rand_dn1 == 4'd14) begin
			rand_dn1 = 4'b0001;
		end		

		if (count % 3 == 0) begin
			rand_dn2 = rand_dn2 + 1'b1;
		end
		if (rand_dn2 == 4'd14) begin
			rand_dn2 = 4'b0001;
		end		

		if (count % 5 == 0) begin
			rand_dn3 = rand_dn3 + 1'b1;
		end
		if (rand_dn3 == 4'd14) begin
			rand_dn3 = 4'b0001;
		end		

		if (count % 7 == 0) begin
			rand_dn4 = rand_dn4 + 1'b1;
		end
		if (rand_dn4 == 4'd14) begin
			rand_dn4 = 4'b0001;
		end		

		if (count % 11 == 0) begin
			rand_dn5 = rand_dn5 + 1'b1;
		end
		if (rand_dn5 == 4'd14) begin
			rand_dn5 = 4'b0001;
		end				

	end
end

endmodule

