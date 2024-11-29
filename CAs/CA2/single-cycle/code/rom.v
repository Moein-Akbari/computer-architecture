module rom (
    address,
    data
);
    parameter SIZE = 256;
    parameter WORD_SIZE = 32;
    
    input [31:0] address;
    output [WORD_SIZE-1:0] data;
    
    reg [WORD_SIZE-1:0] rom_data [0:SIZE-1]; //TODO: Probable issue

    initial begin
        $readmemh("instructions.hex", rom_data);
    end

    assign data = rom_data[(address >> 1)]; // TODO: Should we do same for main memory?
endmodule