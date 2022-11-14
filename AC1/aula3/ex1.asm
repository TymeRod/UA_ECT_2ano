#$t0 = i
#$t1 = soma
#$t2 = value
	
	
	.data
	.eqv printStr, 4
	.eqv readInt,  5
	.eqv printInt, 1
	
str:	.asciiz "Introduza um numero: "
str2: 	.asciiz "A soma dos positivos é: "
str3: 	.asciiz "Valor ignorado \n"

	.text
	.globl main
	
main:	li $t0 ,0
	li $t1, 0
	
for:	bge $t0,5,endF

	la $a0,str
	li $v0, printStr
	syscall
	
	li $v0, readInt
	syscall
	move $t2, $v0
	
if:	ble $t2,0,else
	add $t1, $t1, $t2
	j endIf

else:	la $a0,str3
	li $v0, printStr
	syscall
	j endIf
	
endIf:	
	addi $t0,$t0,1
	j for
	
endF:	la $a0, str2
	li $v0, printStr
	syscall
	
	move $a0, $t1
	li $v0, printInt
	syscall
	
	jr $ra
	
