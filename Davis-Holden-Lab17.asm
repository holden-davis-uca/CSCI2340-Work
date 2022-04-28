#Holden Davis
#Lab 17

.data
	.align 2
	jumptable: .word case0, case1, case2, case3
	
	a: .word 0
	b: .word 10
	c: .word 5
	d: .word 9
	e: .word 7

	prompt: .asciiz "Please enter a value for k: "
	return: .asciiz "The value of a is: "

.text
main:
	#Print the initial prompt
	la $a0, prompt
	jal PrintString
	#Read in integer input for k and store in $s1
	li $v0, 5
	syscall
	move $s1, $v0
	blt $s1, $zero, Exit
	bgt $s1, 3, Exit
	#Init s0
	li $s0, 32
	la $s3, jumptable
	sll $t0, $s1, 2
	add $t1, $s3, $t0
	lw $t2, 0($t1)
	jr $t2
	case0:
		lw $t2, b
		lw $t3, c
		add $t4, $t2, $t3
		sw $t4, a
		j output
	case1:
		lw $t2, d
		lw $t3, e
		add $t4, $t2, $t3
		sw $t4, a
		j output
	case2:
		lw $t2, d
		lw $t3, e
		sub $t4, $t2, $t3
		sw $t4, a
		j output
	case3:
		lw $t2, b
		lw $t3, c
		sub $t4, $t2, $t3
		sw $t4, a
		j output
output:
	la $a0, return
	lw $a1, a
	jal PrintInt
	j Exit

.include "utils.asm"