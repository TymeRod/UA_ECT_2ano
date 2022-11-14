# Mapa de registos
# num: $t0
# p: $t1
# *p: $t2
	
	.data
	.eqv SIZE,21
	.eqv read_string,8
	.eqv print_int10,1
str: 	.space SIZE 
	.text
	.globl main
	
main: 	
	la 	$a0,str 
	li 	$a1,SIZE 
	li 	$v0,read_string
	syscall 
	
	li 	$t0,0		# num = 0
	la 	$t1,str 	# p = str
	
while: 				# while(*p != '\0')
	lb	$t2,0($t1)	#$t2 = *p
	beq   	$t2,'\0',endw 	# {
	
if: 	blt   	$t2,'0',endif 
	bgt   	$t2,'9',endif
	addi 	$t0,$t0,1 	# num++;
endif:
	addi 	$t1,$t1,1 	# p++;
	j while 		# }
endw: 	
	move $a0,$t0 
	li $v0,print_int10
	syscall
	jr $ra 			# termina o programa
