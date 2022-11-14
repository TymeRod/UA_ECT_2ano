#define SIZE 10
#define TRUE 1
#define FALSE 0
#void main(void)
#{
#	static int lista[SIZE];
#	int houveTroca, i, aux;
#	// inserir aqui o código para leitura de valores e
#	// preenchimento do array
#	for(...)
#	{
#		...
#	}
#	pUltimo = lista + (SIZE - 1);
#	do	
#	{
#		houveTroca = FALSE;
#		for (p = lista; p < pUltimo; p++)
#		{
#			if (*p > *(p+1))
#			{
#				aux = *p;
#				*p = *(p+1);
#				*(p+1) = aux;
#				houveTroca = TRUE;
#			}
#		}
#	} while (houveTroca==TRUE);
#	// inserir aqui o código de impressão do conteúdo do array
#	for(...)
#	{
#	...
#	}
#}

# Mapa de registos
# i: $t0
# lista: $t1
# lista + i: $t2
# houve_troca: $t4
# p: $t5
# pUltimo: $t6

	.data
	.eqv SIZE,5
str: 	.asciiz "\nIntroduza um numero: "
str1: 	.asciiz "; "
str2:	.asciiz "\nConteudo do array:\n"
	.align 2
lista:	.space SIZE # SIZE * 4
	.eqv read_int,5
	.eqv print_str, 4
	.eqv print_int10, 1
	.eqv FALSE,0
	.eqv TRUE,1
	.text
	.globl main
	
main:	li $t0,0

for: 	bge $t0,SIZE,endf

	la $a0, str
	li $v0, print_str
	syscall
	
	li $v0,read_int
	syscall
	
	la $t1, lista
	sll $t2,$t0,2
	addu $t2,$t2,$t1
	sw $v0, 0($t2)

	addi $t0,$t0,1
	j for
endf:
	
do:	
	li $t4, FALSE
	la $t5, lista
	li $t6, SIZE
	subu $t6, $t6,1
	sll $t6,$t6,2
	addu $t6,$t6,$t5

for2:	bge $t5,$t6,endf2

if:	
	lw $t7,0($t5)
	lw $t8,4($t5)

	ble $t7,$t8,endif
	
	sw $t7, 4($t5)
	sw $t8, 0($t5)
	
	li $t4,TRUE
	j endif
	
endif:
	addiu $t5,$t5,4
	j for2
	
endf2:
	bne $t4,TRUE,enddo
	j do
enddo:


	la $a0, str2
	li $v0, print_str
	syscall
	
	la $t0, lista
	li $t2, SIZE
	sll $t2, $t2, 2
	addu $t2,$t2,$t0

for3:	bgeu  $t0,$t2,endf3
	lw $t1,0($t0)
	
	move  $a0, $t1 
	li $v0, print_int10
	syscall
	
	la $a0, str1
	li $v0, print_str
	syscall
	
	addiu $t0,$t0,4
	
	j for3
	
endf3:	jr $ra
	






