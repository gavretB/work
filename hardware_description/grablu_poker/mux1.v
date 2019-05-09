module mux1(
seg_w0,
seg_w1,
seg_w2,
seg_w3,
seg_m0,
seg_m1,
seg_m2,
seg_m3,
seg_h,
seg_pn0,
seg_pn1,
seg_pn2,
seg_pn3,
seg_pn4,
seg_nn0,
seg_nn1,
seg_nn2,
seg_nn3,
seg_nn4,
seg_s0,
seg_s1,
seg_s2,
seg_s3,
seg_s4,
seg_ns0,
seg_ns1,
seg_ns2,
seg_ns3,
seg_ns4,
seg_dn0,
seg_dn1,
seg_dr0,
seg_dr1,
seg_dr2,
seg_dr3,
select,
//
segR0,
segR1,
segR2,
segR3,
segL0,
segL1,
segL2,
segL3
);

input [7:0] seg_w0;
input [7:0] seg_w1;
input [7:0] seg_w2;
input [7:0] seg_w3;
input [7:0] seg_m0;
input [7:0] seg_m1;
input [7:0] seg_m2;
input [7:0] seg_m3;
input [7:0] seg_h;
input [7:0] seg_pn0;
input [7:0] seg_pn1;
input [7:0] seg_pn2;
input [7:0] seg_pn3;
input [7:0] seg_pn4;
input [7:0] seg_nn0;
input [7:0] seg_nn1;
input [7:0] seg_nn2;
input [7:0] seg_nn3;
input [7:0] seg_nn4;
input [7:0] seg_s0;
input [7:0] seg_s1;
input [7:0] seg_s2;
input [7:0] seg_s3;
input [7:0] seg_s4;
input [7:0] seg_ns0;
input [7:0] seg_ns1;
input [7:0] seg_ns2;
input [7:0] seg_ns3;
input [7:0] seg_ns4;
input [7:0] seg_dn0;
input [7:0] seg_dn1;
input [7:0] seg_dr0;
input [7:0] seg_dr1;
input [7:0] seg_dr2;
input [7:0] seg_dr3;
input [3:0] select;

output [7:0] segR0;
output [7:0] segR1;
output [7:0] segR2;
output [7:0] segR3;
output [7:0] segL0;
output [7:0] segL1;
output [7:0] segL2;
output [7:0] segL3;

wire [7:0] seg_w0;
wire [7:0] seg_w1;
wire [7:0] seg_w2;
wire [7:0] seg_w3;
wire [7:0] seg_m0;
wire [7:0] seg_m1;
wire [7:0] seg_m2;
wire [7:0] seg_m3;
wire [7:0] seg_h;
wire [7:0] seg_pn0;
wire [7:0] seg_pn1;
wire [7:0] seg_pn2;
wire [7:0] seg_pn3;
wire [7:0] seg_pn4;
wire [7:0] seg_nn0;
wire [7:0] seg_nn1;
wire [7:0] seg_nn2;
wire [7:0] seg_nn3;
wire [7:0] seg_nn4;
wire [7:0] seg_s0;
wire [7:0] seg_s1;
wire [7:0] seg_s2;
wire [7:0] seg_s3;
wire [7:0] seg_s4;
wire [7:0] seg_ns0;
wire [7:0] seg_ns1;
wire [7:0] seg_ns2;
wire [7:0] seg_ns3;
wire [7:0] seg_ns4;
wire [7:0] seg_dn0;
wire [7:0] seg_dn1;
wire [7:0] seg_dr0;
wire [7:0] seg_dr1;
wire [7:0] seg_dr2;
wire [7:0] seg_dr3;
wire [3:0] select;

wire [7:0] segR0;
wire [7:0] segR1;
wire [7:0] segR2;
wire [7:0] segR3;
wire [7:0] segL0;
wire [7:0] segL1;
wire [7:0] segL2;
wire [7:0] segL3;

assign segR0 = segr1(seg_w0,seg_h,seg_pn4,seg_nn4,seg_s4,seg_ns4,seg_dn1,seg_dr3,select);
assign segR1 = segr2(seg_w1,seg_pn3,seg_nn3,seg_s3,seg_ns3,seg_dr2,select);
assign segR2 = segr2(seg_w2,seg_pn2,seg_nn2,seg_s2,seg_ns2,seg_dr1,select);
assign segR3 = segr2(seg_w3,seg_pn1,seg_nn1,seg_s1,seg_ns1,seg_dr0,select);
assign segL0 = segl1(seg_m0,seg_pn0,seg_nn0,seg_s0,seg_ns0,seg_dn0,select);
assign segL1 = segl2(seg_m1,select);
assign segL2 = segl2(seg_m2,select);
assign segL3 = segl3(seg_m3,select);

function [7:0] segr1;
	input [7:0] seg_w;
	input [7:0] seg_h;
	input [7:0] seg_pn;
	input [7:0] seg_nn;
	input [7:0] seg_s;
	input [7:0] seg_ns;
	input [7:0] seg_dn;
	input [7:0] seg_dr;
	input [3:0] select;
	//segr1 = 8'b11111111;
	case(select)
		4'b0001: segr1 = seg_w;
		4'b0010: segr1 = seg_pn;
		4'b0011: segr1 = seg_s;
		4'b0100: segr1 = seg_nn;
		4'b1011: segr1 = seg_ns;
		4'b1101: segr1 = seg_dn;
		4'b0110: segr1 = seg_h;
		4'b0111: segr1 = seg_dr;
		default: segr1 = 8'b0;
	endcase
endfunction		

function [7:0] segr2;
	input [7:0] seg_w;
	input [7:0] seg_pn;
	input [7:0] seg_nn;
	input [7:0] seg_s;
	input [7:0] seg_ns;
	input [7:0] seg_dr;
	input [3:0] select;
	case(select)
		4'b0001: segr2 = seg_w;
		4'b0010: segr2 = seg_pn;
		4'b0011: segr2 = seg_s;
		4'b0100: segr2 = seg_nn;
		4'b1011: segr2 = seg_ns;
		4'b0111: segr2 = seg_dr;
		default: segr2 = 8'b0;
	endcase
endfunction

function [7:0] segl1;
	input [7:0] seg_m;
	input [7:0] seg_pn;
	input [7:0] seg_nn;
	input [7:0] seg_s;
	input [7:0] seg_ns;
	input [7:0] seg_dn;
	input [3:0] select;
	case(select)
		4'b0001: segl1 = seg_m;
		4'b0010: segl1 = seg_pn;
		4'b0011: segl1 = seg_s;
		4'b0100: segl1 = seg_nn;
		4'b1011: segl1 = seg_ns;
		4'b0101: segl1 = seg_dn;
		4'b1101: segl1 = seg_dn;
		default: segl1 = 8'b0;
	endcase
endfunction

function [7:0] segl2;
	input [7:0] seg_m;
	input [3:0] select;
	case(select)
		4'b0001: segl2 = seg_m;
		default: segl2 = 8'b0;
	endcase
endfunction	

function [7:0] segl3;
	input [7:0] seg_m;
	input [3:0] select;
	case(select)
		4'b0001: segl3 = seg_m;
		4'b0010: segl3 = 8'b11001110;
		4'b0011: segl3 = 8'b10110110;
		4'b0100: segl3 = 8'b11001110;
		4'b1011: segl3 = 8'b10110110;
		4'b0110: segl3 = 8'b00101110;
		4'b0101: segl3 = 8'b01111010;
		4'b1101: segl3 = 8'b01111010;
		4'b0111: segl3 = 8'b01111000;
		default: segl3 = 8'b0;
	endcase
endfunction							


endmodule