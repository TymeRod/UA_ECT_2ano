	.data
str:	.asciiz "101101"
	.eqv print_int, 1
	
	.text
	.globl main
	
	
# Mapa de registos
# res: $v0
# s: $a0
# *s: $t0
# digit: $t1
# Sub-rotina terminal: não devem ser usados registos $sx
	
atoi:		li 	$v0, 0
while:		lb 	$t0, 0($a0)
		blt	$t0, '0', endW
		bgt	$t0, '1', endW
		sub 	$t1, $t0, '0'
		addiu	$a0, $a0, 1
		mul 	$v0,$v0,2
		add 	$v0,$v0,$t1
		j 	while
endW:		jr	$ra


main:		addiu 	$sp,$sp,-4
		sw	$ra, 0($sp)


		la 	$a0, str
		jal 	atoi
		
		move	$a0, $v0
		li 	$v0, print_int
		syscall
		
		lw	$ra, 0($sp)
		addiu 	$sp,$sp,4
		jr	$ra
	
	