module abs (
    value,
    number
);
    parameter N = 3;
    input [N-1:0] number;
    output [N-1:0] value;

    assign value = (number >= 0) ? number : -number;
endmodule