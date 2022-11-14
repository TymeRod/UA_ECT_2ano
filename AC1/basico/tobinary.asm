# Mapa de registos:
# $t0 – value
# $t1 – bit
# $t2 - i

	.data
str1:	.asciiz "Introduza um numero: "
str2: 	.asciiz "\no valor em binario e:"
	.eqv print_string,4
	.eqv read_int,5
	.eqv print_char,11
	
	.text
	.globl main
	
main: 	la $a0,str1
	li $v0,print_string # (instrução virtual)
	syscall # print_string(str1);
	
	li $v0, read_int
	syscall 
	or $t0, $0, $v0
	
	la $a0,str2
	li $v0, print_string
	syscall

	
	li $t2,0 # i = 0
	li $t4,0 #flag = 0
	
for: 	bge   $t2,32,endfor # while(i < 32) {
	andi $t1,$t0,0x80000000 # (instrução virtual)
	srl $t1,$t1,31
	
	rem $t3,$t2,4	
	
#if2:	bne $t3,$0,else2
#	li $a0,' '
#	li $v0, print_char
#	syscall
#	j	endif2
#else2:			
#	j	endif2
#endif2:


if:	beq $t4,1,then
	bne $t1,0,then
	j endif
then:
	li $t4,1
	addi $a0, $t1, '0'
	li $v0, print_char
	syscall
endif:
	
	
	
	addi $t2,$t2, 1 #i++

	sll $t0,$t0, 1 # value = value << 1;
	
#if:	bne   $t1,$0,else # if(bit != 0)
#	li $a0,'0'
#	li $v0, print_char
#	syscall
#	j	endif
#
#else: 	li $a0,'1'
#	li $v0, print_char
#	syscall
#	
#endif:	
	j for 
	
endfor: 
	jr $ra # fim do programa