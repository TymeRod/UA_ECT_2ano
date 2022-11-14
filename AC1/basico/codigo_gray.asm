	.data
	.text
	.globl main
	
main: 	
	ori $v0, $0, 5
	syscall 	
	or $t0, $0, $v0

	srl $t1, $t0, 1
	
	xor $t1, $t0, $t1
	
	jr $ra