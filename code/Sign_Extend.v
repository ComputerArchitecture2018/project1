module Sign_Extend(data_i,data_o);
input[11:0]data_i;
output[31:0]data_o;
assign data_o={{21{data_i[11]}},{data_i[10:0]}};
/*always@(*)
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
end*/
endmodule
