module Buf_IF_ID(
	clk_i,
	rs1_data_i,
	rs2_data_i,
	imm_i,
	rs1_i,
	rs2_i,
	rsd_i,
	WB_i,
	M_i,
	EX_i,
	rs1_data_o,
	rs2_data_o,
	imm_o,
	rs1_o,
	rs2_o,
	rsd_o,
	WB_o,
	M_o,
	EX_o
);
input clk_i;
input[31:0]rs1_data_i,rs2_data_i,imm_i;
output[31:0]rs1_data_o,rs2_data_o,imm_o;
input[4:0]rs1_i,rs2_i,rsd_i;
output[4:0]rs1_o,rs2_o,rsd_o;
input WB_i,M_i,EX_i;
output WB_o,M_o,EX_o;

reg[31:0]rs1_data_reg_i,rs2_data_reg_i,imm_reg_i;
reg[31:0]rs1_data_reg_o,rs2_data_reg_o,imm_reg_o;
reg[4:0]rs1_reg_i,rs2_reg_i,rsd_reg_i;
reg[4:0]rs1_reg_o,rs2_reg_o,rsd_reg_o;
reg WB_reg_i,M_reg_i,EX_reg_i;
reg WB_reg_o,M_reg_o,EX_reg_o;
assign rs1_data_o=rs1_data_reg_o;
assign rs2_data_o=rs2_data_reg_o;
assign imm_o=imm_reg_o;
assign rs1_o=rs1_reg_o;
assign rs2_o=rs2_reg_o;
assign rsd_o=rsd_reg_o;
assign WB_o=WB_reg_o;
assign M_o=M_reg_o;
assign EX_o=EX_reg_o;
always @(posedge clk) begin
	rs1_data_reg_i<=rs1_data_i;
	rs2_data_reg_i<=rs2_data_i;
	imm_reg_i<=imm_i;
	rs1_reg_i<=rs1_i;
	rs2_reg_i<=rs2_i;
	rsd_reg_i<=rsd_i;
	WB_reg_i<=WB_i;
	M_reg_i<=M_i;
	EX_reg_i<=EX_i;
end
always @(negedge clk) begin
	rs1_data_reg_o<=rs1_data_reg_i;
	rs2_data_reg_o<=rs2_data_reg_i;
	imm_reg_o<=imm_reg_i;
	rs1_reg_o<=rs1_reg_i;
	rs2_reg_o<=rs2_reg_i;
	rsd_reg_o<=rsd_reg_i;
	WB_reg_o<=WB_reg_i;
	M_reg_o<=M_reg_i;
	EX_reg_o<=EX_reg_i;
end
endmodule
