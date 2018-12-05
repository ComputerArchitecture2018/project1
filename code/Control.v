module Control(
	data_flush,
	Beq,//Came from the wire from ID/EX
	Mux_op
);
input Beq;
output data_flush;
output Mux_op;

assign data_flush = (Beq == 1)?1:0;
assign Mux_op = (Beq == 1)?1:0;

endmodule
