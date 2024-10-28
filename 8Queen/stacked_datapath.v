module stacked_datapath (
    clk,
    reset,

    // Controller-outputs
    enable_output,
    register_load,
    count,
    load_counter,
    push,
    pop,
    increament_row,
    increament_column,

    // Controller-inputs
    cout,
    down_counter_zero,
    last_column,
    safe,
    stack_ready,
    underflow,

    // Outputs
    ready, 
    done
);
    input clk, reset;
    input 
        enable_output,
        register_load,
        count,
        load_counter,
        push,
        pop,
        increament_row,
        increament_column;

    output
        cout,
        down_counter_zero,
        last_column,
        safe,
        stack_ready,
        underflow,
        ready,
        done;

    wire [0:7] register_loads;
    wire [7:0] register_outputs [0:7];
    
    wire [2:0] last_queen_row;
    wire [7:0] last_queen_row_data;
    wire [2:0] last_queen_column;
 
    wire [2:0] other_queen_row;
    wire [2:0] other_queen_column;
    wire [7:0] other_queen_row_data;
    wire [2:0] other_queen_counter_data;
    
    wire [5:0] last_queen_position; // [5:3] row, [2:0] col
    wire [5:0] stack_top;
    assign last_queen_row = stack_top[2:0];
    assign last_queen_column = stack_top[5:3];
    wire [5:0] last_queen_updated_position;


    decoder row_decoder (
        .enable(register_load),
        .binary(last_queen_row),
        .out(register_loads)
    );
    
    decoder column_decoder (
        .enable(1'b1),
        .binary(last_queen_column),
        .out(last_queen_row_data)
    );

    multiplexer other_queen_mux (
        .select(other_queen_row),
        .inputs(register_outputs),
        .out(other_queen_row_data)
    );

    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin
            register r (
                .clk(clk),
                .reset(reset),
                .load(register_loads[i]),
                .bus_in(last_queen_row_data),
                .bus_out(register_outputs)
            );
        end
    endgenerate

    onehot_to_position_decoder onehot_decoder (
        .onehot_row(other_queen_row_data),
        .column(other_queen_column)
    );

    stack last_queen_stack (
        .clk(clk),
        .reset(reset),
        .user_push(push),
        .bus_in(last_queen_position),
        .user_pop(pop),
        .overflow(),
        .underflow(underflow),
        .ready(stack_ready),
        .bus_out(stack_top)
    );

    increamenter row_increamenter (
        .enable_output(increament_row),
        .in(last_queen_row),
        .out(last_queen_updated_position[5:3]),
        .carry_out()
    );

    increamenter column_increamenter (
        .enable_output(increament_column),
        .in(last_queen_column),
        .out(last_queen_updated_position[2:0]),
        .carry_out(cout)
    );

    assign other_queen_counter_data = last_queen_row - 3'b001;
    counter #(3) other_queen_row_counter(
        .clk(clk),
        .reset(reset),
        .load(load_counter),
        .data(other_queen_counter_data),
        .count_up(),
        .count_down(count),
        .zero(down_counter_zero),
        .msb(),
        .value(other_queen_row)
    );

    is_safe is_safe_instance (
        .row1(last_queen_row),
        .column1(last_queen_column),
        .row2(other_queen_row),
        .column2(other_queen_column),
        .safe(safe)
    );

    assign last_column = &last_queen_column;
endmodule