module stack_controller (
    clk,
    reset,

    user_push,
    user_pop,

    msb,
    zero,
    
    ready,
    push,
    pop,
    overflow,
    underflow
);
    localparam 
        IDLE = 3'd0,
        PUSH = 3'd1,
        POP = 3'd2,
        OVERFLOW = 3'd3,
        UNDERFLOW = 3'd4;

    reg [2:0] next_state, present_state;
    
    input clk, reset, msb, zero, user_push, user_pop;
    output reg ready, push, pop, overflow, underflow;


    always

endmodule