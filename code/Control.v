module Control(Op_i,RegDst_o,ALUOp_o,ALUSrc_o,RegWrite_o);
input[6:0]Op_i;
output[0:0]RegDst_o,ALUSrc_o,RegWrite_o;
output[1:0]ALUOp_o;
assign ALUSrc_o=~Op_i[5];//0: register, 1: imm
assign RegWrite_o=1'b1;
assign ALUOp_o=Op_i[6:5];
endmodule
