	.data
	.text
	.globl main
	
	
	
main:  	
	ori $v0, $0, 5
	syscall 
	or $t0, $0 ,$v0

	srl $t1, $t0, 4
	xor $t2, $t0, $t1
	
	srl $t1,$t2,2
	xor $t2,$t2,$t1
	
	srl $t1,$t2,1
	xor $t2,$t2,$t1
	
	jr $ra