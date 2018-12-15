module Buf_IF_ID(clk_i,rst_i,pc_i,inst_i,IF_stall_i,IF_flush_i,pc_o,inst_o);
input[31:0]pc_i,inst_i;
input clk_i,rst_i,IF_stall_i,IF_flush_i;
output[31:0]pc_o,inst_o;
reg[31:0]pc_reg_i,inst_reg_i;
reg[31:0]pc_reg_o,inst_reg_o;
assign pc_o=pc_reg_o;
assign inst_o=inst_reg_o;
always @(posedge clk_i or negedge rst_i) begin
	if(rst_i==0 || IF_flush_i==1'b1)begin
		pc_reg_i<=0;
		inst_reg_i<=0;
	end
	else if(~IF_stall_i) begin
		pc_reg_i<=pc_i;
		inst_reg_i<=inst_i;
	end
end
always @(negedge clk_i or negedge rst_i) begin
	pc_reg_o<=rst_i==0?0:pc_reg_i;
	inst_reg_o<=rst_i==0?0:inst_reg_i;
end
endmodule
