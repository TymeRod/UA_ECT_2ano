        .equ BASE, 0xBF88
        .equ TRISE,0x6100
        .equ LATE, 0x6120


        .text
        .globl main

main:   addiu   $sp, $sp, -8
        lw      $ra, 0($sp)

        lui     $t0, BASE

        lw		$t1, TRISE($$t0)
        andi    $t1,$t1, 0xFF83 #1111 1111 1000 0011 
        sw		$t1, TRISE($t0)		

        li		$t2,  0		# $t2 = counter 
        
loop:   lw      $t1, LATE($t0)
        andi    $t1, $t1, 0xFF83
        sll     $t2, $t2, 2
        or		$t1, $t1, $t2		# $t1 = $t1 | $t2
        sw		$t1, LATE($t0)		#

        subi	$t2, $t2, 1
if:        

        

        
        

        