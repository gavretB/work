module Djudge(
	      clock,
	      reset_c,
	      bet_c,
	      Dnum0,
	      Dnum1,
	      highlow,

	      highlow_r,
	      highlow_ro,
	      dchance2,
	      d_count
);
input wire clock;
input wire reset_c; 
input wire bet_c;
input wire [3:0] Dnum0;
input wire [3:0] Dnum1;
input wire [1:0] highlow;

output reg [1:0] highlow_r;
output reg [1:0] highlow_ro;
output reg dchance2;
output reg [1:0] d_count;

always@(posedge clock or negedge reset_c) begin
	 if(~reset_c) begin
		highlow_r = 2'b00;
		highlow_ro = 2'b00;
		dchance2 = 1'b0;
		d_count = 2'b00;
	 end
	 else if(~bet_c) begin
		highlow_r = 2'b00;
		highlow_ro = 2'b00;
		dchance2 = 1'b0;
		d_count = 2'b00;
	 end
	 else begin
		if(highlow == 2'b01) begin	  
		    if(Dnum0 > Dnum1) begin
		     highlow_r = 2'b11;
		     highlow_ro = 2'b11; 		     
		     dchance2 = 1'b0;
		     d_count = 2'b00;
		    end
		    else if (Dnum0 < Dnum1) begin
			    highlow_r = 2'b01;
			    highlow_ro = 2'b01;
			    dchance2 = 1'b1;
			    d_count = d_count + 2'b01;
		    end
		    else if(Dnum0 == Dnum1) begin
			    highlow_r = 2'b10;
			    highlow_ro = 2'b10;
			    dchance2 =1'b1;
			    d_count = d_count + 2'b01;	     
		    end
		end // if (highlow = 2'b01)
		else if(highlow == 2'b10) begin
		    if(Dnum0 < Dnum1) begin
			    highlow_r = 2'b11;
			    highlow_ro = 2'b11; 
			    dchance2 = 1'b0;
			    d_count = 2'b00;
		    end
		    else if (Dnum0 > Dnum1) begin
			    highlow_r = 2'b01;
			    highlow_ro = 2'b01;
			    dchance2 = 1'b1;
			    d_count = d_count + 2'b01;
		    end
		    else if(Dnum0 == Dnum1) begin
			    highlow_r = 2'b10;
			    highlow_ro = 2'b10;
			    dchance2 = 1'b1;
			    d_count = d_count + 2'b01;
		    end
		end // else: !if(~bet_c)
		else begin
			highlow_r = 2'b00;
		end
	    if(d_count == 2'b11) begin
			d_count = 2'b00;
			dchance2 = 1'b0;
	    end
	end // always@ (posedge clock or negedge reset_c)
end
endmodule
