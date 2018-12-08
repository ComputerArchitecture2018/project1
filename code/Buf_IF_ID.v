module Buf_IF_ID(clk_i,pc_i,inst_i,IF_flush_i,pc_o,inst_o);
input[31:0]pc_i,inst_i;
input clk_i,IF_flush_i;
output[31:0]pc_o,inst_o;
reg[31:0]pc_reg_i,inst_reg_i;
reg[31:0]pc_reg_o,inst_reg_o;
assign pc_o=pc_reg_o;
assign inst_o=inst_reg_o;
always @(posedge clk_i) begin
	pc_reg_i<=(IF_flush_i==1'b1)?{{pc_i[31:7]},{7'b0000000}}:pc_i;
	inst_reg_i<=inst_i;
end
always @(negedge clk_i) begin
	pc_reg_o<=pc_reg_i;
	inst_reg_o<=inst_reg_i;
end
endmodule
