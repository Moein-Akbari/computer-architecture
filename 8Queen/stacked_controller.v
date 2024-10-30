module stacked_controller (
    clk,
    start,
    user_reset,

    // Datapath-outputs
    cout,
    down_counter_zero,
    last_column,
    row_zero,
    safe,
    stack_ready,
    underflow,

    // Datapath-inputs
    reset,
    enable_output,
    register_load,
    count,
    load_counter,
    push,
    pop,
    increament_row,
    increament_column,
    load_updated_position,

    // Outputs
    ready,
    no_answer,
    done
);
    localparam
        IDLE = 4'd0,
        RESET = 4'd1,
        CHECK_FINISH = 4'd2,
        SAFETY_CHECK = 4'd3,
        PREVIOUS_QUEEN = 4'd4,
        NO_ANSWER = 4'd5,
        WAIT_FOR_PUSH = 4'd6,
        NEXT_ROW = 4'd7,
        DONE = 4'd8,
        BACK_TRACK = 4'd9,
        COLUMN_INCREASE = 4'd10,
        EMPTY_STACK = 4'd11,
        POP = 4'd12,
        WAIT_FOR_POP = 4'd13,
        PUSH = 4'd14;


    input 
        clk,
        start,
        user_reset,
        cout,
        down_counter_zero,
        last_column,
        row_zero,
        safe,
        stack_ready,
        underflow;
    
    output reg
        reset,
        enable_output,
        register_load,
        count,
        load_counter,
        push,
        pop,
        increament_row,
        increament_column,
        load_updated_position,
        
        // Outputs
        ready,
        no_answer,
        done;


    reg [3:0] present_state;
    reg [3:0] next_state;

    always @(posedge clk) begin
        if (user_reset)
            present_state <= IDLE;
        else
            present_state <= next_state;
    end

    always @(
        start
        or row_zero or
        cout
        or safe or
        down_counter_zero
        or last_column or
        stack_ready 
        or underflow or
        present_state
    ) begin
        case (present_state)
            IDLE: next_state = start ? RESET : IDLE;
            RESET: next_state = CHECK_FINISH;
            CHECK_FINISH: next_state = 
                (~row_zero && ~cout) ? SAFETY_CHECK : 
                (row_zero && ~cout)  ? NEXT_ROW :
                (~row_zero && cout)  ? DONE :
                NO_ANSWER;
            SAFETY_CHECK: next_state =
                (safe && ~down_counter_zero) ? PREVIOUS_QUEEN :
                (safe && down_counter_zero) ? NEXT_ROW :
                (~safe && last_column) ? BACK_TRACK :
                COLUMN_INCREASE;
            PREVIOUS_QUEEN: next_state = SAFETY_CHECK;
            NO_ANSWER: next_state = IDLE;
            WAIT_FOR_PUSH: next_state = stack_ready ? CHECK_FINISH : WAIT_FOR_PUSH;
            NEXT_ROW: next_state = WAIT_FOR_PUSH;
            DONE: next_state = EMPTY_STACK;
            BACK_TRACK: next_state = last_column ? POP : COLUMN_INCREASE;
            COLUMN_INCREASE: next_state = WAIT_FOR_POP; // TODO: Probably fails
            EMPTY_STACK: next_state = underflow ? IDLE : EMPTY_STACK;
            POP: next_state = stack_ready ? BACK_TRACK : POP;
            WAIT_FOR_POP: next_state = stack_ready ? PUSH : WAIT_FOR_POP;
            PUSH: next_state = WAIT_FOR_PUSH;
            default: next_state = IDLE;
        endcase
    end

    always @(
        start
        or row_zero or
        cout
        or safe or
        down_counter_zero
        or last_column or
        stack_ready 
        or underflow or
        present_state
    ) begin
        reset = 1'b0;
        enable_output = 1'b0;
        register_load = 1'b0;
        count = 1'b0;
        load_counter = 1'b0;
        push = 1'b0;
        pop = 1'b0;
        increament_row = 1'b0;
        increament_column = 1'b0;
        
        case (present_state)
            IDLE: ready = 1'b1;
            RESET: reset = 1'b1;
            CHECK_FINISH: load_counter = 1'b1;
            SAFETY_CHECK: ;
            PREVIOUS_QUEEN: count = 1'b1;
            NO_ANSWER: no_answer = 1'b1;
            WAIT_FOR_PUSH: ;
            NEXT_ROW: {increament_row, push, register_load, load_updated_position} = 4'b1111; // TODO: Sus
            DONE: done = 1'b1;
            BACK_TRACK: ;
            COLUMN_INCREASE: {increament_column, pop, load_updated_position} = 3'b111;
            EMPTY_STACK: {enable_output, pop} = 2'b11;
            POP: pop = 1'b1;
            WAIT_FOR_POP: ;
        endcase
    end

endmodule