module pc(ck, res, ck2, next_addr, cur_addr);
input	  wire				 ck;
input   wire         res;
input   wire         ck2;
input	  wire [11:0]  next_addr;
output	reg  [11:0]	 cur_addr;

always @(posedge ck or negedge res) begin
	if (res==1'b0) begin
		cur_addr = 0;
  end
	else if (ck2==1'b0) begin
		cur_addr = next_addr;
	end
end

endmodule
