module Sign_Extend(data_i,data_o);
input[11:0]data_i;
output[31:0]data_o;
assign data_o={{21{data_i[11]}},{data_i[10:0]}};
endmodule
