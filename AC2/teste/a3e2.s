		.equ BASE,  0xBF88          # 16 MSbits of SFR area
		.equ TRISE, 0x6100          # TRISE address is 0xBF886100
		.equ LATE,  0x6120          # LATE address is 0xBF886120
		.equ TRISB,	0x6040
		.equ PORTB,	0x6050

		.text
		.globl main

main:	lui		$t1, BASE
		lw		$t2, TRISE($t1)
		andi	$t2, $t2, 0xFFE1	#1111 1111 1110 0001
		sw		$t2, TRISE($t1)

		lw		$t2, TRISB($t1)
		ori		$t2, $t2, 0x000E 			#0000 0000 0000 1110
		sw		$t2, TRISB($t1)

		li		$t0,  0		# count = 0 

loop:	sll		$t3, $t0, 1
		lw		$t2, LATE($t1)
		andi	$t2, $t2, 0xFFE1
		or		$t2, $t2, $t3
		sw		$t2, LATE($t1)		# 
		
		li		$a0, 250
		jal		delay




delay:  li      $v0, RESET_CORE_TIMER
        syscall
        mul     $a0, $a0, 20000
while:  li      $v0, READ_CORE_TIMER
        syscall
        blt     $v0, $a0, while
        jr      $ra