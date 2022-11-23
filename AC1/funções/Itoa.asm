# Mapa de registos
# n: $a0 -> $s0
# b: $a1 -> $s1
# s: $a2 -> $s2
# p: $s3
# digit: $t0
# Sub-rotina intermédia


	.data
	.eqv	SIZE,33
str:	.space	SIZE
	.eqv	print_str, 4
	.eqv	read_int, 5
	.text
	.globl main
	
	
	
toascii:	move $v0, $a0
		addi $v0,$v0,'0'
		
if:		ble  $v0, '9', endIf
		addi	$v0,$v0, 7
		
endIf:		jr $ra





itoa:		addiu	$sp,$sp,-20
		sw	$ra,0($sp)
		sw 	$s0,4($sp)
		sw	$s1,8($sp)
		sw	$s2,12($sp)
		sw	$s3,16($sp)
		
		move	$s0,$a0			#$s0 = n
		move	$s1,$a1			#$s1 = b
		move	$s2,$a2			#$s2 = s
		move	$s3,$a2			#$s3 = p
		
		
do:		remu  	$t0, $s0, $s1		
		divu 	$s0, $s0, $s1
		
		move	$a0, $t0
		jal	toascii		
		move	$s2, $v0
		
		addi	$s3, $s3, 1
		ble	$s0, 0, endDo
		j	do
	
endDo:		sw	$0, 0($s3)
		move 	$a0, $s3
		jal	strrev
		
		lw	$ra,0($sp)
		lw 	$s0,4($sp)
		lw	$s1,8($sp)
		lw	$s2,12($sp)
		lw	$s3,16($sp)
		addiu	$sp,$sp,20
		
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
		
		
		
exchange:	 lb 	$t0, 0($a0)	#aux = *c1
		 lb 	$t1, 0($a1)
		 
		 sb 	$t0, 0($a1)	# *c1 = *c2
		 sb 	$t1, 0($a0)	# *c2 = aux
		 
		 jr 	$ra	
		 
		 	
		 		
		 			
main:		addiu	$sp,$sp,-8
		sw	$ra, 0($sp)
		sw	$s0, 4($sp)		
	
do2:		li $v0, read_int
		syscall
		move 	$s0 ,$v0
		
		move	$a0, $s0
		li 	$a1, 2
		la	$a2, str
		jal	itoa
		move	$a0, $v0
		li 	$v0, print_str
		syscall
		
		move 	$a0 ,$s0
		li 	$a1, 8
		la	$a2, str
		jal	itoa
		move	$a0, $v0
		li 	$v0, print_str
		syscall
		
		move 	$a0 ,$s0
		li 	$a1, 16
		la	$a2, str
		jal	itoa
		move	$a0, $v0
		li 	$v0, print_str
		syscall
			
		beqz	$s0, endDo2
		j	do2
		
endDo2:		lw	$ra, 0($sp)
		lw	$s0, 4($sp)
		addiu 	$sp, $sp, 8
		jr	$ra
					
	
			