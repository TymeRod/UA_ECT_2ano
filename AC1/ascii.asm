	.data
str1: .asciiz "So para chatear"
str2: .asciiz  "AC1 - P"

	.eqv print, 4

	.text
	.globl main

main:	
	ori $v0, $0, print
	
	la $a0, str1
	
	syscall 

	jr $ra