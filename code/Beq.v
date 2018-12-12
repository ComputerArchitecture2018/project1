module Beq(
	data1_i,//from register
	data2_i,//from register
	Beq_Op, // if this is a beq instruction, I assume it's exist, but I'm not sure where did it came from
	Beq //connect to the ID/EX
);
input [31:0] data1_i, data2_i;
input [6:0]Beq_Op;
output Beq;

assign Beq = (Beq_Op[6] == 1 && data1_i == data2_i)?1:0;
endmodule
