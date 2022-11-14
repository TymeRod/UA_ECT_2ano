# Maoa de registos
# i: $t0
# v: $t1
# &(val[0]): $t1


	.data
	
	.eqv printStr, 4
	.eqv printInt, 1
	.eqv SIZE, 8
	
val:	.word 8,4,15,-1987,327,-9,27,16

str:	.asciiz "Result is: "
str2:	.asciiz ","
	
	.text
	.globl main

main:	li $t0, 0 	#i = 0
	la $t1, val	# $t1 = &(val[0])
	li $t5, SIZE
	div $t5, $t5, 2	#SIZE/2
	
do:	sll $t2, $t0, 2
	addu $t3,$t2,$t1 
	
	sll $t6,$t5,2
	add $t6,$t6,$t2
	addu $t6,$t1,$t6

	lw $t4, 0($t3)	#val[i] = $t4
	lw $t7, 0($t6)	#val[i+SIZE/2] = $t7
	
	sw $t4, 0($t6)	# 
	sw $t7, 0($t3)	#

	addi $t0,$t0,1	#++i
	
	bgeu $t0, $t5, endDo #while(i < SIZE/2)
	j do
	
endDo:	la	 $a0, str
	li	 $v0, printStr
	syscall			#print_string("Result is: ")
	
	li	 $t0, 0 	# i = 0
	
do2:	sll 	$t2,$t0,2
	addu	$t2,$t1,$t2

	lw $t3, 0($t2)	#$t3 = val[i]
	move $a0, $t3
	li $v0, printInt	
	syscall	#print_int10(val[i])
	
	la $a0, str2
	li $v0, printStr
	syscall	#print_char(',')
	
	addi $t0,$t0,1 #i++
	
	bgeu 	$t0, SIZE, endDo2 # while(i < SIZE)
	j do2
	
endDo2:	jr $ra




	
