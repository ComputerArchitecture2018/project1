module Sign_Extend(data_i,data_o);
input[31:0]data_i;
output[31:0]data_o;
reg[31:0]out;
assign data_o=out;
always@(*)
begin
	if(data_i[31]==1'b0)
	begin
		out=data_i[31:20];
	end
	else
	begin
		out[31:11]=~21'b0;
		out[10:0]=data_i[30:20];
	end
end
endmodule
