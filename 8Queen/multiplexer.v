module multiplexer (
    select,
    inputs,
    out
);
    input [2:0] select;
    input [7:0] inputs [0:7];
    output [7:0] out;

    assign out = inputs[select];
endmodule