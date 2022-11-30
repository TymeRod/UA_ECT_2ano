	.data
	.eqv	SIZE,30
	.eqv 	print_str, 4
	.eqv	print_int, 1
	
str1:	.asciiz "I serodatupmoC ed arutetiuqrA"	
str2:	.space	31
str3:	.asciiz	"String too long: "
str4:	.asciiz "\n"
	
	.text
	.globl main
	
strcpy:		li 	$t0,0
do:		addu	$t1,$t0,$a0	#i + dst
		addu 	$t2,$t0,$a1	#i + src
	
		lb	$t3, 0($t2)	#scr[i]
		sb	$t3, 0($t1)	#dst[i] = src[i] 
		
		addi	$t0,$t0,1	#i++
		bne	$t3,'\0',do	#while(src[i] != '\0')
	
		move 	$v0, $a0	#return dst
		jr 	$ra
	
	
	
exchange:	 lb 	$t0, 0($a0)	#aux = *c1
		 lb 	$t1, 0($a1)
		 
		 sb 	$t0, 0($a1)	# *c1 = *c2
		 sb 	$t1, 0($a0)	# *c2 = aux
		 
		 jr 	$ra
		 
		 
		 
		 
		 
			
strrev:		addiu 	$sp,$sp, -16	#
		sw	$ra, 0($sp)	#
		sw	$s0, 4($sp)	#
		sw	$s1, 8($sp)	#
		sw 	$s2, 12($sp)	#
					#
		move 	$s0, $a0	#str
		move	$s1, $a0	#p1 = str
		move 	$s2, $a0	#p2 = str
					#
while1:		lb	$t0,0($s2)	#*p2
		beq	$t0,'\0',endW1	#while(*p2 != '\0')
		addiu	$s2,$s2,1	#p2++
		j 	while1		#
endW1:		addiu 	$s2,$s2,-1	#p2--
					#
while2:		bge 	$s1,$s2,endW2	#while(p1<p2)
		move 	$a0, $s1	#
		move 	$a1, $s2	#
		jal	exchange	#exchange(p1,p2)
		addiu 	$s1,$s1,1	#p1++
		addiu	$s2,$s2,-1	#p2--
		j 	while2		#
endW2:		move 	$v0,$s0		#return str
					#
		lw	$ra, 0($sp)	#
		lw	$s0, 4($sp)	#
		lw	$s1, 8($sp)	#
		lw 	$s2, 12($sp)	#	
		addiu 	$sp,$sp, 16     #
		jr 	$ra		#
		


strlen:		li 	$v0,0		#len = 0
while:		lb 	$t1, 0($a0)	#*s
		addiu 	$a0,$a0,1	#s++
		beq 	$t1,'\0', endW	#while(*s != '\0')
		addi 	$v0,$v0,1	#len++
		j 	while		#
endW:					#
		jr 	$ra		#return len



main:		addiu	$sp,$sp,-8
		sw	$ra, 0($sp)
		sw	$s0, 4($sp)

		la 	$a0, str1
		jal	strlen
		
		move	$s0,$v0
	
if:		bgt	$s0, SIZE,else
		la	$a0, str2
		la 	$a1, str1
		jal	strcpy
		
		move 	$a0, $v0
		li	$v0, print_str
		syscall
		
		la	$a0, str4
		li	$v0, print_str
		syscall
		
		la	$a0, str2
		jal 	strrev
		
		move	$a0, $v0
		li	$v0, print_str
		syscall
		
		j 	endif
		
else:		la 	$a0, str3
		li	$v0, print_str
		syscall
		
		la 	$a0, str1
		jal	strlen
		
		move	$a0,$v0
		li	$v0, print_int 
		syscall
		
endif:		lw	$ra, 0($sp)
		lw	$s0, 4($sp)
		addiu	$sp,$sp,8	
		










