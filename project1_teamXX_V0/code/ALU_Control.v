module ALU_Control(funct_i,ALUOp_i,ALUCtrl_o);
input[1:0]ALUOp_i;
input[4:0]funct_i;
output[2:0]ALUCtrl_o;//and, or, add, sub, mul

assign ALUCtrl_o=(ALUOp_i==2'b00)? 3'b011://add
				 (ALUOp_i==2'b01)? 3'b100://sub
				 (ALUOp_i==2'b10)?
				 (
				 	(funct_i==5'b00000)? 3'b011://add
					(funct_i==5'b10000)? 3'b100://sub
					(funct_i==5'b00111)? 3'b001://and
					(funct_i==5'b00110)? 3'b010://or
					(funct_i==5'b01000)? 3'b101://mul
					3'b000
				 ): 3'b000;
endmodule
