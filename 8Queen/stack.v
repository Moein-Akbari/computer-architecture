module stack (
    clk,
    reset,
    push,
    in_data,
    pop,
    out_data
);
    parameter DEPTH = 8, SIZE = 6;
    input clk, reset, push, pop;
    input [SIZE-1:0] in_data;
    output reg [SIZE-1:0] out_data;
    
    reg [SIZE-1:0] memory [DEPTH-1:0];
    reg [$clog2(DEPTH):0] top_pointer;

    always @(posedge clk) begin
        if (reset) begin
            top_pointer <= {$clog2(DEPTH){1'b0}};
            out_data <= {SIZE{1'b0}};
        end
        else begin
            if (push) begin
                memory[top_pointer] <= in_data;
                top_pointer <= top_pointer + 1;
            end
            else if (pop) begin
                out_data <= memory[top_pointer];
                top_pointer <= top_pointer - 1;
            end
        end
    end    

endmodule