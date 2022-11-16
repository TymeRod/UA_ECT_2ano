	.data
	
	.text
	.globl main
	
strcpy:		li 	$t0,0
do:		addu	$t1,$t0,$a0	#i + dst
		addu 	$t2,$t0,$a1	#i + src
	
		lb	$t3, 0($t2)	#scr[i]
		sb	$t3, 0($t1)
		
		addi	$t0,$t0,1
		bne	$t3,'\0',do
	
		move 	$v0, $a0
		jr 	$ra
	
	
	
exchange:	 lb 	$t0, 0($a0)	#aux = *c1
		 lb 	$t1, 0($a1)
		 
		 sb 	$t0, 0($a1)	# *c1 = *c2
		 sb 	$t1, 0($a0)	# *c2 = aux
		 
		 jr 	$ra
		 
		 
		 
		 
		 
			
strrev:		addiu 	$sp,$sp, -16
		sw	$ra, 0($sp)
		sw	$s0, 4($sp)
		sw	$s1, 8($sp)
		sw 	$s2, 12($sp)
		
		move 	$s0, $a0	#str
		move	$s1, $a0	#p1
		move 	$s2, $a0	#p2
		
while:		lb	$t0,0($s2)
		beq	$t0,'\0',endW
		addiu	$s2,$s2,1
		j 	while
endW:		addiu 	$s2,$s2,-1

while2:		bge 	$s1,$s2,endW2
		move 	$a0, $s1
		move 	$a1, $s2
		jal	exchange
		addiu 	$s1,$s1,1
		addiu	$s2,$s2,-1
		j 	while2
endW2:		move 	$v0,$s0
		
		lw	$ra, 0($sp)
		lw	$s0, 4($sp)
		lw	$s1, 8($sp)
		lw 	$s2, 12($sp)		
		addiu 	$sp,$sp, 16     
		jr 	$ra
		


strlen:		li 	$v0,0
while:		lb 	$t1, 0($a0)
		addiu 	$a0,$a0,1
		beq 	$t1,'\0', endW
		addi 	$v0,$v0,1
		j 	while
endW:	
		jr 	$ra