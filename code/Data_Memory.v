module Data_Memory
(
    addr_i,
	data_i,
	mem_write_i,
	mem_read_i,
	clk_i,
	data_o,
);

// Interface
input   [31:0]      addr_i;
input[31:0] data_i;
input mem_write_i,mem_read_i,clk_i;
output[31:0]data_o;

// Data memory
reg     [31:0]     memory  [0:255];


always @(posedge clk) begin
	if(mem_write_i==1'b1)begin
		memory[addr]<=data_i;
	end
	if(mem_read_i==1'b1)begin
		data_o<=memory[addr];
	end
end

endmodule
