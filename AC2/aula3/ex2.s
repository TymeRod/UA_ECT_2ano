    .equ    BASE, 0xBF88
    .equ    TRISE, 0x6100
    .equ    LATE, 0x6120
    .equ    TRISB, 0x6040
    .equ    PORTB, 0x6050

    .data
    .text
    .globl main

main:
    lui     $t0, BASE           #$t0 = 0xBF88

    lw      $t1, TRISE($t0)		#
    andi 	$t1, $t1, 0xFFE1    # $t1 = $t1 & 0xFFE1
    sw      $t1, TRISE($t0)		# RE4-1 as output
    li		$t2,  0             # counter = 0

loop:
    lw      $t3, LATE($t0)		#
    andi 	$t3, $t3, 0xFFE1    # $t3 = $t3 & 0xFFE1

    sll		$t4, $t2, 1			# $t4 = $t2 << 1
    or      $t3, $t3, $t4
    sw      $t3, LATE($t0)		# output update

    li      $v0, 12
    syscall                     #resetCoreTimer()
delay:
    li      $v0, 11
    syscall                     #readCoreTimer()

    blt		$v0, 20000000, delay	# if $v0 <20000000 to delay

    addi	$t2, $t2, 1			# counter++
    blt     $t2, 16, cont
    li      $t2, 0
cont:
    j      loop
    jr		$ra					# jump to $ra
    
    






    
