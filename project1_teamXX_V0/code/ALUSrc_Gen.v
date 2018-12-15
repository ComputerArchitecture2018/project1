module ALUSrc_Gen(
	opcode_i,
	ALUSrc_o
);
input [2:0] opcode_i;
output ALUSrc_o;
assign ALUSrc_o=(opcode_i==3'b001||
				 opcode_i==3'b000||
			 	 opcode_i==3'b010)? 1'b1:
				1'b0;
endmodule
