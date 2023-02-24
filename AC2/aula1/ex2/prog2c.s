        .equ printInt, 6
        .equ readInt10, 5
        .equ printInt10, 7
        .equ printString, 8

        .data

str:    .asciiz "\nIntroduza um inteiro (sinal e módulo): "
str2:   .asciiz "\nValor em base 10 (signed): "
str3:   .asciiz "\nValor em base 2: "
str4:   .asciiz "\nValor em base 16: "
str5:   .asciiz "\nValor em base 10 (unsigned): "
str6:   .asciiz "\nValor em base 10 (unsigned), formatado: "

        .text

        .globl main

main: 
while:  la $a0, str
        li $v0, printString
        syscall

        li $v0, readInt10
        syscall

        move $t0, $v0

        la  $a0, str2
        li  $v0, printString
        syscall

        move $a0, $t0
        li  $v0, printInt10
        syscall

        la  $a0, str3
        li  $v0, printString
        syscall

        move $a0, $t0
        li   $a1, 2 
        li  $v0, printInt
        syscall

        la  $a0, str4
        li  $v0, printString
        syscall

        move $a0, $t0
        li   $a1, 16
        li  $v0, printInt
        syscall

        la  $a0, str5
        li  $v0, printString
        syscall

        move $a0, $t0
        li   $a1, 10
        li  $v0, printInt
        syscall

        la  $a0, str6
        li  $v0, printString
        syscall

        move $a0, $t0
        li   $a1, 0x0005000A
        li  $v0, printInt
        syscall

        j while

endw:
        li $v0, 0
        jr $ra