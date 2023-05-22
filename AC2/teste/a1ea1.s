    .equ    UP, 1
    .equ    DOWN, 0
    .equ    putChar,3
    .equ    printInt,6
    .equ    inkey,1

    .data
    .text
    .globl main

main:   
    addiu   $sp,$sp, -12
    sw		$ra, 0($sp)		#
    sw      $s0, 4($sp) 
    sw      $s1, 8($sp)


    li  $s0, 0  #state = 0
    li  $s1, 0  #cnt = 0

do: 
    la  $a0, '\r'
    li  $v0, putChar
    syscall

    move    $a0, $s1
    li  $a1, 0x0003000A
    li  $v0, printInt
    syscall

    la  $a0, '\t'
    li  $v0, putChar
    syscall

    move    $a0, $s1
    li  $a1, 0x00080002
    li  $v0, printInt
    syscall

    li  $a0, 5
    jal		wait				# jump to wait and save position to $ra

    li  $v0, inkey
    syscall

    

if: 
    bne		$v0, '+', if2	
    li      $s0, UP


if2:
    bne     $v0, '-', if3
    li      $s0, DOWN

if3:
    bne     $s0, UP, else
    addi    $s1, $s1, 1
    andi	$s1, $s1, 0xFF			
    j		endIf				# jump to endIf
    
else:
    sub	    $s1, $s1, 1			
    andi	$s1, $s1, 0xFF			
    
endIf:
    bne		$v0, 'q', do	

    lw		$ra, 0($sp)		#
    lw      $s0, 4($sp) 
    lw      $s1, 8($sp)
    addiu   $sp,$sp,12

    li  $v0, 0

    jr  $ra


    

wait:
    li  $t0, 0  
    mul $a0, $a0, 515000
    
while:
    bge		$t0, $a0, endW	# if $t0 >= $t1 then goto target
    addi	$t0, $t0, 1			# $t0 = $t0 + 1
    j while
endW:
    jr  $ra
    