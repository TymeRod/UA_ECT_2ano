	.data
	
	.eqv SIZE, 4
	.eqv print_int10, 1
	
array: 	.word 	7692, 23, 5, 234

	.text
	.globl main
	
main: 	li $t3, 0
	li $t0, 0
	la $t2, array
	
for:	bge	$t0, SIZE, endW

	sll $t4,$t0,2
	addu $t4,$t4,$t2
	
	lw $t5,0($t4)
	
	add $t3,$t3,$t5
	
	addi $t0,$t0,1
	j for
	
endW:	move $a0, $t3
	li $v0, print_int10
	syscall
	
	jr $ra
	
	