#define SIZE 4
#int array[4] = {7692, 23, 5, 234}; // Declara um array global de 4 posições e inicializa-o
#void main (void){
#
#    int soma = 0;
#    int i;
#
#    for(i = 0; i < SIZE; i++){
#        soma = soma + array[i];
#    }
#                   
#    print_int10(soma);
#}	
	
#Mapa de registo	
#soma: $t0
#i: $t1
#array[i]: $t2
#array + i: $t3


		.data
array:		.word 7692,23,5,234
		.eqv print_int10,1
		.eqv SIZE,4
		.text
		.globl main
	
main: 		li 	$t0,0 			# soma = 0;						
		li 	$t1,0			# i = 0;
while: 	
		bge    	$t1,SIZE,endw 		# {
		la 	$t3,array
		mul 	$t4,$t1,4
		add	$t3,$t3,$t4
		lw 	$t2,0($t3)
		add 	$t0,$t0,$t2
		addi	$t1,$t1,1
		j	while
endw:						# }
		move $a0,$t0 
		li $v0,print_int10
		syscall				# print_int10(soma);
		jr $ra 				# termina o programa
