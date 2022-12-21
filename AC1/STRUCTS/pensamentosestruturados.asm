	.data
struc:	.asciiz "Str_1"
	.space 8
	.word 2021
	.asciiz "Str_2"
	.space 11
	.double 2.718281828459045
	
	.text
	.globl main
	
f1:	la	$t0, struc
	l.d	$f0, 40($t0)
	jr 	$ra

main:	addiu 	$sp,$sp, -4
	sw	$ra, 0($sp)
	
	jal	f1
	
	mov.d	$f12, $f0
	li	$v0, 3
	syscall
	
	
	lw	$ra, 0($sp)
	addiu 	$sp,$sp, 4
	
	jr 	$ra