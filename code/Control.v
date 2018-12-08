module Control(
	inst,
	flush_op,
	Beq,//Came from the wire from ID/EX
	Opcode,
	EX,
	Valid,
	select,
	PC_MUX_op
);
input Beq;
input [31:0]inst;
reg [2:0] func;
reg [6:0] Op;
output flush_op,select;
output [2:0]EX,Opcode;
output Valid,PC_MUX_op;
assign data_flush = (Beq == 1)?1:0;
assign PC_MUX_op = (Beq == 1)?1:0;
assign func = [14:12]inst;
assign Op = [6:0]inst;

assign select = (inst[6] == 1)? 0://beq
			(inst[5] == 0 and inst[4] == 1)? 1://addi 
			(inst[5] == 0 and inst[4] == 0)? 1: //lw
			(inst[5] == 1 and inst[4] == 0) ? 1://sw
			(func == 3'b000 and inst[30] == 1)? 0://sub
			(func == 3'b000 and inst[25] == 1)? 0://mul
			(func == 3'b000)? 0://add
			(func == 3'b111)? 0://and
			(func == 3'b110)? 0;//or
assign EX = (inst[6] == 1)? 3'b110://beq
			(inst[5] == 0 and inst[4] == 1)? 3'b011://addi 
			(inst[5] == 0 and inst[4] == 0)? 3'b000: //lw
			(inst[5] == 1 and inst[4] == 0) ? 3'b111://sw
			(func == 3'b000 and inst[30] == 1)? 3'b100://sub
			(func == 3'b000 and inst[25] == 1)? 3'b101://mul
			(func == 3'b000)? 3'b011://add
			(func == 3'b111)? 3'b001://and
			(func == 3'b110)? 3'b010;//or
assign Opcode = [6:4]inst;

assign Valid = (Op == 7'b0110011 or Op == 7'b0010011 or Op == 7'b0100011 or Op == 7'b0000011 or Op == 7'b1100011)? 1:0;

endmodule
