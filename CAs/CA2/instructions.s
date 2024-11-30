addi x1, x0, 1337
addi x2, x0, 85
add x3, x1, x2

addi x4, x3, 1342
sub x4, x4, x3
sub x4, x4, x4

addi x5, x0, 49 # 110001
addi x6, x0, 20 # 010100

and  x7, x6, x5 # 010000 = 16
or x7, x6, x5   # 110101 = 53

andi x7, x6, 49 # 010000 = 16
ori x7, x6, 49  # 110101 = 53
xori x7, x6, 49 # 100101 = 37

lui x8, 524287 # 2**19-1

addi x8, x0, 123
slt x8, x5, x6
slt x8, x6, x5
slt x8, x6, x6

slti x8, x5, 20
slti x8, x6, 49
slti x8, x6, 20

# Storing x1 to x7 
addi x8, x0, 64
addi x9, x8, 0

sw x1, 0(x9)
addi x9, x9, 4
sw x2, 0(x9)
addi x9, x9, 4
sw x3, 0(x9)
addi x9, x9, 4
addi x9, x9, 4 # Just in case (idk)
sw x4, 0(x9)
addi x9, x9, 4
sw x5, 0(x9)
addi x9, x9, 4
sw x6, 0(x9)
addi x9, x9, 4
sw x7, 0(x9)
addi x9, x9, 4

# Setting x1 to x7 to 0
addi x1, x0, 0
addi x2, x0, 0
addi x3, x0, 0
addi x4, x0, 0
addi x5, x0, 0
addi x6, x0, 0
addi x7, x0, 0

# Loading values from memory to RF
addi x9, x9, -4
lw x7, 0(x9)
addi x9, x9, -4
lw x6, 0(x9)
addi x9, x9, -4
lw x5, 0(x9)
addi x9, x9, -4
lw x4, 0(x9)
addi x9, x9, -4
addi x9, x9, -4
lw x3, 0(x9)
addi x9, x9, -4
lw x2, 0(x9)
addi x9, x9, -4
lw x1, 0(x9)
addi x9, x9, -4

jal x1, ADDER
# These things will be executed after JUMPING section
addi x2, x0, 1000
addi x3, x0, 1001
addi x4, x0, 1002
jal END_ADDER

ADDER:
addi x2, x0, -1000
addi x3, x0, -1001
addi x4, x0, -1002
jalr ra
END_ADDER:

addi x2, x0, 500
addi x3, x0, 400

bne x2, x3, BNE_SHOULD_HAPPEN

BNE_SHOULD_NOT_HAPPEN: # Must be unreachable
addi x2, x0, 1000 # Must be unreachable
jal BNE_END # Must be unreachable

BNE_SHOULD_HAPPEN:
addi x3, x0, 500 # now x2 == x3
bne x2, x3, BNE_SHOULD_NOT_HAPPEN
BNE_END:

addi x20, x0, 200
addi x21, x0, 200

beq x20, x21, BEQ_SHOULD_HAPPEN

BEQ_SHOULD_NOT_HAPPEN:
addi x20, x0, 1001 # Must be unreachable
jal BEQ_END # Must be unreachable

BEQ_SHOULD_HAPPEN:
addi x21, x0, 201 # now x20 != x21
beq x20, x21, BEQ_SHOULD_NOT_HAPPEN
BEQ_END: