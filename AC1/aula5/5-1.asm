# i: $t0
# lista: $t1
# lista + i: $t2

	.data
	
	.eqv	SIZE,5
	.eqv	print_string, 4
	.eqv 	read_int, 5
	
lista:	.space SIZE

str: 	.asciiz "\nIntroduza um numero: "

	.text
	.globl main
	
main:	li $t0, 0
	la $t1, lista
	
for:	bge $t0, SIZE, endF

	la $a0, str
	li $v0, print_string
	syscall
	
	sll $t2,$t0,2
	addu $t2,$t2,$t1
	
	li $v0, read_int
	syscall
	
	sw $v0, 0($t2)
	addi $t0,$t0,1	
	j for

endF:	jr $ra

