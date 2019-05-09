module pP (
ck,
res,
int_req,
ck2,
cur_addr,
rd1,
rd2,
fn3,
fn2,
Wdata,
kind,
_const,
sc,
disp,
cc_c,
cc_z,
sp,
load_d,
store_d,
int_en,
int_ack
);

input  wire         ck;
input  wire         res;
input  wire         int_req;
input  wire         ck2;
output wire	[11:0]	cur_addr;
output wire [3:0]   kind;
output wire [2:0]   fn3;
output wire [1:0]   fn2;
output wire [7:0]   Wdata;
output wire [7:0]   rd1;
output wire [7:0]   rd2;
output wire [7:0]   _const;
output wire [2:0]   sc;
output wire [7:0]  disp;
output wire         cc_z;
output wire         cc_c;
output wire [2:0]   sp;
output wire [7:0]   load_d;
output wire [7:0]   store_d;
output wire         int_en;
output wire         int_ack;

wire	[11:0]  next_addr;
wire	[18:0]	inst;
wire	[2:0]	  Waddr;
wire	[2:0]	  Raddr1;
wire	[2:0]	  Raddr2;
wire		      store_ex;
wire	[11:0]	disp_addr;
wire	[11:0]	one_addr;
wire	[11:0]	addr;
wire	[11:0]	stack_d;
wire  [11:0]  int_pc;
wire          int_z;
wire          int_c;

// 子モジュール
pc pc (
.ck (ck),
.res  (res),
.ck2 (ck2),
.next_addr  (next_addr),
.cur_addr (cur_addr)
);

mux1 mux1 (
.int_req (int_req),
.disp_addr  (disp_addr),
.one_addr (one_addr),
.fn2  (fn2),
.kind (kind),
.cc_z (cc_z),
.cc_c (cc_c),
.addr (addr),
.stack_d  (stack_d),
.int_pc (int_pc),
.int_en (int_en),
.int_ack    (int_ack),
.next_addr  (next_addr)
);

mux2 mux2 (
.cur_addr  (cur_addr),
.disp  (disp),
.disp_addr  (disp_addr),
.one_addr (one_addr)
);

int_reg int_reg (
.ck (ck),
.res (res),
.int_req (int_req),
.ck2 (ck2),
.one_addr (one_addr),
.cc_z (cc_z),
.cc_c (cc_c),
.kind (kind),
.int_pc (int_pc),
.int_z  (int_z),
.int_c  (int_c),
.int_en (int_en),
.int_ack  (int_ack)
);

imem imem (
.cur_addr (cur_addr),
.inst (inst)
);

decode decode (
.inst (inst),
.fn3  (fn3),
.fn2  (fn2),
.Waddr  (Waddr),
.Raddr1 (Raddr1),
.Raddr2 (Raddr2),
.kind (kind),
._const  (_const),
.sc (sc),
.disp (disp),
.addr (addr)
);

register register (
.ck (ck),
.res  (res),
.ck2 (ck2),
.fn2  (fn2),
.kind (kind),
.Waddr  (Waddr),
.Raddr1 (Raddr1),
.Raddr2 (Raddr2),
.Wdata  (Wdata),
.load_d  (load_d),
.rd1 (rd1),
.rd2 (rd2),
.store_d (store_d)
);

alu alu (
.fn3  (fn3),
.fn2  (fn2),
.rd1 (rd1),
.rd2 (rd2),
.kind (kind),
._const  (_const),
.sc (sc),
.Wdata  (Wdata),
.store_ex (store_ex)
);

cc cc (
.ck (ck),
.res (res),
.ck2 (ck2),
.store_ex (store_ex),
.kind (kind),
.fn3  (fn3),
.Waddr (Waddr),
.Wdata  (Wdata),
.rd1 (rd1),
.rd2 (rd2),
._const  (_const),
.int_c  (int_c),
.int_z  (int_z),
.cc_c (cc_c),
.cc_z (cc_z)
);

dmem dmem (
.ck (ck),
.res  (res),
.ck2 (ck2),
.kind (kind),
.fn2  (fn2),
.rd1 (rd1),
.disp (disp),
.store_d (store_d),
.load_d  (load_d)
);

stack stack (
.ck (ck),
.res  (res),
.ck2 (ck2),
.kind (kind),
.one_addr (one_addr),
.stack_d  (stack_d),
.sp (sp)
);

endmodule
