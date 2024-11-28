module controller_alu (
    f3,
    f7,
    alu_op,
    alu_function
);
    input [2:0] f3;
    input [6:0] f7;
    input [1:0] alu_op;
    output [2:0] alu_function;

    always @(f3 or f7 or alu_op) begin
        case (alu_op)
            2'b00: alu_function = 3'b000;
            2'b01: alu_function = 3'b001;
            2'b11: case (f3)
                // ADDI
                3'b000: alu_function = 3'b000;
                // ANDI
                3'b111: alu_function = 3'b010;
                // ORI
                3'b110: alu_function = 3'b011;
                // 
                default: 
            endcase
            default: alu_function = 3'b000;
        endcase
    end
endmodule