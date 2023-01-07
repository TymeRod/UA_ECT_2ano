# Mapa de registos
# f1:  	$a0 -> $s0
# k:  	$a1 -> $s1
# av:  	$a2 -> $s2
# i: 	$s3
# res:	$t0

 
	.data
	.eqv 	SIZE, 15
str:	.asciiz "Invalid argc"
	.text
	.globl func2
	
func2:	addiu	$sp,$sp, -20
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp) 
	sw	$s3, 16($sp)
	
	move	$s0, $a0		#$s0 -> f1
	move	$s1, $a1		#$s1 -> k
	move	$s2, $a2		#$s2 -> av
	
if:	blt	$s1, 2, else		#if(k >= 2)
	bgt	$s1, SIZE, else		#if(k <= SIZE)
	
	li	$s3, 2			#i = 2
	
do:	sll	$t1,$s3,2		
	addu	$t1, $t1, $s2		#&av[i]
	
	lw 	$a0, 0($t1)		
		
	jal 	toi			#toi(av[i])
	
	sll	$t1, $s3, 2
	addu	$t1,$t1, $s0		#&fl[i]
	
	sw	$v0, 0($t1)		#fl[i] = toi(av[i])
	
	addi	$s3, $s3, 1		#i++
	
	bge	$s3, $s1, endDo		#while(i < k)
	j	do
	
endDo:	move	$a0, $s0
	move	$a1, $s1
	
	jal	avz			#res = avz[]
	
	move 	$t0, $v0
	move	$a0, $t0
	li	$v0, 4
	syscall				#print_int10(res)
	
	j	endif

else:	la	$a0, str	
	li	$v0, 4
	syscall				#print_string("Invalid argc")

endif:	move	$v0, $t0		#return res
	
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp) 
	lw	$s3, 16($sp)
	addiu	$sp,$sp, 20
	
	jr	$ra
