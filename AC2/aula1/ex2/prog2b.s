    .data
    .equ    INKEY, 1
    .equ    PUT_CHAR, 3

    .text
    .global main

main:
do:     li $v0, INKEY
        syscall

        move $a0, $v0
        
if:     beq $a0, 0, else
        li $v0, PUT_CHAR
        syscall
        j endIf

else:   li $v0, PUT_CHAR
        la $a0, '.'
        syscall

endIf:  bne $a0, '\n', do
enddo:  li  $v0, 0
        jr  $ra