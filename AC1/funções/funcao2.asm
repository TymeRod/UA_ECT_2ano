	.data
	.eqv print_str,4
str: 	.asciiz "ITED - orievA ed edadisrevinU"
	
	.text
	.globl main
	

exchange:	 lb 	$t0, 0($a0)	#aux = *c1
		 lb 	$t1, 0($a1)
		 
		 sb 	$t0, 0($a1)	# *c1 = *c2
		 sb 	$t1, 0($a0)	# *c2 = aux
		 
		 jr 	$ra

	
# Mapa de registos:
# str: $a0 -> $s0 (argumento é passado em $a0)
# p1: $s1 (registo callee-saved)
# p2: $s2 (registo callee-saved)
			
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
		
		
		
		
main:		addiu 	$sp,$sp, -4
		sw	$ra, 0($sp)

		la 	$a0, str
		jal	strrev
		
		move 	$a0, $v0
		li 	$v0, print_str
		syscall
		
		lw	$ra, 0($sp)
		addiu 	$sp,$sp, 4
		jr 	$ra
		        
		            
		                    