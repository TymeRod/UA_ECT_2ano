        .equ BASE, 0xBF88
        .equ TRISE, 0x6100
        .equ LATE,  0x6120
        
        .equ    PRINT_INT, 6
        .equ    PUT_CHAR, 3
        .equ    RESET_CORE_TIMER, 12
        .equ    READ_CORE_TIMER, 11

        .text
        .globl main


main:   addiu   $sp, $sp, -8
        sw      $ra, 0($sp)
        sw      $s0, 0($sp)

        lui     $t0, BASE

        lw      $t1, TRISE($t0)
        andi    $t1, $t1, 0xFFE1        #1111 1111 1110 0001
        sw		$t1, TRISE($t0)         # 
        
        li		$s0, 0b1001             # pattern

loop:   sll		$t1, $s0, 1			    # pattern << 1
        lw      $t2, LATE($t0)
        andi    $t2, $t2, 0xFFE1
        or		$t2, $t2, $t1		
        sw      $t2, LATE($t0)          #(LATE & 0xFFE1) ! pattern << 1

        li		$a0, '\r'
        li      $v0, PUT_CHAR
        syscall

        move 	$a0, $s0
        li      $a1, 4
        sll     $a1, $a1, 16
        ori		$a1, $a1, 2			
        li      $v0, PRINT_INT
        syscall                         #printInt(pattern, 2 | 4 << 16)

        not     $s0, $s0                #pattern = !pattern    !(0000 0000 0000 1001) = (1111 1111 1111 0110)
        andi    $s0, $s0, 0x000F        #pattern = pattern & 0x000F     pattern = (0000 0000 0000 0110)

        li      $a0, 143
        jal     delay   

        j       loop

        lw      $s0, 4($sp)
        lw      $ra, 0($sp)
        addiu   $sp, $sp, 8


        jr      $ra


delay:  li  $v0, RESET_CORE_TIMER
        syscall

        li  $t0, 20000
        mul $t0, $t0, $a0

while:  li  $v0, READ_CORE_TIMER
        syscall
        bge $v0, $t0, endW
        j while
endW:   jr		$ra	



        
