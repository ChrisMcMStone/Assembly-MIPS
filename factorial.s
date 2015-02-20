.data
.align 2

input: .asciiz "\nInput a number: "
cr: .asciiz "\n"

.text
.globl main

main:

    li $v0, 4
    la $a0, input
    syscall         # prompt for input

    li $v0, 5
    syscall
    move $a0, $v0   # store input in s0

    jal FACT
    move $a0, $v0
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, cr
    syscall
    li $v0, 10
    syscall

FACT:
    addi $t0, $a0, -1
    bgtz $t0, REC
    li $v0, 1
    j RET

REC:
    addi $sp, $sp, -8    # decrement stack pointer
    sw $a0, 4($sp)
    sw $ra 0($sp)
    addi $a0, $a0, -1
    jal FACT
    lw $a0, 4($sp)
    lw $ra, 0($sp)
    addi $sp, 8
    mul $v0, $v0, $a0 

RET:
    jr $ra
