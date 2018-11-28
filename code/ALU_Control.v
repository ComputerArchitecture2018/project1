module ALU_Control(funct_i,ALUOp_i,ALUCtrl_o);
input[1:0]ALUOp_i;
input[4:0]funct_i;
output[2:0]ALUCtrl_o;//and, or, add, sub, mul
reg[2:0]out;
assign ALUCtrl_o=out;
/*(funct_i==4'b0111)? 3'b001://and
				 (funct_i==4'b0110)? 3'b010://or
				 (funct_i==4'b0000 ?
			     (ALUOp_i==2'b00 ? 3'b011: 3'b101)://add, mul
				 (funct_i==4'b1000)? 3'b100://sub
				 3'b000;
*/

always@(*)
begin
		 if(funct_i==5'b00111)out=3'b001;//and
	else if(funct_i==5'b00110)out=3'b010;//or
	else if(funct_i==5'b00000)out=3'b011;//add
	else if(funct_i==5'b01000)out=3'b101;//mul
	else if(funct_i==5'b10000)out=3'b100;//sub
	else out=3'b000;
end
endmodule
