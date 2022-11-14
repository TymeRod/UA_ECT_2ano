# Mapa de registos
# n_even: $t0
# n_odd: $t1
# p1: $t2
# p2: $t4	

	.data
	.eqv read_int, 5
	.eqv print_int10, 1
	.eqv print_str,4
	.eqv N, 35
	
str: 	.asciiz " "	
	
a:	.space N
ba:	.space N

	.text
	.globl main
	
main:	li $t0, 0 		#n_even = 0
	li $t1, 0 		#n_odd = 0

	la $t2, a 		#p1 = a
	addi $t3, $t2, N 	# a+N
			
for:	bge $t2,$t3,endF

	li $v0, read_int
	syscall
	
	sb $v0, 0($t2) 		#*p1 = read_int()
	addi $t2,$t2,1
	j for
	
endF:	la $t2,a 		#p1 = a
	la $t4, ba 		#p2 = b
	addi $t3, $t2, N 	# a+N
	
	
	
for2: 	bge $t2, $t3, endF2	# for(p1 < (a + N))

	lb $t5, 0($t2) 		# $t5 = *p1
	rem $t6,$t5,2		# *p1 % 2
	lb $t7, 0($t4)		#$t7 = *p2
	
if:	beq $t6, 0, else 	#if((*p1 % 2) != 0)
	
	sb $t5, 0($t4) 		#*p2 = *p1
	addi $t4,$t4,1		# p2++
	addi $t1,$t1,1 		# n_odd++
	j endIf
	
else:	addi $t0,$t0,1 		# n_even++

endIf: 	addi $t2,$t2,1 		#p1++
	j for2

endF2:	la $t4, ba 		#p2 = b
	add $t5,$t4,$t1		# b + n_odd		

for3:	bge $t4,$t5, endF3	#for(p2 < (b + n_odd))
	lb $t7, 0($t4)		#*p2 = $t7
	move $a0, $t7		
	li $v0, print_int10	#print_int10(*p2)
	syscall
	
	la $a0, str 		
	li $v0, print_str	#print_int10(*p2)
	syscall
	
	addi $t4,$t4,1		# p2++
	j for3
	
endF3:	jr $ra 
	   
	
	


