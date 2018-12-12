module Signal_Control
(
    Op_i,
    ALUSrc_o,
    ResultSrc_o,
    RegWrite_o,
    ALUOp_o,
    MemWrite_o,
    Branch_o
);

input [6:0] Op_i;

output reg ALUSrc_o;
output reg ResultSrc_o;
output reg RegWrite_o;
output reg [1:0] ALUOp_o;
output reg MemWrite_o;
output reg Branch_o;

wire [2:0] det;
assign det = Op_i[6:4];

always@(det) begin
	case(det)
		3'b011: /* R-type */
			begin
			ALUSrc_o = 1'b0;
			ResultSrc_o = 1'b0;
			RegWrite_o = 1'b1;
			ALUOp_o = 2'b10;
			MemWrite_o = 1'b0;
			Branch_o = 1'b0;
			end
		3'b001: /* addi */
			begin
			ALUSrc_o = 1'b1;
			ResultSrc_o = 1'b0;
			RegWrite_o = 1'b1;
			ALUOp_o = 2'b00;
			MemWrite_o = 1'b0;
			Branch_o = 1'b0;
			end
		3'b000: /* lw */
			begin
			ALUSrc_o = 1'b1;
			ResultSrc_o = 1'b1;
			RegWrite_o = 1'b1;
			ALUOp_o = 2'b00;
			MemWrite_o = 1'b0;
			Branch_o = 1'b0;
			end
		3'b010: /* sw */
			begin
			ALUSrc_o = 1'b1;
			ResultSrc_o = 1'bX;
			RegWrite_o = 1'b0;
			ALUOp_o = 2'b00;
			MemWrite_o = 1'b1;
			Branch_o = 1'b0;
			end
		3'b110: /* beq */
			begin
			ALUSrc_o = 1'b0;
			ResultSrc_o = 1'bX;
			RegWrite_o = 1'b0;
			ALUOp_o = 2'b01;
			MemWrite_o = 1'b0;
			Branch_o = 1'b1;
			end
	endcase
end
endmodule
