module Control(
	inst,//input
	Beq,//input: Came from the wire from ID/EX
	flush_op,//output: go to IF/ID buffer
	Opcode,//output: go to ID/EX buffer
	Valid,//output: go to ID/EX buffer
	//select,//output, alu source. 0: rs2, 1: imm
	PC_MUX_op//output: go to PC Mux
);
input Beq;
input [31:0]inst;
output flush_op;
output [2:0]Opcode;
output Valid,PC_MUX_op;
wire [2:0] func;
wire [2:0] Op;
wire select;
wire[2:0]EX;
assign data_flush = (Beq == 1)?1:0;
assign PC_MUX_op = (Beq == 1)?1:0;
assign func = inst[14:12];
assign Op = inst[6:4];

assign select = ({inst[6]} == 1'b1)? 1'b0://beq
			(inst[5] == 1'b0 && inst[4] == 1'b1)? 1'b1://addi 
			(inst[5] == 1'b0 && inst[4] == 1'b0)? 1'b1: //lw
			(inst[5] == 1'b1 && inst[4] == 1'b0) ? 1'b1://sw
			(func == 3'b000 && inst[30] == 1'b1)? 1'b0://sub
			(func == 3'b000 && inst[25] == 1'b1)? 1'b0://mul
			(func == 3'b000)? 1'b0://add
			(func == 3'b111)? 1'b0://and
			(func == 3'b110)? 1'b0://or
			1'b1;
assign EX = (inst[6] == 1)? 3'b110://beq
			(inst[5] == 0 && inst[4] == 1)? 3'b011://addi 
			(inst[5] == 0 && inst[4] == 0)? 3'b000: //lw
			(inst[5] == 1 && inst[4] == 0) ? 3'b111://sw
			(func == 3'b000 && inst[30] == 1)? 3'b100://sub
			(func == 3'b000 && inst[25] == 1)? 3'b101://mul
			(func == 3'b000)? 3'b011://add
			(func == 3'b111)? 3'b001://and
			(func == 3'b110)? 3'b010://or
			3'b000;
assign Opcode = inst[6:4];

assign Valid = (Op == 7'b0110011 || Op == 7'b0010011 || Op == 7'b0100011 || Op == 7'b0000011 || Op == 7'b1100011)? 1:0;

endmodule
