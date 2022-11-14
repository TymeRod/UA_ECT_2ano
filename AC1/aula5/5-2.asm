# Mapa de registos
# p: $t0
# *p: $t1

	.data
	
	.eqv SIZE,10
	.eqv print_string, 4
	.eqv print_int10, 1
	
lista: 	.word 8,-4,3,5,124,-15,87,9,27,15

str:	.asciiz "\nConteudo do array:\n"
str2:	.asciiz "; "

	.text
	.globl main
	
main:	la $t0, lista
	li $t3, SIZE
	sll $t3,$t3,2
	add $t3,$t3,$t0
	
	la $a0, str
	li $v0, print_string
	syscall
	
for:	bge $t0, $t3, endF

	lw $t1, 0($t0)
	
	move $a0, $t1
	li $v0, print_int10
	syscall
	
	la $a0, str2
	li $v0, print_string
	syscall
	
	addi $t0,$t0,4
	j for
	
endF: jr $ra