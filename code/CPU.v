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

wire[31:0]inst_addr,inst;
wire[31:0]next_inst_addr;

Control Control(
    .Op_i       (inst[6:0]),
    .RegDst_o   (MUX_RegDst.select_i),
    .ALUOp_o    (ALU_Control.ALUOp_i),
    .ALUSrc_o   (MUX_ALUSrc.select_i),
    .RegWrite_o (Registers.RegWrite_i)
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
    .pc_i       (next_inst_addr),
    .pc_o       (inst_addr)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (PC.pc_o), 
    .instr_o    (inst)
);

Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (inst[19:15]),
    .RTaddr_i   (inst[24:20]),
    .RDaddr_i   (inst[11:7]), 
    .RDdata_i   (ALU.data_o),
    .RegWrite_i (Control.RegWrite_o), 
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
    .data1_i    (Registers.RTdata_o),
    .data2_i    (Sign_Extend.data_o),
    .select_i   (Control.ALUSrc_o),
    .data_o     (ALU.data2_i)
);



Sign_Extend Sign_Extend(
    .data_i     (inst[31:0]),
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

