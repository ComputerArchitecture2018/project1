module Hazard_Detect(
	valid_i,
	ID_EX_M,
	reg1_addr,
	reg2_addr,
	regd_addr,
	IF_Op,
	Valid
);
input valid_i;
input [2:0]ID_EX_M;
input [4:0] reg1_addr,reg2_addr,regd_addr;
output IF_Op,Valid;

assign IF_Op = (valid_i==1'b1 && ID_EX_M == 3'b000 && (reg1_addr == regd_addr || reg2_addr == regd_addr) )?1:0;
assign Valid = (valid_i==1'b1 && ID_EX_M == 3'b000 && (reg1_addr == regd_addr || reg2_addr == regd_addr) )?0:1;
endmodule
