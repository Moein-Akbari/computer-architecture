module controller (
    opcode,
    f3,
    f7
);
    input [6:0] opcode;
    input [14:12] f3;
    input [31:25] f7;


    // Decode
    wire RegWriteD;
    wire [1:0] ResultSrcD;
    wire MemWriteD;
    wire JumpD;
    wire BeqD;
    wire BneD;
    wire [2:0] ALUControlD;
    wire ALUSrcD;
    wire jalrD;
    wire [2:0] ImmSrcD;

    single_cycle_controller scc (
        .opcode(opcode),
        .f3(f3),
        .f7(f7),
        .imm_src(ImmSrcD),
        .reg_write(RegWriteD),
        .alu_src(ALUSrcD),
        .alu_function(ALUControlD),
        .mem_write(MemWriteD),
        .result_src(ResultSrcD),
        .beq(BeqD),
        .bne(BneD),
        .jump(JumpD),
        .jalr(jalrD)
    );

    // Execute

endmodule