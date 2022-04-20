#Holden Davis
#Lab 15

.data
hourlyRate: 		.float 10.5
constantExpense: 	.float 315.30
prompt:			.asciiz "Please enter the number of hours: "
result:			.asciiz "The total expenses are "

.text
main:
	la $a0, prompt
	jal PrintString
	
	li $v0, 5
	syscall
	move $a1, $v0
	
	la $a0, result
	jal PrintString
	
	move $a0, $a1
	jal calcExp
	li $v0, 2
	mov.s $f12, $f0
	syscall
	
	j Exit

#####################################################
#calcExp
#Params:
#	$a0 - integer representing number of hours
#Returns:
#	$f0 - float representing total expenses
#####################################################
calcExp:
	mtc1 $a0, $f2
	cvt.s.w $f2, $f2
	#Load vals from mem loc in fpu (coproc 1)
	lwc1 $f0, hourlyRate
	lwc1 $f1, constantExpense
	#Hourly rate * number of hours
	mul.s $f3, $f0, $f2
	#That + constant expense
	add.s $f3, $f3, $f1
	#return in $f0
	mov.s $f0, $f3
	jr $ra

.include "utils.asm"