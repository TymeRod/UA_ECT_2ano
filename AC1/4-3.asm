# Mapa de registos
# p: $t0
# pultimo:$t1
# *p $t2
# soma: $t3

	.data
	
	.eqv SIZE, 4
	.eqv print_int10, 1
	
array: 	.word 	7692, 23, 5, 234

	.text
	.globl main
	
main:	li $t3, 0

	la $t0, array
	
	li $t1, SIZE
	sub $t1,$t1,1
	sll $t1,$t1,2
	add $t1,$t1,$t0

while:	bgt $t0,$t1, endW

	lw $t2, 0($t0)
	add $t3,$t3,$t2
	
	addi $t0,$t0,4
	j while
	
endW:	move $a0, $t3
	li $v0, print_int10
	syscall
	
	jr $ra
	
	
		