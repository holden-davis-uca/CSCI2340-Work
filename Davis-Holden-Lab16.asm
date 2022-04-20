#Holden Davis
#Lab 16

.data
fahrenheit: 	.float 72.0
thirtytwo: 	.float 32.0
five: 		.float 5.0
nine:		.float 9.0
onehundred:	.float 100.0
zero:		.float 0.0
msg:		.asciiz "The temperature in Celsius is: "
prompt:		.asciiz "Please enter temperature in Fahrenehit: "
boil:		.asciiz "You could boil water."
freeze:		.asciiz "You could freeze water."
nl:		.asciiz "\n"

.text

main:
	la $a0, prompt
	jal PrintString
	
	li $v0, 6
	syscall
	
	la $a0, msg
	jal PrintString
	
	mov.s $f12, $f0
	jal calcC
	li $v0, 2
	mov.s $f12, $f0
	syscall
	
	la $a0, nl
	jal PrintString
	
	lwc1 $f30, onehundred
	lwc1 $f28, zero
	c.le.s $f12, $f28
	bc1t freezer
	c.le.s $f30, $f12
	bc1t boiler

#####################################################
#calcC
#Params:
#	$f12 - float representing fahrenheit
#Returns:
#	$f0 - float representing Celsius
#####################################################

calcC: 
	lwc1 $f18, thirtytwo
	lwc1 $f19, five
	lwc1 $f20, nine
	
	div.s $f4, $f19, $f20 #f4 now has 5.0 / 9.0
	sub.s $f0, $f12, $f18 #f0 now has F - 32.0
	mul.s $f0, $f0, $f4 #f0 now has f-32.0 * 5.0/9.0
	
	jr $ra	

boiler:
	la $a0, boil
	jal PrintString
	j Exit

freezer:
	la $a0, freeze
	jal PrintString
	j Exit

.include "utils.asm"
