    .data
    .equ    GET_CHAR, 2
    .equ    PUT_CHAR, 3

    .text
    .global main

main:
do:     li $v0, GET_CHAR
        syscall

        move $a0, $v0
        addi $a0, $a0, 1

        li $v0, PUT_CHAR
        syscall

        bne $a0, '\n', do
enddo:  li  $v0, 0
        jr  $ra