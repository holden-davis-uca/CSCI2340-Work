#Holden Davis
#Assignment 8

#I actually somehow found the time to do the challenge this time!

.data
	prompt1:	.asciiz "Enter First Float: "
	promptop:	.asciiz "Enter Operator: "
	prompt2:	.asciiz "Enter Second Float: "
	result:		.asciiz "Result = "
	invalid:	.asciiz "Invalid operator was entered."
	goodbye:	.asciiz "Goodbye."
	nl:		.asciiz "\n"

	AddOp: 		.byte '+'
	SubOp: 		.byte '-'
	MulOp: 		.byte '*'
	DivOp: 		.byte '/'
	QuitOp: 	.byte '&'
	PowOp: 		.byte '^'
	
	zero:		.float 0.0
	one:		.float 1.0

.text
#General program flow:
#	Continuously prompt for and read in the first float from the user and the operator
#		If operator is equivalent to QuitOp (&), jump to Exit
#	Otherwise, prompt for and read in the second float from the user
#	Evaluate operator and branch to relevant instruction
#	If at the end of all branch checks f0 == 0, no math was done and op was invalid; print message and jump to beginning 
main:
	#Prompt for and read first float; move from f0 to f12
	la $a0, prompt1
	jal PrintString
	li $v0, 6
	syscall
	mov.s $f12, $f0
	#Prompt for and read operand (character)
	la $a0, promptop
	jal PrintString
	li $v0, 12
	syscall
	lb $t9, QuitOp
	beq $v0, $t9, leave
	#Save op in $s7
	move $s7, $v0
	#Prompt for and read second float; move from f0 to f13
	jal PrintNewLine
	la $a0, prompt2
	jal PrintString
	li $v0, 6
	syscall
	mov.s $f13, $f0
	
	#Load zero into f0 to clear and begin checking
	lwc1 $f0, zero
	#Begin branch checking
	lb $t8, AddOp
	beq $s7, $t8, add
	lb $t7, SubOp
	beq $s7, $t7, sub 
	lb $t6, MulOp
	beq $s7, $t6, mul 
	lb $t5, DivOp
	beq $s7, $t5, div 
	lb $t4, PowOp
	beq $s7, $t4, pow 
	#Check if f0 is still zero (no math has been carried out) and branch to invalid op if so
	lwc1 $f28, zero
	c.eq.s $f0, $f28
	bc1t invalidop
add:
	jal addCalc
	j end
sub:
	jal subCalc
	j end
mul:
	jal mulCalc
	j end
div:
	jal divCalc
	j end
pow:
	jal powCalc
	j end

end:
	#Print result of calc and return to main
	la $a0, result
	jal PrintString
	li $v0, 2
	mov.s $f12, $f0
	syscall
	la $a0, nl
	li $v0, 4
	syscall
	j main

leave:
	jal PrintNewLine
	la $a0, goodbye
	jal PrintString
	j Exit

invalidop:
	la $a0, invalid
	li $v0, 4
	syscall
	j main

######################################################
#addCalc
#	Adds two floating point numbers
#Params:
#	$f12 - first floating point number
#	$f13 - second floating point number
#Returns:
#	$f0 - sum of $f12 and $f13
######################################################
addCalc:
	# Save ra on the stack
	addi $sp, $sp,-4
	sw $ra,0($sp)
	
	#Add f12 and f13 and return in f0
	add.s $f0, $f12, $f13
	
	#Pop $ra off the stack
	lw $ra,0($sp)
	addi $sp, $sp, 4
	#Leave
	jr $ra

######################################################
#subCalc
#	Subtracts two floating point numbers
#Params:
#	$f12 - first floating point number
#	$f13 - second floating point number
#Returns:
#	$f0 - difference of $f12 and $f13
######################################################
subCalc:
	# Save ra on the stack
	addi $sp, $sp,-4
	sw $ra,0($sp)
	
	#Subtract f13 from f12 and return in f0
	sub.s $f0, $f12, $f13
	
	#Pop $ra off the stack
	lw $ra,0($sp)
	addi $sp, $sp, 4
	#Leave
	jr $ra

######################################################
#mulCalc
#	Multiplies two floating point numbers
#Params:
#	$f12 - first floating point number
#	$f13 - second floating point number
#Returns:
#	$f0 - product of $f12 and $f13
######################################################
mulCalc:
	# Save ra on the stack
	addi $sp, $sp,-4
	sw $ra,0($sp)
	
	#Multiply f12 by f13 and return in f0
	mul.s $f0, $f12, $f13
	
	#Pop $ra off the stack
	lw $ra,0($sp)
	addi $sp, $sp, 4
	#Leave
	jr $ra

######################################################
#divCalc
#	Divides two floating point numbers
#Params:
#	$f12 - first floating point number
#	$f13 - second floating point number
#Returns:
#	$f0 - quotient of $f12 and $f13
######################################################
divCalc:
	# Save ra on the stack
	addi $sp, $sp,-4
	sw $ra,0($sp)
	
	#Divide f12 by f13 and return in f0
	div.s $f0, $f12, $f13
	
	#Pop $ra off the stack
	lw $ra,0($sp)
	addi $sp, $sp, 4
	#Leave
	jr $ra
	
######################################################
#powCalc
#	Computes a number to the power of another
#Params:
#	$f12 - first floating point number
#	$f13 - second floating point number
#Returns:
#	$f0 - f12 to the power of f13
######################################################
powCalc:
	# Save ra on the stack
	addi $sp, $sp,-4
	sw $ra,0($sp)
	
	#Compute f12 to the power of f13 and return in f0
	#Iterator
	li $t0, 0
	#Init f0 to 1 for multiplication's sake
	lwc1 $f0, one
	#Move limit for multiplications to t1 for comparison with iterator in beq
	cvt.w.s $f13, $f13
	mfc1 $t1, $f13
	powLoop:
		beq $t0, $t1, powExit
		mul.s $f0, $f0, $f12
		addi $t0, $t0, 1
		j powLoop

powExit:	
	#Pop $ra off the stack
	lw $ra,0($sp)
	addi $sp, $sp, 4
	#Leave
	jr $ra
	
.include "utils.asm"
