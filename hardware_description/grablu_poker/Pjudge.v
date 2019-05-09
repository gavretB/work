module Pjudge(
clock,
reset_c,
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
pjudge,
//
hand_r,
dchance1
);

input clock;
input reset_c;
input [3:0] nnum0;
input [3:0] nnum1;
input [3:0] nnum2;
input [3:0] nnum3;
input [3:0] nnum4;
input [2:0] nsuit0;
input [2:0] nsuit1;
input [2:0] nsuit2;
input [2:0] nsuit3;
input [2:0] nsuit4;
input pjudge;

output [3:0] hand_r;
output dchance1;

wire clock;
wire reset_c;
wire [3:0] nnum0;
wire [3:0] nnum1;
wire [3:0] nnum2;
wire [3:0] nnum3;
wire [3:0] nnum4;
wire [2:0] nsuit0;
wire [2:0] nsuit1;
wire [2:0] nsuit2;
wire [2:0] nsuit3;
wire [2:0] nsuit4;
wire pjudge;

reg [3:0] hand_r;
//reg [1:0] judge;
reg dchance1;
reg [1:0] pair;
//reg pair2;
reg three;
reg four;
reg flash;
reg full;
reg str;
reg strf;
reg rstrf;
reg [3:0] array_n [0:4];
reg [3:0] some;
reg [2:0] count;
reg [6:0] sum;

integer i;
integer j;

always @(posedge clock or negedge reset_c) begin
	if (~reset_c) begin
		// reset
		dchance1 = 1'b0;
		hand_r = 4'b1111;
	end
	else if(pjudge == 1'b1) begin
		array_n[0] = nnum0;
		array_n[1] = nnum1;
		array_n[2] = nnum2;
		array_n[3] = nnum3;
		array_n[4] = nnum4;
		hand_r = 4'b1111;

		//sort
		for(i=0; i<4; i=i+1)begin
			for(j=i; j<4; j=j+1)begin
				if (array_n[i] > array_n[j+1]) begin
					some = array_n[i];
					array_n[i] = array_n[j+1];
					array_n[j+1] = some;
				end
			end
		end

		//judge
		pair = 2'b0;
		three = 1'b0;
		four = 1'b0;
		flash = 1'b0;
		full = 1'b0;
		str = 1'b0;
		strf = 1'b0;
		rstrf = 1'b0;

		//3card or 4card
		for(i=0; i<3; i=i+1)begin
			count = 3'b001;
			for(j=i; j<4; j=j+1)begin
				if(array_n[i] == array_n[j+1])begin
					count = count + 1'b1;
				end
				if(count == 3'b011)begin
					three = 1'b1;
					if (four == 1'b1) begin
						three = 1'b0;
					end
				end
				else if (count == 3'b100) begin
					four = 1'b1;
					three = 1'b0;
					pair = 2'b0;
				end
			end
		end

		//1pair or 2pair
		if (four == 1'b0) begin
			/*for(i=0; i<4; i=i+1'b1)begin
				for(j=i; j<4; j=j+1'b1)begin
					if(array_n[i] == array_n[j+1'b1])begin
						pair = pair + 1'b1;
						i = i+1;
						j = j+2;
					end
				end
			end*/
			if (array_n[0] == array_n[1]) begin
				pair = pair + 1'b1;
				if (array_n[2] == array_n[3]) begin
					pair = pair + 1'b1;			
				end
				else if (array_n[2] != array_n[3] && array_n[3] == array_n[4]) begin
					pair = pair + 1'b1;
				end			
			end
			else if (array_n[0] != array_n[1] && array_n[1] == array_n[2]) begin
				pair = pair + 1'b1;
				if (array_n[3] == array_n[4]) begin
					pair = pair + 1'b1;			
				end			
			end
			else if (array_n[0] != array_n[1] && array_n[1] != array_n[2] && array_n[2] == array_n[3]) begin
				pair = pair + 1'b1;
			end
			else if (array_n[0] != array_n[1] && array_n[1] != array_n[2] && array_n[2] != array_n[3] && array_n[3] == array_n[4]) begin
				pair = pair + 1'b1;
			end			
		end

		
		if (three == 1'b1 && pair == 2'b01) begin
			pair = 2'b00;
		end
		else if (three == 1'b1 && pair == 2'b10) begin
			pair = 2'b01;
		end

		//flash
		if(nsuit0 == nsuit1 && nsuit0 == nsuit2 && nsuit0 == nsuit3 && nsuit0 == nsuit4)begin
			flash = 1'b1;
			pair = 2'b0;
			three = 1'b0;
		end

		//fullhouse
		if(pair == 2'b01 && three == 1'b1)begin
			full = 1'b1;
			pair = 2'b0;
			three = 1'b0;
			flash = 1'b0;
		end

		//str or strf or rstrf
		sum = nnum0+nnum1+nnum2+nnum3+nnum4;
		if(pair == 2'b0)begin
			if((array_n[2]-array_n[0]==2 || array_n[4]-array_n[2]==2) &&
				(array_n[4]-array_n[0] == 4 || array_n[4]-array_n[0] == 12) &&
				(array_n[3]-array_n[1] == 2 || array_n[3]-array_n[1] == 10)) begin
				str = 1'b1;
			end

			if (str == 1'b1 && flash == 1'b1) begin
				strf = 1'b1;
				str = 1'b0;
				flash = 1'b0;
			end

			if (strf == 1'b1 && sum == 6'd47) begin
				rstrf = 1'b1;
				strf = 1'b0;
			end
		end

		//result
		if (pair == 2'b01) begin
			hand_r = 4'b0001;
			dchance1 = 1'b0;
		end
		else if (pair == 2'b10) begin
			hand_r = 4'b0010;
			dchance1 = 1'b1;
		end
		else if (three == 1'b1) begin
			hand_r = 4'b0011;
			dchance1 = 1'b1;			
		end
		else if (four == 1'b1) begin
			hand_r = 4'b0111;
			dchance1 = 1'b1;			
		end
		else if (flash == 1'b1 || (flash == 1'b1 && four == 1'b0))begin
			hand_r = 4'b0101;
			dchance1 = 1'b1;			
		end
		else if (full == 1'b1) begin
			hand_r = 4'b0110;
			dchance1 = 1'b1;			
		end
		else if (str == 1'b1) begin
			hand_r = 4'b0100;
			dchance1 = 1'b1;			
		end
		else if (strf == 1'b1) begin
			hand_r = 4'b1000;
			dchance1 = 1'b1;			
		end
		else if (rstrf == 1'b1) begin
			hand_r = 4'b1010;
			dchance1 = 1'b1;			
		end
		else if (pair == 2'b0  && three == 1'b0 && four == 1'b0 &&
		     flash == 1'b0 && full == 1'b0 && str == 1'b0 && strf == 1'b0 && rstrf == 1'b0) begin
			hand_r = 4'b0000;
			dchance1 = 1'b0;			
		end
	end
	else begin
		hand_r = 4'b1111;
		//dchance1 = 1'b0;
	end
end
endmodule
