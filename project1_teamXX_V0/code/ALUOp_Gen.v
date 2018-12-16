module ALUOp_Gen(
	opcode_i,
	ALU_Op_o
);
input [2:0] opcode_i;
output [1:0] ALU_Op_o;
assign ALU_Op_o=(opcode_i==3'b011)? 2'b10:
				(opcode_i==3'b110)? 2'b01:
				2'b00;
endmodule
