# In the name of God
.data
array: .word 10, 25, 3, 40, 7

.text
la s0, array

# loop1 iteration variable (i)
addi s1, zero, 0 # s1 = zero + 0

loop1:
    slti t0, s1, 76
    beq t0, zero, end_loop1

    # loop2 iteration variable (j)
    addi s2, zero, 0 # s2 = zero + 0
    
    sub t0, zero, s1
    addi s3, t0, 76 # s3 = t0 + 76

    loop2:
        bge s2, s3, end_loop2 # if s1 >= s3 then end_loop2
        add t3, s2, s0
        lw t0, 0(t3)
        lw t1, 4(t3)
        
        bge t1, t0, end_if # if t1 >= t0 then target
        # swap
        sw t1, 0(s1)
        sw t0, 4(t3)
        end_if:
            addi s2, s2, 4 # s2 = s2 + 4
            j loop2
    end_loop2:
    addi s1, s1, 4 # s1 = s1 + 4
    j loop1
end_loop1:

