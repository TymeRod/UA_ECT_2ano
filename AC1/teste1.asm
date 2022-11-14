	.data
	.eqv SIZE, 21
	.eqv print_String, 4
	.eqv readString, 8
str:	.space SIZE
str2:	.asciiz "Introduza uma string: \n"
	.text
	.globl main
	
main:	la 	$a0,str 
	li 	$a1,SIZE 
	li 	$v0,readString
	syscall 
	
	la $t0, str
	lb $t1, 0($t0) 	# *p 
	sub $t1,$t1,'a'
	addi $t1,$t1,'A'
	
	la $a0, str	
	li $v0, print_String
	syscall		
	jr $ra