module is_safe (
    row1, column1, row2, column2,
    safe
);
    input [2:0] row1, column1, row2, column2;
    output safe;
    
    assign safe = ~(row1 == row2 || column1 == column2 || 
endmodule