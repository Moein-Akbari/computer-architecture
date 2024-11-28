module rom (
    address,
    data
);
    parameter SIZE = 512;
    parameter WORD_SIZE = 32;
    
    input [31:0] address;
    output [WORD_SIZE-1:0] data;
    
    reg [WORD_SIZE-1:0] rom_data [0:SIZE-1]; //TODO: Probable issue
    assign data = rom_data[address];

    initial begin
        $readmemb("instructions.txt", rom_data);
    end
endmodule