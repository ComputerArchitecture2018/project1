module Forwarding_Unit(Rs1_i,Rs2_i,RegWrite_p_i,Rd_p_i,RegWrite_pp_i,Rd_pp_i,ForwardA_o,ForwardB_o);
input[4:0]Rs1_i,Rs2_i,Rd_p_i,Rd_pp_i;
input RegWrite_p_i,RegWrite_pp_i;
output[1:0]ForwardA_o,ForwardB_o;
assign ForwardA_o=(RegWrite_p_i==1'b1 and Rs1_i==Rdp_i)? 2'b10:
				  (RegWrite_pp_i==1'b1 and Rs1_i==Rdpp_i)? 2'b01:
				  2'b00;
assign ForwardB_o=(RegWrite_p_i==1'b1 and Rs2_i==Rdp_i)? 2'b10:
				  (RegWrite_pp_i==1'b1 and Rs2_i==Rdpp_i)? 2'b01:
				  2'b00;
endmodule
