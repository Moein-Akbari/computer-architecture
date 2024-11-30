module controller_main (
    opcode,

    // Datapath inputs
    reg_write,
    imm_src,
    alu_src,
    mem_write,
    result_src,

    // Other contollers inputs
    branch,
    alu_op,
    jump,
    jalr
);
    input [6:0] opcode;

    output reg reg_write;
    output reg [2:0] imm_src;
    output reg alu_src;
    output reg mem_write;
    output reg [1:0] result_src;

    output reg branch, jump, jalr;
    output reg [1:0] alu_op;

    always @(opcode) begin
        reg_write = 0;
        imm_src = 0;
        alu_src  = 0;
        mem_write = 0;
        result_src = 0;
        branch = 0;
        alu_op = 0;
        jump = 0;
        jalr = 0;
        
        case (opcode)
            // R-Type
            7'd51: begin
                reg_write = 1'b1;
                alu_src = 1'b0;
                mem_write = 1'b0;
                result_src = 2'b00;
                branch = 1'b0;
                alu_op = 2'b10;
                jump = 1'b0;
                jalr = 1'b0;
            end
            // I-Type(lw)
            7'd3: begin
                reg_write = 1'b1;
                imm_src = 3'b000;
                alu_src = 1'b1;
                mem_write = 1'b0;
                result_src = 2'b01;
                branch = 1'b0;
                alu_op = 2'b00;
                jump = 1'b0;
                jalr = 1'b0;
            end
            // I-Type
            7'd19: begin
                reg_write = 1'b1;
                imm_src = 3'b000;
                alu_src = 1'b1;
                mem_write = 1'b0;
                result_src = 2'b00;
                branch = 1'b0;
                alu_op = 2'b11;
                jump = 1'b0;
                jalr = 1'b0;
            end
            // S-Type (sw)
            7'd35: begin
                reg_write = 1'b0;
                imm_src = 3'b001;
                alu_src = 1'b1;
                mem_write = 1'b1;
                branch = 1'b0;
                alu_op = 2'b00;
                jump = 1'b0;
                jalr = 1'b0;
            end
            // J-Type
            7'd111: begin
                reg_write = 1'b1;
                imm_src = 3'b011;
                mem_write = 1'b0;
                result_src = 2'b10;
                branch = 1'b0;
                jump = 1'b1;
                jalr = 1'b0;
            end
            // B-Type
            7'd99: begin
                reg_write = 1'b0;
                imm_src = 3'b010;
                alu_src = 1'b0;
                mem_write = 1'b0;
                branch = 1'b1;
                jump = 1'b0;
                jalr = 1'b0;
            end
            // U-Type
            7'd55: begin
                reg_write = 1'b1;
                imm_src = 3'b100;
                mem_write = 1'b0;
                result_src = 2'b11;
                branch = 1'b0;
                jump = 1'b0;
                jalr = 1'b0;
            end
            // I-Type (jalr)
            7'd103: begin
                reg_write = 1'b1;
                imm_src = 3'b000;
                alu_src = 1'b1;
                mem_write = 1'b0;
                result_src = 2'b00;
                branch = 1'b0;
                alu_op = 2'b11;
                jump = 1'b0;
                jalr = 1'b1;
            end
        endcase
    end
endmodule