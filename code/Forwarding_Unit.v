module Forwarding_Unit(Rs1_i,Rs2_i,Rdp_i,Rdpp_i,ForwardA_o,ForwardB_o);
input[4:0]Rs1_i,Rs2_i,Rdp_i,Rdpp_i;
output[1:0]ForwardA_o,ForwardB_o;
assign ForwardA_o=(Rs1_i==Rdp_i)? 2'b10:
				  (Rs1_i==Rdpp_i)? 2'b01:
				  2'b00;
assign ForwardB_o=(Rs2_i==Rdp_i)? 2'b10:
				  (Rs2_i==Rdpp_i)? 2'b01:
				  2'b00;
endmodule
