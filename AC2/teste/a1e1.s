    .equ PRINT_Str, 8

    .data

msg:.asciiz "AC2 - Aulas praticas\n"
    
    .text
    .globl main

main:   
    la		$a0, msg
    li	    $v0, PRINT_Str
    syscall
    li      $v0, 0
    jr		$ra					# jump to $ra
     
    
    
