module ImmGen(inst_i,imm_o);
input[31:0]inst_i;
output[11:0]imm_o;
assign imm_o=({inst_i[6:0]}==7'b1100011)?
				{{inst_i[31]}/*12*/,{inst_i[7]}/*11*/,{inst_i[30:25]}/*10:5*/,{inst_i[11:8]}/*4:1*/}://SB type
			 ({inst_i[6:0]}==7'b0100011)?
				{{inst_i[31:25]},{inst_i[11:7]}}://S type
				{inst_i[31:20]};//I type
endmodule
