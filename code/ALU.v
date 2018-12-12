module ALU(data1_i,data2_i,ALUCtrl_i,data_o,Zero_o);
input[31:0]data1_i,data2_i;
input[2:0]ALUCtrl_i;
output[31:0]data_o;
output[31:0]Zero_o;
assign Zero_o=32'b0;
assign data_o=(ALUCtrl_i==3'b001)?data1_i&data2_i:
			  (ALUCtrl_i==3'b010)?data1_i|data2_i:
			  (ALUCtrl_i==3'b011)?data1_i+data2_i:
			  (ALUCtrl_i==3'b100)?data1_i-data2_i:
			  (ALUCtrl_i==3'b101)?data1_i*data2_i:
			  (ALUCtrl_i==3'b110)?data1_i:
			  Zero_o;
endmodule
