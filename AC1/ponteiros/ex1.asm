
##define SIZE 20
# void main(void)
# {
#   static char str[SIZE+1];
#   char *p;

#   print_string("Introduza uma string: ");
#   read_string(str, SIZE);
#   p = str;

#   while (*p != '\0')
#   {
#       *p = *p – 'a' + 'A'; // 'a'=0x61, 'A'=0x41, 'a'-'A'=0x20
#       p++;
#   }
#   print_string(str);
# }


	.data
	.eqv SIZE, 21
	.eqv print_String, 4
	.eqv readString, 8
str:	.space SIZE
str2:	.asciiz "Introduza uma string: \n"
	.text
	.globl main

main:	la $a0, str2	
	li $v0, print_String
	syscall

	la $a0, str
	li $a1, SIZE
	
	li $v0, readString
	syscall
	
	
	
	la $t0, str 	# p = str
while: 	
	lb $t1, 0($t0) 	# *p 
	
	beq $t1,'\0',endw
	sub $t1,$t1,'a'
	addi $t1,$t1,'A'
	sb $t1,0($t0)
	addi $t0,$t0,1	
	j while		
endw:	
	la $a0, str	
	li $v0, print_String
	syscall		
	jr $ra		
						
							
								
									
											
	
