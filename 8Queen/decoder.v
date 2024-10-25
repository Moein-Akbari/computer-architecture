module decoder (
    enable,
    binary,
    out
);
    input enable;
    input [2:0] binary;
    output reg [0:7] out;

    always @(binary or enable) begin
        if (~enable) begin
            out = 8'b00000000;
        end
        else begin
            case (binary)
                3'd0: out = 8'b10000000;
                3'd1: out = 8'b01000000;
                3'd2: out = 8'b00100000;
                3'd3: out = 8'b00010000;
                3'd4: out = 8'b00001000;
                3'd5: out = 8'b00000100;
                3'd6: out = 8'b00000010;
                3'd7: out = 8'b00000001;
            endcase
        end
    end

endmodule