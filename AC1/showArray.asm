#define SIZE 10
#void main(void)
#{
#	static int lista[]={8, -4, 3, 5, 124, -15, 87, 9, 27, 15};
#	int *p; // Declara um ponteiro para inteiro (reserva
#	// espaço para o ponteiro, mas não o inicializa)
#	print_string("\nConteudo do array:\n");
#	for(p = lista; p < lista + SIZE; p++)
#	{
#		print_int10( *p ); // Imprime o conteúdo da posição do
#		// array cujo endereço é "p"
#		print_string("; ");
#	}
#}

# Mapa de registos
# p: $t0
# *p: $t1
# lista+Size: $t2

	.data
str1: 	.asciiz "; "
str2:	.asciiz "\nConteudo do array:\n"

lista:	.word 8,-4,3,5,124,-15,87,9,27,15

	.eqv print_int10, 1
	.eqv print_string, 4
	.eqv SIZE, 10
	.text
	.globl main
	
main:	la $a0, str2
	li $v0, print_string
	syscall
	
	la $t0, lista
	li $t2, SIZE
	sll $t2, $t2, 2
	addu $t2,$t2,$t0

for:	bgeu  $t0,$t2,endf
	lw $t1,0($t0)
	
	move  $a0, $t1 
	li $v0, print_int10
	syscall
	
	la $a0, str1
	li $v0, print_string
	syscall
	
	addiu $t0,$t0,4
	
	j for
	
endf:	jr $ra
	
	
	
	
	
	
	
	