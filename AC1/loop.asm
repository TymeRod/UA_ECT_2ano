# Mapa de registos:
# $t0 – soma
# $t1 – value
# $t2 - i
	.data
str1: 	.asciiz "Introduza um numero: "
str2: 	.asciiz "Valo"
str3: 	.asciiz "A som dos"
	.eqv print_string,4
	.eqv read_int,5
	.eqv print_int,1
	
	.text
	.globl main
	
main: 	li $t2, 0 #i = 0
	li $t0, 0 #soma = 0
	
for: 	bge $t2,5,endfor
	li $v0 ,print_string
	la $a0,str1
	syscall  	#print string
	
	li $v0 ,read_int
	syscall
	or $t1, $v0, $0 #value = read_int
	
if:	ble $t1,0,else
	add $t0, $t0, $t1 #soma += value
	j	 endif
else:	la $a0,str2
	li $v0, print_string
	syscall
	
endif:
	addi $t2,$t2, 1 #i++
	j	for
endfor:
	la $a0, str3
	li $v0, print_string
	syscall
	li $v0, print_int
	move $a0,$t0
	syscall
	
	jr $ra
	
	
