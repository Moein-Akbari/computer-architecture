main:
    addi s0, zero, A
    lw s0, 0(s0)
    addi s2, zero, 0
loop:
    slti t0, s2, 