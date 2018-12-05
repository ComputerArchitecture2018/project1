module Buf_IF_ID(pc_i,inst_i,IF_flush_i,pc_o,inst_o);
input[31:0]pc_i,inst_i;
input IF_flush_i; //TODO
reg[31:0]pc_reg_i,inst_reg_i;
reg[31:0]pc_reg_o,inst_reg_o;
assign pc_o=pc_reg;
assign inst_o=inst_reg;
always @(posedge clk) begin
	pc_reg_i<=pc_i;
	inst_reg_i<=inst_i;
end
always @(negedge clk) begin
	pc_reg_o<=pc_reg_i;
	inst_reg_o<=inst_reg_i;
end
endmodule
