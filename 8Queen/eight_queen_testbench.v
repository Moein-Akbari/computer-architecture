module eight_queen_testbench ();
    reg clk,
        start, 
        reset;
    wire [7:0] out_bus;
    
    wire
        ready,
        done;

    eight_queen eq (
        .clk(clk),
        .start(start), 
        .reset(reset), 
        .ready(ready),
        .done(done),
        .out_bus(out_bus)
    );

    // Clock signal with 10ns period.
    initial begin
        clk = 1;
        forever #(10 / 2) clk = ~clk;
    end

    initial begin
        reset = 0;
        # 50;
        reset = 1;
        # 50;
        reset = 0;
        # 50;

        start = 1;
        #10000;
    end
endmodule