		.equ BASE,  0xBF88          # 16 MSbits of SFR area
		.equ TRISE, 0x6100          # TRISE address is 0xBF886100
		.equ LATE,  0x6120          # LATE address is 0xBF886120
		.equ TRISB,	0x6040
		.equ PORTB,	0x6050

        .text
        .globl main

main:   lui     $t0, BASE
        lw      $t1, TRISE($t0)
        andi    $t1, $t1, 0xFFF0    #1111 1111 1111 0000 
        sw      $t1, TRISE($t0)

        lw      $t1, TRISB($t0)
        ori     $t1, $t1, 0x000F    #0000 0000 0000 1111 
        sw      $t1, TRISB($t0)

loop:   lw      $t2, PORTB($t0)
        andi    $t2, $t2, 0x000F    #0000 0000 0000 xxxx

        lw      $t3, LATE($t0)
        andi    $t3, $t3, 0xFFF0    #xxxx xxxx xxxx 0000

        or      $t3, $t3, $t2
        

        sw      $t3, LATE($t0)
        j       loop
    
        jr      $ra


                                
        