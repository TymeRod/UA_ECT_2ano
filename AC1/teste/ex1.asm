# Mapa de registos
# val : $t0
# n : $t1
# min : $t2
# max : $t3

	.data
	.eqv printStr, 4
	.eqv printInt, 1
	.eqv readInt, 5
	
str: 	.asciiz "Digite ate 20 inteiros (zero para terminar)\n"
str2: 	.asciiz "Máximo/mínimo são: "
str3:	.asciiz ":"
	
	.text
	.globl main
	
main:	
	li $t1, 0
	li $t2, 0x7FFFFFFF 
	li $t3, 0x80000000  
	
	la $a0, str
	li $v0, printStr
	syscall
	
do:
	li $v0, readInt
	syscall
	move $t0, $v0
	
if:	beq $t0, 0 , endIf
	
	
if2:	ble $t0,$t3,if3
	move $t3, $t0

	
if3: 	bge $t0, $t2, endIf
	move $t2, $t0

endIf:	
	addiu $t1,$t1, 1

	bge $t1, 20,endDo
	beq $t0, 0, endDo
	j do
	
endDo:
	la $a0, str2
	li $v0, printStr
	syscall
	
	move $a0,$t3
	li $v0,printInt
	syscall
	
	la $a0, str3
	li $v0, printStr
	syscall
	
	move $a0, $t2
	li $v0, printInt
	syscall
	
	jr $ra

	
	
