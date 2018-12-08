module Buf_IF_ID(
	clk_i,
	rs1_data_i,
	rs2_data_i,
	imm_i,
	rs1_i,
	rs2_i,
	rsd_i,
	Op_i,
	rs1_data_o,
	rs2_data_o,
	imm_o,
	rs1_o,
	rs2_o,
	rsd_o,
	Op_o,
);
input clk_i;
input[31:0]rs1_data_i,rs2_data_i,imm_i;
output[31:0]rs1_data_o,rs2_data_o,imm_o;
input[4:0]rs1_i,rs2_i,rsd_i;
output[4:0]rs1_o,rs2_o,rsd_o;
input Op_i;
output Op_o;

reg[31:0]rs1_data_reg_i,rs2_data_reg_i,imm_reg_i;
reg[31:0]rs1_data_reg_o,rs2_data_reg_o,imm_reg_o;
reg[4:0]rs1_reg_i,rs2_reg_i,rsd_reg_i;
reg[4:0]rs1_reg_o,rs2_reg_o,rsd_reg_o;
reg Op_reg_i;
reg Op_reg_o;
assign rs1_data_o=rs1_data_reg_o;
assign rs2_data_o=rs2_data_reg_o;
assign imm_o=imm_reg_o;
assign rs1_o=rs1_reg_o;
assign rs2_o=rs2_reg_o;
assign rsd_o=rsd_reg_o;
assign Op_o=Op_reg_o;
always @(posedge clk_i) begin
	rs1_data_reg_i<=rs1_data_i;
	rs2_data_reg_i<=rs2_data_i;
	imm_reg_i<=imm_i;
	rs1_reg_i<=rs1_i;
	rs2_reg_i<=rs2_i;
	rsd_reg_i<=rsd_i;
	Op_reg_i<=Op_i;
end
always @(negedge clk_i) begin
	rs1_data_reg_o<=rs1_data_reg_i;
	rs2_data_reg_o<=rs2_data_reg_i;
	imm_reg_o<=imm_reg_i;
	rs1_reg_o<=rs1_reg_i;
	rs2_reg_o<=rs2_reg_i;
	rsd_reg_o<=rsd_reg_i;
	Op_reg_o<=Op_reg_i;
end
endmodule
