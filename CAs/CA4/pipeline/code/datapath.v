module datapath (
    clk, 
    reset,

    // Datapath inputs
    clear,
    stallF,
    
    FlushD,
    StallD,

    PCSrcE,

);
    input clk, reset;
    input clear, stallF; 
    input PCSrcE;

    // Fetch:
    wire [31:0] pc_source_mux_inputs [0:1]
    wire [31:0] PCPlus4F;
    wire [31:0] PCTargetE;
    assign pc_source_mux_inputs[0] = PCPlus4F;
    assign pc_source_mux_inputs[1] = PCTargetE; 
    
    wire [31:0] PCF_in, PCF;

    multiplexer pc_source_mux (
        .select(PCSrcE),
        .inputs(pc_source_mux_inputs),
        .out(PCF_in)
    );

    controlled_register pc (
        .clk(clk), 
        .reset(reset),
        .clear(clear),
        .data_in(PCF_in),
        .data_out(PCF),
        .enable(stallF)
    );

    wire [31:0] instructionF;
    rom instruction_memory (
        .address(PCF),
        .data(instructionF) 
    );

    adder pc_incrementor (
        .n1(PCF), 
        .n2(32'd4),
        .result(PCPlus4F),
        .carry_out()
    );
    
    // Decode
    wire [31:0] instructionD;
    controlled_register DReg_instruction (
        .clk(clk), 
        .reset(reset),
        .clear(FlushD),
        .data_in(instructionF),
        .data_out(instructionD),
        .enable(StallD)
    );

    wire [31:0] PCD;
    controlled_register DReg_PC (
        .clk(clk), 
        .reset(reset),
        .clear(FlushD),
        .data_in(PCF),
        .data_out(PCD),
        .enable(StallD)
    );

    wire [31:0] PCPlus4D;
    controlled_register DReg_PCPlus4D (
        .clk(clk), 
        .reset(reset),
        .clear(FlushD),
        .data_in(PCPlus4F),
        .data_out(PCPlus4D),
        .enable(StallD)
    );

    wire []
    register_file rf (
        .clk(clk),
        .reset(reset),
        .reg1_address(reg1_address),
        .reg2_address(reg2_address),
        .write_reg_address(write_reg_address),
        .write_data(write_data),
        .reg_write(reg_write),
        .reg1_data(reg1_data),
        .reg2_data(reg2_data)   
    );
endmodule
