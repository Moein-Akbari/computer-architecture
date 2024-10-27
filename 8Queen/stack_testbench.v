module stack_testbench();
    reg clk, reset, user_push, user_pop;
    reg [5:0] bus_in;
    
    wire [5:0] bus_out;
    wire overflow, underflow, ready;

    stack #(8,6) my_stack(
        .clk(clk),
        .reset(reset),
        .user_push(user_push),
        .bus_in(bus_in),
        .user_pop(user_pop),
        .overflow(overflow),
        .underflow(underflow),
        .ready(ready),
        .bus_out(bus_out)
    );

    initial begin
        clk = 1;
        forever #(10 / 2) clk = ~clk;
    end

    initial begin
        reset = 1;
        #20 reset = 0;
        
        bus_in = {3'd0, 3'd0};
        user_push = 1;
        #8 user_push = 0;
        #10
        bus_in = {3'd1, 3'd6};
        user_push = 1;
        #10 user_push = 0;
    end
endmodule