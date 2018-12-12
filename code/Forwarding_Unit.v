module Forwarding_Unit(Rs1_i,Rs2_i,RegWrite_p_i,Rd_p_i,RegWrite_pp_i,Rd_pp_i,ForwardA_o,ForwardB_o);
input[4:0]Rs1_i,Rs2_i,Rd_p_i,Rd_pp_i;
input RegWrite_p_i,RegWrite_pp_i;
output[1:0]ForwardA_o,ForwardB_o;
assign ForwardA_o=(RegWrite_p_i==1'b1 && Rs1_i==Rd_p_i)? 2'b01:
				  (RegWrite_pp_i==1'b1 && Rs1_i==Rd_pp_i)? 2'b10:
				  2'b00;
assign ForwardB_o=(RegWrite_p_i==1'b1 && Rs2_i==Rd_p_i)? 2'b01:
				  (RegWrite_pp_i==1'b1 && Rs2_i==Rd_pp_i)? 2'b10:
				  2'b00;
endmodule
