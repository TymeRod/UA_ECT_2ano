# ft: $f12
# retorno : $f0

	.data
a1:	.double		5.0
b1:	.double 	9.0
c1:	.double		32.0
	.text
	.globl	main
	
f2c:	la	$t0, c1
	l.d	$f0, 0($t0)		# $f0 = 32.0
	
	la	$t0, b1
	l.d	$f2, 0($t0)		# $f2 = 9.0
	
	la	$t0, a1
	l.d	$f4, 0($t0)		# $f4 = 5.0
	
	sub.d	$f0, $f12, $f0		# $f0 = (ft(está em $f12) - 32.0)
	mul.d	$f0, $f0, $f4		# $f0 = 5.0 * (ft - 32.0)
	div.d	$f0, $f0, $f2		# $f0 = 5.0 / 9.0 * (ft - 32.0)
	
	jr	$ra			# pq deixámos sempre o resultado em $f0 que é o retorno
	
main:	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	li	$v0, 7
	syscall				# read_double)()
	
	mov.d	$f12, $f0		# como lê um double, esse registo vai para $f0 e por isso precisamos de passar para $f1 
	jal	f2c			# $f12 para garantirmos como entrada na função f2c
	
	mov.d	$f12, $f0
	li	$v0, 3
	syscall				# print_double(retorno
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	
	jr	$ra
