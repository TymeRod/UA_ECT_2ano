        
        .equ BASE,  0xBF88          # 16 MSbits of SFR area
        .equ TRISE, 0x6100          # TRISE address is 0xBF886100
        .equ LATE,  0x6120          # LATE address is 0xBF886120
        .equ TRISD, 0x60C0
        .equ PORTD, 0x60D0

        .data
        .text
        .globl main

main:   lui     $t1, BASE
        lw	$t2, TRISE($t1)		#
        andi	$t2, $t2, 0xFFFE
        sw	$t2, TRISE($t1)		# 
        
        lw	$t2, TRISD($t1)		#0000 0001 0000 0000 
        ori	$t2, $t2, 0x0100
        sw      $t2, TRISD($t1)		# 
         
while:  lw      $t2, PORTD($t1)
        not     $t2, $t2
        andi    $t2, $t2, 0x0100        #0000 000x 0000 0000 
        srl     $t2, $t2, 8     

        lw      $t3, LATE($t1)              
        andi    $t3, $t3, 0xFFFE

        or      $t3, $t3, $t2
        sw      $t3, LATE($t1)
        j	while				# jump to while
        

        jr      $ra
