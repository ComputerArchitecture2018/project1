module Shift_Left(
	data_in,
	data_o
);
input [31:0] data_in;
output [31:0] data_o;
assign data_o = data_in<<1;

endmodule