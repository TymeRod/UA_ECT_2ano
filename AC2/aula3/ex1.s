    .equ    BASE, 0xBF88
    .equ    TRISE, 0x6100
    .equ    LATE, 0x6120
    .equ    TRISD, 0x60C0
    .equ    PORTD, 0x60D0

    .data
    .text
    .globl main

main:
    lui     $t0, BASE           #$t0 = 0xBF88
    lw		$t1, TRISD($t0)		#
    ori		$t1, $t1, 0x0100   	# $t1 = $t1 0x0001
    sw      $t1, TRISD($t0)		# RD8 as input

    lw      $t1, TRISE($t0)		#
    andi 	$t1, $t1, 0xfffe    # $t1 = $t1 & 0xFFFE
    sw      $t1, TRISE($t0)		# RE0 as output

loop: 
    lw      $t1, PORTD($t0)		#
    not     $t1, $t1
    andi	$t1, $t1, 0x0100    # $t1 = $t1 & 0x0001
    srl		$t1, $t1, 8			# $t1 = $t1 >> 0
    
    lw      $t2, LATE($t0)		#
    andi    $t2, $t2, 0xFFFE    # $t2 = $t2 & 0xFFFE
    
    or		$t2, $t2, $t1       # $t2 = $t2 | $t1   
    sw      $t2, LATE($t0)		# RE0 = RB0
    j       loop    
    
     
     
    