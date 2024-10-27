module multiplexer (
    select,
    inputs,
    out
);
    parameter WIDTH = 3;
    input [WIDTH-1:0] select;
    input [(1<<WIDTH)-1:0] inputs [0:(1<<WIDTH)-1];
    output [(1<<WIDTH)-1:0] out;

    assign out = inputs[select];
endmodule