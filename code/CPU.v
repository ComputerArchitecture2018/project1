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
wire IF_flush_signal;
wire ID_beq_result;
wire[31:0]pc_input;
wire[31:0]alu_data2_EX;
wire[11:0]immgen_12bit_ID;
wire[2:0]alu_control_EX;
wire[1:0]alu_op_EX;

wire[31:0]inst_IF,inst_ID,inst_EX;
wire[31:0]pc_ID;
wire[31:0]rs1_data_ID,rs1_data_EX;
wire[31:0]rs2_data_ID,rs2_data_EX;
wire[31:0]imm_ID,imm_EX;
wire[31:0]alu_result_EX,alu_result_MEM,alu_result_WB;
wire[4:0]rs1_ID,rs1_EX;
wire[4:0]rs2_ID,rs2_EX,rs2_MEM;
wire[4:0]rsd_ID,rsd_EX,rsd_MEM;
wire[2:0]opcode_ID,opcode_EX,opcode_MEM,opcode_WB;
wire valid_ID,valid_EX,valid_MEM,valid_WB;
wire[31:0]memory_data_MEM,memory_data_WB;

Control Control(
	.inst       (inst_ID),
	.Beq        (ID_beq_result),
	.flush_op   (IF_flush_signal),
	.Opcode     (opcode_ID),
	.Valid      (valid_ID),
	.PC_MUX_op   (PC_Mux_select)
);

Buf_IF_ID Buffer_IF_ID(
	.clk_i(clk_i),
	.pc_i(inst_addr),
	.inst_i(inst_IF),
	.IF_flush_i(IF_flush_signal),
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

Buf_EX_MEM Buffer_EX_MEM(
	.clk_i(clk_i),
	.alu_result_i(alu_result_EX),
	.rs2_i(rs2_EX),
	.rsd_i(rsd_EX),
	.Op_i(opcode_EX),
	.valid_i(valid_EX),
	.alu_result_o(alu_result_MEM),
	.rs2_o(rs2_MEM),
	.rsd_o(rsd_MEM),
	.Op_o(opcode_MEM),
	.valid_o(valid_MEM)
);

Buf_MEM_WB Buffer_MEM_WB(
	.clk_i(clk_i),
	.alu_result_i(alu_result_MEM),
	.memory_data_i(memory_data_MEM),
	.Op_i(opcode_MEM),
	.valid_i(valid_MEM),
	.alu_result_o(alu_result_WB),
	.memory_data_o(memory_data_WB),
	.Op_o(opcode_WB),
	.valid_o(valid_WB)
);

Beq ID_Beq(
	.data1_i(rs1_data_ID),
	.data2_i(rs2_data_ID),
	.Beq_Op(),//TODO branch signal
	.Beq(ID_beq_result)
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
    .pc_i       (pc_input),
    .pc_o       (inst_addr)
);

MUX32 PC_Mux(
	.data1_i(next_inst_addr),
	.data2_i(),//TODO 阿加
	.select_i(PC_Mux_select),
	.data_o(pc_input)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (inst_addr), 
    .instr_o    (inst_IF)
);

Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (inst_ID[19:15]),
    .RTaddr_i   (inst_ID[24:20]),
    .RDaddr_i   (inst_ID[11:7]), 
    .RDdata_i   (alu_result_WB),
    .RegWrite_i (),//TODO signal from WB stage
    .RSdata_o   (rs1_data_ID), 
    .RTdata_o   (rs2_data_ID) 
);


MUX5 MUX_RegDst(
    .data1_i    (),
    .data2_i    (),
    .select_i   (),
    .data_o     ()
);



MUX32 MUX_ALUSrc(
    .data1_i    (rs2_data_EX),
    .data2_i    (imm_EX),
    .select_i   (),//TODO alusrc
    .data_o     (alu_data2_EX)
);

ImmGen ID_ImmGen(
	.inst_i(inst_ID),
	.imm_o(immgen_12bit_ID)
);

Sign_Extend Sign_Extend(
    .data_i     (immgen_12bit_ID),
    .data_o     (imm_ID)
);

wire[31:0]zero;

ALU ALU(
    .data1_i    (rs1_data_EX),
    .data2_i    (alu_data2_EX),
    .ALUCtrl_i  (alu_control_EX),
    .data_o     (alu_result_EX),
    .Zero_o     (zero)
);


ALU_Control ALU_Control(
    .funct_i    ({{inst_EX[30]},{inst_EX[25]},{inst_EX[14:12]}}),
    .ALUOp_i    (alu_op_EX),
    .ALUCtrl_o  (alu_control_EX)
);


endmodule

