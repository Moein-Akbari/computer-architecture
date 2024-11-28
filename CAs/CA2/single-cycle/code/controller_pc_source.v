module controller_pc_source (
    branch,
    jump,
    zero,
    f3,
    pc_src
);
    input branch, jump, zero;
    input [2:0] f3;
    output pc_src;
    
    wire neq;
    assign neq = (f3 == 3'b001);

    assign pc_src = jump | (branch & (neq ^ zero));
endmodule