module decoder (
    enable,
    binary,
    out
);
    input enable;
    input [2:0] binary;
    output reg out [0:7];

    always @(binary or enable) begin
        if (~enable) begin
            out = 8'b00000000;
        end
        else begin
            case (binary)
                3'd0: out = {1, 0, 0, 0, 0, 0, 0, 0};
                3'd1: out = {0, 1, 0, 0, 0, 0, 0, 0};
                3'd2: out = {0, 0, 1, 0, 0, 0, 0, 0};
                3'd3: out = {0, 0, 0, 1, 0, 0, 0, 0};
                3'd4: out = {0, 0, 0, 0, 1, 0, 0, 0};
                3'd5: out = {0, 0, 0, 0, 0, 1, 0, 0};
                3'd6: out = {0, 0, 0, 0, 0, 0, 1, 0};
                3'd7: out = {0, 0, 0, 0, 0, 0, 0, 1};
            endcase
        end
    end

endmodule