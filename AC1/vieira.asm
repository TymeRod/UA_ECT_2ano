    .eqv    SIZE, 10
    .eqv    TRUE, 1
    .eqv    FALSE, 0
    .eqv    PRINT_INT10, 1
    .eqv    PRINT_STR, 4
    .eqv    READ_INT, 5
    
    .data
    
str:    .asciiz    "\nIntroduza um numero: "
str1:    .asciiz    "\nConteudo do array:\n"
str2:    .asciiz "; "
str4:    .asciiz "\n"
    .align    2
lista:    .space    40

    .text
    .globl    main
    
# Mapa de registos
# p: $t0
# *p: $t1
# lista + SIZE: $t2
# SIZE - 1: $t3
# houve_troca: $t4
# i: $t5
# lista: $t6
# lista + i: $t7
main:
    li    $t5, 0            # i = 0
    
while:
    bge    $t5, SIZE, endw
    
    li    $v0, PRINT_STR
    la    $a0, str
    syscall                # print_str('...')
    
    li    $v0, READ_INT
    syscall                # read_int
    
    la    $t6, lista        # $t6 = lista
    sll    $t7, $t5, 2
    addu    $t7, $t6, $t7
    
    sw    $v0, 0($t7)
    addi    $t5, $t5, 1        # i++
    
    j    while
endw:

do:
    li    $t4, FALSE        # houve_troca = false
    li    $t5, 0            # i = 0
    li    $t3, SIZE        # $t3 = SIZE
    subu    $t3, $t3, 1        # $t3 = SIZE - 1
    
for:
    bge    $t5, $t3, efor

if:
    sll    $t7, $t5, 2        # $t7 = i * 4
    addu    $t7, $t7, $t6        # $t7 = &lista[i]
    
    lw    $t8, 0($t7)        # $t8 = lista[i]
    lw    $t9, 4($t7)        # $t9 = lista[i+1]
    
    ble    $t8, $t9, endif
    
    sw    $t8, 4($t7)        # lista[i+1] = $t8
    sw    $t9, 0($t7)        # lista[i] = $t9
    li    $t4, TRUE
    
    j    endif    
    
endif:
    addi    $t5, $t5, 1
    j    for    
    
efor:
    bne    $t4, TRUE, edo
    j    do
    
edo:
    li    $v0, PRINT_STR
    la    $a0, str1
    syscall                # print_string('...')
    
    la    $t0, lista        # p = lista
    li    $t2, SIZE
    sll    $t2, $t2, 2
    addu    $t2, $t0, $t2        # $t2 = lista + SIZE
    
while1:
    bgeu    $t0, $t2, ewhile1
    lw    $t1, 0($t0)        # $t1 = *p

    li    $v0, PRINT_INT10
    move    $a0, $t1
    syscall                # print_int10( *p )
    
    li    $v0, PRINT_STR
    la    $a0, str2
    syscall                # print_string('...')
    
    addiu    $t0, $t0, 4
    
    j    while1
ewhile1:
    jr    $ra