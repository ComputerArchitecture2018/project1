module Data_Memory
(
	clk_i,
    addr_i,
	data_i,
	mem_write_i,
	data_o,
);

// Interface
input   [31:0]      addr_i;
input[31:0] data_i;
input mem_write_i,clk_i;
output[31:0]data_o;

// Data memory
reg     [31:0]     memory  [0:255];

assign data_o=memory[addr_i];

always @(posedge clk_i) begin
	if(mem_write_i==1'b1)begin
		memory[addr_i]<=data_i;
	end
end

endmodule
