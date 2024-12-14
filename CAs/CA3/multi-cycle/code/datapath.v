module datapath (
    clk,
    reset,

    // Controller outputs
    adr_src,
    mem_write,
    ir_write,
    imm_src,
    alu_src_a,
    alu_src_b,
    alu_function,
    result_src,
    reg_write,
    pc_write,
    old_pc_write

    // Controller inputs
    opcode, f3, f7,
    zero
);
    input clk, reset;

    input adr_src;
    input mem_write, ir_write, reg_write, pc_write, old_pc_write;
    input [2:0] imm_src;
    input [31:0] alu_src_a, alu_src_b;
    input [2:0] alu_function;
    input [1:0] result_src
    
    controlled_register pc (
        .clk(clk), 
        .reset(reset),
        .data_in(data_in),
        .data_out(data_out),
        .enable(enable)
    );

    controlled_register old_pc (
        .clk(clk), 
        .reset(reset),
        .data_in(data_in),
        .data_out(data_out),
        .enable(enable)
    );
    
    multiplexer memory_src_mux (
        .select(),
        .inputs(),
        .out()
    );

    memory mem (
        .clk(clk),
        .reset(reset),
        .address(address),
        .write_data(write_data),
        .mem_write(mem_write),
        .read_data(read_data)
    );

    controlled_register ir (
        clk, 
        reset,
        data_in,
        data_out,
        enable
    );

    register mdr (
        clk, 
        reset,
        data_in,
        data_out
    );

    register_file rf (
        clk,
        reset,
        reg1_address,
        reg2_address,
        write_reg_address,
        write_data,
        reg_write,
        reg1_data,
        reg2_data
    );

    register A (
        clk, 
        reset,
        data_in,
        data_out
    );

    register B (
        clk, 
        reset,
        data_in,
        data_out
    );

    multiplexer #(3, 32) alu_src_a_mux (
        select,
        inputs,
        out
    );

    multiplexer #(3, 32) alu_src_b_mux (
        select,
        inputs,
        out
    );

    immediate_extender ie (
        .immediate_source(),
        .instruction(),
        .out()
    );

    alu alu_instance (
        .input_a(reg1_data),
        .input_b(alu_input_b),
        .alu_function(alu_function),
        .alu_output(alu_output), 
        .zero(zero)
    );

    register alu_out (
        clk, 
        reset,
        data_in,
        data_out
    );

    multiplexer #(2, 32) result_src_mux (

    );
endmodule