	.data
	.eqv MAX_STUDENTS,4
	.eqv print_string,4
	.eqv print_float, 2
	.eqv print_int,36
	
str:	.asciiz	"\nMedia: "
str1:	.asciiz "\nN. Mec: "
str2:	.asciiz "\nPrimeiro Nome: "
str3:	.asciiz "\nUltimo Nome: "
str4:	.asciiz "\nNota: "
array:	.space 176
media:	.space 4
max_grade: .float -20.0
sum:	.float 0.0

	.text
	.globl main
	
main:	addiu	$sp,$sp,-4
	sw	$ra, 0($sp)

	la	$a0, array
	li	$a1, MAX_STUDENTS
	jal	read_data		#read_data(array, MAX_STUDENTS);
	
	la	$a0, array		
	li	$a1, MAX_STUDENTS
	l.s	$f12, media
	jal	max			#max(array, MAX_STUDENTS, &media);
	
	move	$t0, $v0		#pmax -> $t0
	
	la 	$a0, str
	li 	$v0, print_string
	syscall				#print_string("\nMedia: ")
	
	l.s	$f12, media		#media -> $f0 
	li 	$v0, print_float	#print_float(media)
	syscall
	
	move 	$a0, $t0		#pmax -> $a0
	jal	print_student		#print_student(pmax)
		
	lw	$ra, 0($sp)	
	addiu 	$sp,$sp,4	
	
	jr 	$ra
	
#___________________-----------------_____________________-------------________________------------_______________------------_____________________--------------
	
read_data:
	li	$t0, 0			#i -> $t0
	move	$t2, $a0
	move	$t3, $a1
	
for:	bge 	$t0, $t3, endF		#for(i = 0; i < ns; i++)

	mul	$t1, $t0, 44		#mul i por size da struct
	addu	$t1,$t1,$t2		#endereço inicial da estrutura
	
	la	$a0, str1
	li	$v0, print_string
	syscall				#print_string("N. Mec: ")
	
	li	$v0, 5
	syscall				#read_int()
	sw	$v0, 0($t1)		#st[i].id_number = read_int() 
	
	la	$a0, str2
	li	$v0, print_string
	syscall				#print_string("Primeiro Nome: ")
	
	li	$v0, 8	
	li	$a1, 17
	syscall				#read_string() (size = 17)
	sb 	$a0, 4($t1)		#st[i].first_name = read_string()
	
	la	$a0, str3
	li	$v0, print_string
	syscall				#print_string("Ultimo Nome: ")
	
	li	$v0, 8	
	li	$a1, 15
	syscall				#read_string() (size = 17)
	sb 	$a0, 22($t1)		#st[i].first_name = read_string()
	
	la	$a0, str4
	li	$v0, print_string
	syscall				#print_string("Nota: ")
	
	li	$v0, 6
	syscall				#read_float()
	s.s	$f0, 40($t1)		#st[i].grade = read_float()

	addi 	$t0,$t0,1		#i++

endF:	jr 	$ra
	
#___________________-----------------_____________________-------------________________------------_______________------------_____________________--------------	
	
max:	addu	$t0, $a0, $a1	
	move	$t4, $a1	
for1:	bge	$a0,$t0, endF1

	l.s	$f0, 40($t0)
	
	la	$t2, sum
	l.s	$f2, 0($t2)
	
	la	$t3, max_grade
	l.s	$f4, 0($t3)
	
	add.s	$f2, $f2, $f0
	
if:	c.le.s $f0, $f4
	bc1t	endif
	
	s.s	$f4, 40($t0)
	move	$v0, $t0	
	
endif:	mtc1	$t4, $f8
	cvt.s.w	$f6, $f8
	div.s	$f12, $f2, $f6
	addi 	$t0,$t0,1
	
endF1:	jr	$ra
	
#___________________-----------------_____________________-------------________________------------_______________------------_____________________--------------	
	
print_student:
	move $t1, $a0
	lw	$a0,0($t1)
	li	$v0, print_int
	syscall
	
	lb	$a0, 4($t1)
	li	$v0, print_string
	syscall
	
	lb	$a0, 22($t1)
	li	$v0, print_string
	syscall
	
	l.s	$f12, 40($t1)
	li	$v0, print_float

	jr	$ra








