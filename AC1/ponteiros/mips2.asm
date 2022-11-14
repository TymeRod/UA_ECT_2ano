	.data
	.eqv print_str, 4
	.eqv print_char, 11
	.eqv print_int, 1
	.eqv SIZE,3
	
str1:	.asciiz	"Array"
str2:	.asciiz	"de"
str3:	.asciiz "ponteiros"
str4:	.asciiz "\nString #"
str5:	.asciiz ": "
array:	.word str1,str2,str3
	
	.text
	.globl main
	
#i : $t0
#j:  $t1
	
main:	li $t0,0

for:	bge $t0,SIZE,endF

	la $a0, str4
	li $v0, print_str
	syscall
	
	move $a0,$t0
	li $v0, print_int
	syscall
	
	la $a0, str5
	li $v0, print_str
	syscall
	
	li $t1,0
	
while:	la $t3, array
	sll $t2,$t0,2
	addu $t3,$t3,$t2
	lw $t3, 0($t3)
	
	addu $t3,$t3,$t1
	lb $a0, 0($t3)
	
	beq $a0, '\0', endW
	
	li $v0, print_char
	syscall
	
	li $a0, '-'
	syscall
	
	addi $t1,$t1,1
	j while
	
endW:	addi $t0,$t0,1
	j for
	
endF:	jr $ra
	
	
	