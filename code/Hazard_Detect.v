module Hazard_Detect(
	ID_EX_M,
	reg1_addr,
	reg2_addr,
	regd_addr,
	IF_Op,
	Valid
);
input [2:0]ID_EX_M;
input [4:0] reg1_addr,reg2_addr,regd_addr;
output IF_Op,Valid;

assign IF_Op = (ID_EX_M == 3'b000 && (reg1_addr == regd_addr || reg2_addr == regd_addr) )?1:0;
assign Valid = (ID_EX_M == 3'b000 && (reg1_addr == regd_addr || reg2_addr == regd_addr) )?0:1;
endmodule
