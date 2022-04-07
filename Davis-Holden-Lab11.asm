#Holden Davis
#Lab 11

.text
main:
	#Load all variables defined in data (except strings)
	lw $a0, g
	lw $a1, h
	lw $a2, i
	lw $a3, x
	lw $s0, test
	lw $s1, test2
	lw $s2, test3
	#With a0, a1, a2, and a3 loaded, jal to sum_proc, receiving v0 as the result in return
	jal sum_proc
	#Load retprompt and printstring
	la $a0, retprompt
	move $a1, $v0
	jal PrintInt
	#Now, load and print the labels and ints for s0, s1, and s2 respectively
	#A couple of printnewline just for formatting
	jal PrintNewLine
	la $a0, s0
	move $a1, $s0
	jal PrintInt
	jal PrintNewLine
	la $a0, s1
	move $a1, $s1
	jal PrintInt
	jal PrintNewLine
	la $a0, s2
	move $a1, $s2
	jal PrintInt
	j Exit

####################
#sum_proc
#Performs f = g + h, k = (i + x) * 2 and sum = f + k
#Input:
#	a0 = g, a1 = h, a2 = i, a3 = x
#Output:
#	v0 = sum
####################	
sum_proc:

	#push s0, s1, and s2 onto the stack
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	addi $sp, $sp, -4
	sw $s1, 0($sp)
	addi $sp, $sp, -4
	sw $s2, 0($sp)
	# f = g + h >>> t0 = a0 + a1
	add $t0, $a0, $a1
	# k = i + x >>> t1 = a2 + a3
	add $t1, $a2, $a3
	# k = k * 2 >>> t1 = t1 * 2
	li $t8, 2
	mul $t1, $t1, $t8
	# sum = f + k >>> $t8 = $t0 + $t1
	add $t8, $t0, $t1
	#All math is done, now $t8 has the solution
	move $v0, $t8
	#pop s0, s1 and s2 off the stack
	lw $s2, 0($sp)
	addi $sp, $sp, 4
	lw $s1, 0($sp)
	addi $sp, $sp, 4
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	#Return
	jr $ra


.data
	g:	.word 10
	h:	.word 15
	i:	.word 3
	x:	.word 2
	test:	.word 56
	test2:	.word 78
	test3:	.word 91
	retprompt: .asciiz "Returned value = "
	s0: .asciiz "s0 = "
	s1: .asciiz "s1 = "
	s2: .asciiz "s2 = "
	

.include "utils.asm"