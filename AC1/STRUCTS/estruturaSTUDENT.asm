#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA KMs aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
#typedef struct
#{				\Alin\Size\Offset    \
#unsigned int  id_number;	\ 4  \ 4  \ 0        \
#char firstname[18];		\ 1  \ 18 \ 4	     \
#char lastname[15];		\ 1  \ 15 \ 22	     \
#float grade;			\ 4  \ 4  \ 37 -> 40 \
#}student			\ 4  \ 44 \	     \
#
#AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA KMs aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa


	.data
	.align 2
stg:	.word 72343
	.asciiz "Napoleao"
	.space 9
	.asciiz "Bonaparte"
	.space 5
	#.align 2  não é necessário pq .float ja faz isso
	.float 5.1
	
str1:	.asciiz "\nN. Mec: "
str2:	.asciiz "\nNome: "
str3:	.asciiz "\nNota: "
	
	.text
	.globl main
	
main:	
	la	$t0, stg
	
	la	$a0,str1
	li	$v0,4
	syscall
	
	li	$v0, 5
	syscall
	
	sw	$v0, 0($t0)
	
	li	$a1, 17
	addiu 	$a0 ,$t0, 4
	li 	$v0, 8
	syscall
	
	 
	
	
	la	$a0,str1
	li	$v0,4
	syscall
	
	lw	$a0, 0($t0)		# $a0 = stg.id_number
	li	$v0, 36
	syscall
	
	la 	$a0, str2
	li 	$v0, 4
	syscall
	
	addiu	$a0,$t0,22
	li	$v0, 4
	syscall
	
	li 	$a0, ','
	li 	$v0, 11
	syscall
	
	addiu	$a0,$t0,4
	li	$v0, 4
	syscall
	
	la 	$a0, str3
	li 	$v0, 4
	syscall
	
	l.s	$f12, 40($t0)
	li	$v0, 2
	syscall
	
	jr	$ra
	 






















