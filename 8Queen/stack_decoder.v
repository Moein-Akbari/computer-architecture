module stack_decoder (
    enable,
    binary,
    out
); // TODO: Move this to decoder
    parameter WIDTH = 2;
    input enable;
    input [WIDTH-1:0] binary;
    output reg [(1<<WIDTH) - 1:0] out; // 2^WIDTH
    
    always @(binary or enable) begin
        out = {(1<<WIDTH){1'b0}};
        if (enable)
            out[binary] = 1'b1;
    end
endmodule