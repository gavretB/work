module draw(
clock,
reset_c,
hold_o0,
hold_o1,
hold_o2,
hold_o3,
hold_o4,
draw_s,
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
//
nnum0,
nnum1,
nnum2,
nnum3,
nnum4,
nsuit0,
nsuit1,
nsuit2,
nsuit3,
nsuit4,
pjudge
);

input clock;
input reset_c;
input hold_o0;
input hold_o1;
input hold_o2;
input hold_o3;
input hold_o4;
input draw_s;
input [3:0] Pnum0;
input [3:0] Pnum1;
input [3:0] Pnum2;
input [3:0] Pnum3;
input [3:0] Pnum4;
input [3:0] Pnum5;
input [3:0] Pnum6;
input [3:0] Pnum7;
input [3:0] Pnum8;
input [3:0] Pnum9;
input [2:0] suit0;
input [2:0] suit1;
input [2:0] suit2;
input [2:0] suit3;
input [2:0] suit4;
input [2:0] suit5;
input [2:0] suit6;
input [2:0] suit7;
input [2:0] suit8;
input [2:0] suit9;

output [3:0] nnum0;
output [3:0] nnum1;
output [3:0] nnum2;
output [3:0] nnum3;
output [3:0] nnum4;
output [2:0] nsuit0;
output [2:0] nsuit1;
output [2:0] nsuit2;
output [2:0] nsuit3;
output [2:0] nsuit4;
output pjudge;

wire clock;
wire reset_c;
wire hold_o0;
wire hold_o1;
wire hold_o2;
wire hold_o3;
wire hold_o4;
wire draw_s;
wire [3:0] Pnum0;
wire [3:0] Pnum1;
wire [3:0] Pnum2;
wire [3:0] Pnum3;
wire [3:0] Pnum4;
wire [3:0] Pnum5;
wire [3:0] Pnum6;
wire [3:0] Pnum7;
wire [3:0] Pnum8;
wire [3:0] Pnum9;
wire [2:0] suit0;
wire [2:0] suit1;
wire [2:0] suit2;
wire [2:0] suit3;
wire [2:0] suit4;
wire [2:0] suit5;
wire [2:0] suit6;
wire [2:0] suit7;
wire [2:0] suit8;
wire [2:0] suit9;

reg [3:0] nnum0;
reg [3:0] nnum1;
reg [3:0] nnum2;
reg [3:0] nnum3;
reg [3:0] nnum4;
reg [2:0] nsuit0;
reg [2:0] nsuit1;
reg [2:0] nsuit2;
reg [2:0] nsuit3;
reg [2:0] nsuit4;
reg pjudge;

always @(posedge clock or negedge reset_c) begin
	if (~reset_c) begin
		// reset
		pjudge = 1'b0;
	end
	else if (draw_s == 1'b1) begin	
	 	//draw
		if (hold_o0 == 1'b0) begin
			nnum0 = Pnum5;
			nsuit0 = suit5;
		end
		else if (hold_o0 == 1'b1) begin
			nnum0 = Pnum0;
			nsuit0 = suit0;
		end

		if (hold_o1 == 1'b0) begin
			nnum1 = Pnum6;
			nsuit1 = suit6;
		end
		else if (hold_o1 == 1'b1) begin
			nnum1 = Pnum1;
			nsuit1 = suit1;
		end

		if (hold_o2 == 1'b0) begin
			nnum2 = Pnum7;
			nsuit2 = suit7;
		end
		else if (hold_o2 == 1'b1) begin
			nnum2 = Pnum2;
			nsuit2 = suit2;
		end

		if (hold_o3 == 1'b0) begin
			nnum3 = Pnum8;
			nsuit3 = suit8;
		end
		else if (hold_o3 == 1'b1) begin
			nnum3 = Pnum3;
			nsuit3 = suit3;
		end

		if (hold_o4 == 1'b0) begin
			nnum4 = Pnum9;
			nsuit4 = suit9;
		end
		else if (hold_o4 == 1'b1) begin
			nnum4 = Pnum4;
			nsuit4 = suit4;
		end
		pjudge = 1'b1;
	end
	else if(draw_s == 1'b0) begin
		pjudge = 1'b0;
	end	
end

endmodule