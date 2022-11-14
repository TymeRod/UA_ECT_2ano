	.data
str:	.asciiz "Insira um numero: \n"
	.eqv printStr, 4
	.eqv readInt, 5
	.eqv printInt, 1
	.text
	.globl main	

main:	la $a0, str
	li $v0, printStr
	syscall
	
	li $v0, readInt
	syscall
	
	move $t0,$v0
	li $t2, 8
	
	add $t1,$t0,$t0
	add $t1, $t1, $t2
	
	move $a0, $t1
	li $v0, printInt
	syscall
	
	jr $ra
	
	