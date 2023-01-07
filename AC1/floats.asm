	.data
	
k1:	.float 1.25	
	
	.text
	.globl main
	
main:	la	$t0, k1
	l.s	$f0, 0($t0)
	
	l.s	$f2, k1


	jr	$ra
	
