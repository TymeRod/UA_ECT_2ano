# Mapa de registos
# p: $t0
# *p: $t1
# houve_troca: $t4
# i: $t5
# lista: $t6
# lista + i: $t7

	.data
	
	.eqv SIZE, 10
	.eqv TRUE, 1
	.eqv FALSE, 0
	.eqv	print_string, 4
	.eqv 	read_int, 5
	.eqv print_int10, 1
	
lista:	.space SIZE
	
str: 	.asciiz "\nIntroduza um numero: "
str1:	.asciiz "\nConteudo do array:\n"
str2:	.asciiz "; "

	.text
	.globl main
	
main:	la $t0, lista
	li $t3, SIZE
	sll $t3,$t3,2
	add $t3,$t3,$t0
	
for:	bge $t0, $t3, endF

	la $a0, str
	li $v0, print_string
	syscall
	
	li $v0, read_int
	syscall
	sw $v0, 0($t0)
	
	addi $t0,$t0,4
	j for
endF: 

do:	li $t4, FALSE
	li $t5, 0
	li $t6, SIZE
	sub $t6,$t6,1
	la $t0, lista
	
for2:	bge $t5,$t6,endF2
	
	sll $t7,$t5,2
	addu $t7,$t7, $t0
	
	lw $t8, 0($t7)
	lw $t9, 4($t7)
	
if:	ble $t8, $t9, endIf

	sw $t8, 4($t7)
	sw $t9, 0($t7)
	
	li $t4, TRUE
	
endIf:	addi $t5,$t5,1
	j for2
	
endF2:	bne $t4, TRUE, endDo
	j do

endDo:
	la $a0, str1
	li $v0, print_string
	syscall
	
	li $t1, 0
	la $t0, lista
	
for3:	bge, $t1, SIZE, endF3

	sll $t3, $t1,2
	add $t3,$t3,$t0
	
	lw $t4, 0($t3)
	
	move $a0, $t4
	li $v0, print_int10
	syscall
	
	la $a0, str2
	li $v0, print_string
	syscall
	
	addi $t1,$t1,1
	j for3
	
endF3:	jr $ra






