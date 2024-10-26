module abs (
    value,
    number
);
    parameter N = 3;
    input signed [N-1:0] number;
    output [N-1:0] value;
    wire positivity;
    assign positivity = (number >= 0);
    assign value = positivity ? number : -number;
endmodule