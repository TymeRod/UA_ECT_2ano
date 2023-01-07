	.data
	
oldg:	.float -1.0
g:	.float 1.0

	.text
	.globl func3
	
func3:	sub.s	$f0, $f0, $f0
	li	$t0, 0
	
	la	$t1, oldg
	l.s	$f2, 0($t1)
	
	la	$t1, g
	l.s	$f4, 0($t1)
	
for:	bge	$t0, $a2, endF
	
	sub.s	$f6, $f4, $f2
	
	sll	$t2, $t0, 2
	addu	$t2,$t2, $a0
	
	
while:	c.le.s 	$f6, $f12
	bc1t	endW
	
	mov.s	$f2, $f4
	
	l.s	$f8, 0($t2)
	div.s	$f10, $f8, $f12
	add.s	$f4, $f4, $f10
	
	j	while
	
endW:	add.s	$f0, $f0, $f2
	s.s	$f2, 0($t2)
	
	addi	$t0, $t0, 1
	j	for

endF:	mtc1	$a2, $f2
	cvt.s.w	$f2, $f2
	
	div.s	$f0, $f0, $f2
	
	jr	$ra