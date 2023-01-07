# Mapa de registos
# res -> $f0 no f pq é um float
# val -> $t0 
#

	  .data
k1:       .float	2.59375
k2:	  .float	0.0
	  .text
	  .globl main
	  
main:	
	
do:	li	$v0, 5 
	syscall
	move 	$t0, $v0                # val = read_int();
	mtc1	$t0, $f0                # move to c1 e mfc1 move from c1
	cvt.s.w	$f0, $f0                # converter $f0 em float($f0) float(val)
	 
	#la	$t1, k1			# guardar em $t1 a constante k1
	l.s	$f2, k1			# $f2 = 2.59375
	
	mul.s	$f0, $f0, $f2		# res = float(val) * 2.59375 
	
	li	$v0, 2			# print_float()
	mov.s	$f12, $f0		
	syscall				# print_float(res)
	
	#la	$t1, k2			# guardar em $t1 a constante k2
	l.s	$f2, k2			# $f2 = 0.0
	
	c.eq.s	$f0, $f2		# comparar res com 0.0
	bc1f    do			# while (res != 0.0);
	
	li 	$v0, 0			# return 0;	
	
	jr    	$ra



	




























