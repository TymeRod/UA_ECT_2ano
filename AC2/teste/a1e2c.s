    .equ    readInt10, 5
    .equ    printStr, 8
    .equ    printInt10, 7
    .equ    printInt, 6

    .data

ms: .asciiz "\nIntroduza um inteiro (sinal e módulo): "
ms1:.asciiz "\nValor em base 10 (signed): "
ms2:.asciiz "\nValor em base 2: "
ms3:.asciiz "\nValor em base 16"
ms4:.asciiz "\nValor em base 10 (unsigned): "
ms5:.asciiz "\nValor em base 10 (unsigned), formatado: "

    .text
    .globl main

main:

while:
    la  $a0, ms
    li  $v0, printStr
    syscall

    li  $v0, readInt10
    syscall

    move $t0, $v0

#--------------------------------------------

    la  $a0, ms1
    li  $v0, printStr
    syscall

    move $a0, $t0
    li  $v0, printInt10
    syscall

#--------------------------------------------

    la  $a0, ms2
    li  $v0, printStr
    syscall

    move    $a0, $t0
    li  $a1, 2
    li  $v0, printInt
    syscall

#--------------------------------------------

    la  $a0, ms3
    li  $v0, printStr
    syscall

    move    $a0, $t0
    li  $a1, 16
    li  $v0, printInt
    syscall

#--------------------------------------------

    la  $a0, ms4
    li  $v0, printStr
    syscall

    move    $a0, $t0
    li  $a1, 10
    li  $v0, printInt
    syscall

#--------------------------------------------

    la  $a0, ms5
    li  $v0, printStr
    syscall

    move    $a0, $t0
    li  $a1, 0x0005000A
    li  $v0, printInt
    syscall

#--------------------------------------------   

    j while

    li $v0, 0
    jr $ra

