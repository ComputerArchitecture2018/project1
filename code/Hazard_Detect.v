module Hazard_Detect(
	ID_EX_M,
	write_addr,
	read_addr,
	IF_Op,
	Pc_Op,
	Mux_Op
);
input ID_EX_M;
input [4:0] write_addr,read_addr;
output IF_Op,Pc_Op,Mux_Op;

assign IF_Op = (ID_EX_M == 1 and write_addr == read_addr )?1:0;
assign Pc_Op = (ID_EX_M == 1 and write_addr == read_addr )?1:0;
assign Mux_Op = (ID_EX_M == 1 and write_addr == read_addr )?1:0;
endmodule