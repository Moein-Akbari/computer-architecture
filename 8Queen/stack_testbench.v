module stack_testbench();
    reg clk, reset, push, pop;
    reg [5:0] in_data;
    wire [5:0] out_data;

    stack #(8,6) my_stack(
        clk,
        reset,
        push,
        in_data,
        pop,
        out_data
    );

    initial begin
        clk = 1;
        forever #(10 / 2) clk = ~clk;
    end

    initial begin
        reset = 1;
        #20 reset = 0;
        
        in_data = {3'd0, 3'd0};
        push = 1;
        #8 push = 0;
        #10
        in_data = {3'd1, 3'd6};
        push = 1;
        #8 push = 0;
    end
endmodule