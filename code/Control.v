module Control(
	inst,//input
	Beq,//input: Came from the wire from ID/EX
	flush_op,//output: go to IF/ID buffer
	Opcode,//output: go to ID/EX buffer
	Valid,//output: go to ID/EX buffer
	PC_MUX_op//output: go to PC Mux
);
input Beq;
input [31:0]inst;
output flush_op;
output [2:0]Opcode;
output Valid,PC_MUX_op;
wire [6:0] Op;
assign flush_op = (Beq == 1)?1:0;
assign PC_MUX_op = (Beq == 1)?1:0;
assign Op = inst[6:0];

assign Opcode = inst[6:4];

assign Valid = (Op == 7'b0110011 || Op == 7'b0010011 || Op == 7'b0100011 || Op == 7'b0000011 || Op == 7'b1100011)? 1:0;

endmodule
