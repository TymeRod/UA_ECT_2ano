	.data
dk1:	.double 1.0
dk2:	.double 0.5
	.text
	.globl main
	
main:
	jr 	$ra

#--------________-----------------_________----------

sqrt:	la	$t0, dk1
	l.d	$f2, 0($t0)
	
	li	$t0, 0
	
	la	$t1, dk2
	l.d	$f6, 0($t1)
	
	mtc1	$0, $f0		
	cvt.d.w	$f0, $f0
	
if:	c.le.d	$f12, $f0
	bc1t	else
	
do:	mov.d	$f4, $f2

	div.d	$f8, $f12, $f2
	add.d	$f8,$f8,$f4
	mul.d	$f2, $f6, $f8
	
	c.eq.d	$f4, $f2
	bc1t	endDo
		
		