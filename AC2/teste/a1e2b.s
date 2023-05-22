    .equ getChar, 2
    .equ putChar, 3
    .equ inkey  , 1

    .data
    .text
    .globl main

main:
do:    
    li  $v0, inkey
    syscall

    move $t0, $v0

if: beq  $t0, 0, else	# if $t0 == $t1 then goto target
    
    move $a0, $t0
    li $v0, putChar
    syscall

else:

    la	$a0, '.'		
    li  $v0, putChar
    syscall

    bne		$t0, '\n',do 	# if $a0 !'\n', goto target

    li  $v0, 0
    jr  $ra
    