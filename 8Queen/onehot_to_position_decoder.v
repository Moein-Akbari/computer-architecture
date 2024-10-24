module onehot_to_position_decoder (
    onehot_row,
    column
);
    input [0:7] onehot_row;
    output reg [0:2] column;

    always @(onehot_row) begin
        casex (onehot_row)
            7'b1xxxxxxx: column = 0;
            7'b01xxxxxx: column = 1;
            7'b001xxxxx: column = 2;
            7'b0001xxxx: column = 3;
            7'b00001xxx: column = 4;
            7'b000001xx: column = 5;
            7'b0000001x: column = 6;
            7'b00000001: column = 7;
            default: column = x;
        endcase
    end
    
endmodule