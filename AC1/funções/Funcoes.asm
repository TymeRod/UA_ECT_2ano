# O argumento da função é passado em $a0
# O resultado é devolvido em $v0
# Sub-rotina terminal: não devem ser usados registos $sx

	
	.data
	.eqv print_int10, 1
str:	.asciiz "Arquitetura de Computadores I"
	.text
	.globl main
	
main:	addiu 	$sp,$sp,-4	
	sw 	$ra,0($sp)

	la 	$a0, str
	jal	strlen
	
	move 	$a0,$v0
	li 	$v0, print_int10
	syscall 
	
	lw 	$ra, 0($sp)
	addiu 	$sp,$sp,4
	jr 	$ra
	
	
	
#len: $v0
#s: $a0
	
strlen:	li 	$v0,0
while:	lb 	$t1, 0($a0)
	addiu 	$a0,$a0,1
	beq 	$t1,'\0', endW
	addi 	$v0,$v0,1
	j 	while
endW:	
	jr 	$ra