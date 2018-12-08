module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;

wire[31:0]inst_addr;
wire[31:0]next_inst_addr;
wire PC_Mux_select;
wire[31:0]inst_IF,inst_ID;
wire[31:0]pc_ID;
wire[31:0]rs1_data_ID,rs1_data_EX;
wire[31:0]rs2_data_ID,rs2_data_EX;
wire[31:0]imm_ID,imm_EX;
wire[4:0]rs1_ID,rs1_EX;
wire[4:0]rs2_ID,rs2_EX;
wire[4:0]rsd_ID,rsd_EX;
wire[2:0]opcode_ID,opcode_EX,opcode_MEM;
wire valid_ID,valid_EX,valid_MEM;

Control Control(
	.inst       (inst_ID),
	.Beq        (ID_Beq.Beq),
	.flush_op   (Buffer_IF_ID.IF_flush_i),
	.Opcode     (opcode_ID),
	.Valid      (valid_ID),
	.PC_MUX_op   (PC_Mux_select)
);

Buf_IF_ID Buffer_IF_ID(
	.clk_i(clk_i),
	.pc_i(inst_addr),
	.inst_i(inst_IF),
	.IF_flush_i(Control.flush_op),
	.pc_o(pc_ID),
	.inst_o(inst_ID)
);

Buf_ID_EX Buffer_ID_EX(
	.clk_i(clk_i),
	.rs1_data_i(rs1_data_ID),
	.rs2_data_i(rs2_data_ID),
	.imm_i(imm_ID),
	.rs1_i(rs1_ID),
	.rs2_i(rs2_ID),
	.rsd_i(rsd_ID),
	.Op_i(opcode_ID),
	.valid_i(valid_ID),
	.rs1_data_o(rs1_data_EX),
	.rs2_data_o(rs2_data_EX),
	.imm_o(imm_EX),
	.rs1_o(rs1_EX),
	.rs2_o(rs2_EX),
	.Op_o(opcode_EX),
	.valid_o(valid_EX)
);

Beq ID_Beq(
	.data1_i(),//TODO
	.data2_i(),//TODO
	.Beq_Op(),//TODO
	.Beq(Control.Beq)
);

Adder Add_PC(
    .data1_in   (inst_addr),
    .data2_in   (32'd4),
    .data_o     (next_inst_addr)
);


PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (PC_Mux.data_o),
    .pc_o       (inst_addr)
);

MUX32 PC_Mux(
	.data1_i(next_inst_addr),
	.data2_i(),//TODO
	.select_i(PC_Mux_select),
	.data_o(PC.pc_i)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (PC.pc_o), 
    .instr_o    (inst_IF)
);

Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (inst_ID[19:15]),
    .RTaddr_i   (inst_ID[24:20]),
    .RDaddr_i   (inst_ID[11:7]), 
    .RDdata_i   (ALU.data_o),
    .RegWrite_i (),//TODO
    .RSdata_o   (ALU.data1_i), 
    .RTdata_o   (MUX_ALUSrc.data1_i) 
);


MUX5 MUX_RegDst(
    .data1_i    (),
    .data2_i    (),
    .select_i   (),
    .data_o     ()
);



MUX32 MUX_ALUSrc(
    .data1_i    (),//TODO rs2 data
    .data2_i    (),//TODO imm
    .select_i   (),//TODO
    .data_o     (ALU.data2_i)
);



Sign_Extend Sign_Extend(
    .data_i     (inst_ID[31:0]),
    .data_o     (MUX_ALUSrc.data2_i)
);

wire[31:0]zero;

ALU ALU(
    .data1_i    (Registers.RSdata_o),
    .data2_i    (MUX_ALUSrc.data_o),
    .ALUCtrl_i  (ALU_Control.ALUCtrl_o),
    .data_o     (Registers.RDdata_i),
    .Zero_o     (zero)
);

wire[4:0] alu_funct;
assign alu_funct[4]=inst[30];
assign alu_funct[3]=inst[25];
assign alu_funct[2]=inst[14];
assign alu_funct[1]=inst[13];
assign alu_funct[0]=inst[12];

ALU_Control ALU_Control(
    .funct_i    (alu_funct),
    .ALUOp_i    (Control.ALUOp_o),
    .ALUCtrl_o  (ALU.ALUCtrl_i)
);


endmodule

