	.data
a1:	.float 1.0	
k2:    .float    2.0
	.text
	.globl main
	
main: 	addiu    $sp, $sp, -4
    	sw    	$ra, 0($sp)
    
    	li    	$a0, 4
    	la    	$t0, k2
    	l.s    	$f12, 0($t0)
    	jal   	xtoy
    	
    	li    	$v0, 2
    	mov.s   $f12, $f0
    	syscall
	
	lw    	$ra, 0($sp)
	addiu  	$sp, $sp, 4
    
    	jr    	$ra
	
#--------________-----------------_________----------

abs1:	bge	$a0, 0 , endif
	sub	$a0,$0, $a0
endif:	move	$v0, $a0
	jr	$ra				



#--------________-----------------_________----------
#Mapa de registos:
# $f20 -> x
# $s0 -> y
# $f0 -> result
# $t0 -> i

xtoy:	addiu	$sp,$sp, -12
	sw	$ra, 0($sp)
	sw 	$s0, 4($sp)
	s.s  	$f20, 8($sp)
	
	move	$s0, $a0
	mov.s  	$f20, $f12
	
	jal	abs1
	move	$t1, $v0	
	
	la 	$t0, a1
	l.s	$f0, 0($t0)
	li 	$t0, 0
	
for:	bge	$t0, $t1, endFor

if1:	ble 	$s0, $0, else1
	mul.s	$f0, $f0, $f20
	j 	endIf1
	
else1:	div.s	$f0, $f0, $f20

endIf1:	addi	$t0,$t0, 1
	j	for
endFor:	lw	$ra, 0($sp)
	lw 	$s0, 4($sp)
	l.s  	$f20, 8($sp)
	addiu	$sp,$sp, 12
	jr 	$ra
	
#--------________-----------------_________----------
	
	