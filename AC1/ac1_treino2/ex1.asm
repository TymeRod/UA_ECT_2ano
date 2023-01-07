# Mapa de registos
# rv : $t4
# n  : $t3
# sum: $t0
# nit: $t1
# pt :    $t2 

   	.data
    	.eqv    Size, 8
list:   .space 32
str:    .asciiz "Media invalida!\n"
    	.text
    	.globl main
      
                    
main:   li	$t0, 0            	#sum = 0
    	li	$t1, 0           	#nit = 0    
    	la	$t2, list       	#pt = list
   	addiu	$t5, $t2, 32
    
for:    bge    	$t2, $t5, endF        	#for(pt < (list + Size))

   	li    	$v0, 5
    	syscall                		#read_int()
    
    	sw    	$v0, 0($t2)       	#*pt = read_int()
        
    	addi   	$t2, $t2, 4        	#pt++
    
    	j    	for
    
endF:  	li   	$t3, 0            	#n = 0
    	la    	$t2, list        		#
    
for1:	bge    	$t3, Size, endF1   	#for(n < SIZE)
    	sll    	$t6, $t3, 2        	#
    	addu   	$t6,$t6,$t2       	#list + n
    
    	lw    	$t7, 0($t6)        	#lsit[n]
    
if:    	bltz    $t7, endIf        	#if(list[n] >= 0)
    	add    	$t0,$t0,$t7        	#sum += list[n]
    	addi    $t1,$t1,1        	#nit++
    
endIf:	addi    $t3,$t3,1        	#pt++
    	j    	for1           	 	#
endF1:    
                    			#
if1:	blez    $t1, else1        	#if(nit > 0)
    	div    	$t8, $t0, $t1        	#sum/nit
   	move   	$a0, $t8       	 	#
    	li    	$v0, 1            	#
    	syscall                		#print_int10(sum / nit)
    	li    	$v0, 0            	#rv = 0
     	j    	endIf1            	#
 
else1:	la    	$a0, str        	#str = "Media invalida!\n"
    	li    $v0, 4            	#
    	syscall               	 	#print_string(str)
    	li    $v0, -1            	#rv = -1
 
endIf1:	jr    $ra  