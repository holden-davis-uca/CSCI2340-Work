#Holden Davis
#Assignment 7

.data

strpromptL: 	.asciiz "Enter a string to convert to lowercase: "
strpromptU: 	.asciiz "\nEnter a string to convert to uppercase: "
resultstr: 	.asciiz "The converted string is: "
numtrans: 	.asciiz "The number of translations is: "
bigA: 		.byte 'A'
bigZ: 		.byte 'Z'
smallA:		.byte 'a'
smallZ: 	.byte 'z'

.align 2

instring: .space 100
maxSize: .word 100
outstring: .space 100

.text

main:
	#Prompt for string to convert lowercase
	la $a0, strpromptL
	jal PrintString
	#Read in string response
	la $a0, instring
	lw $a1, maxSize
	li $v0, 8
	syscall
	#Setup parameters and call tolow
	la $a0, instring
	la $a1, outstring
	jal tolow
	move $s0, $v0
	#Print label for converted string
	la $a0, resultstr
	jal PrintString
	#Print result string
	la $a0, outstring
	jal PrintString
	#Print the number of translations and its label
	la $a0, numtrans
	move $a1, $s0
	jal PrintInt
	
	#Prompt for string to convert to uppercase
	la $a0, strpromptU
	jal PrintString
	#Read in string response
	la $a0, instring
	lw $a1, maxSize
	li $v0, 8
	syscall
	#Setup parameters and call tolow
	la $a0, instring
	la $a1, outstring
	jal toup
	move $s0, $v0
	#Print label for converted string
	la $a0, resultstr
	jal PrintString
	#Print result string
	la $a0, outstring
	jal PrintString
	#Print the number of translations and its label
	la $a0, numtrans
	move $a1, $s0
	jal PrintInt	
		
	#Leave
	j Exit

#################################################################
#tolow
#
#Converts string to all lowercase characters
#Parameters:
#	a0 - memory location of string to convert
#	a1 - memory address of resultant string
#Returns:
#	v0 - number of converted characters
#################################################################
tolow:
    	# Save ra on the stack
	addi $sp, $sp,-4
	sw $ra,0($sp)
	
	lb $t6, bigA			#load lowerA into t6
	lb $t7, bigZ			#Load lowerZ into t7
	
	li $t2,0 			#init array index
	li $s7, 0			#Init number of converted characters
	j tolowloop
tolowloop:
	add $t0,$t2,$a0 		#Address + current array index = t0
	lb $t1,($t0) 			#Load byte into t1
	beq $t1,$zero,tolowend		#if t1 = 0 (null terminated, string over), leave
	#If character is NOT uppercase, branch to NOT convert
	bgt $t1, $t7, tolownochange	#If character greater than bigZ, branch
	blt $t1, $t6, tolownochange	#If character less than bigA, branch
	or $t1, $t1, 0x20		#Convert to lowercase
	add $t0, $t2, $a1		#t0 = resultant string at current index
	sb $t1, ($t0)			#Store the byte t1 there
	addi $s7, $s7, 1		#increment character converted count
	addi $t2,$t2,1 			#Increment index
	j tolowloop

tolownochange:
	add $t0, $t2, $a1		#t0 = resultant array at current index
	sb $t1, ($t0)			#Store byte t1 there
	addi $t2,$t2,1 			#Increment index
	j tolowloop

tolowend:
	# pop $ra off the stack
	lw $ra,0($sp)
	addi $sp, $sp, 4
	move $v0,$s7 			#Move number of conv. characters to v0 for return and leave
	jr $ra

#################################################################
#toup
#
#Converts string to all uppercase characters
#Parameters:
#	a0 - memory location of string to convert
#	a1 - memory address of resultant string
#Returns:
#	v0 - number of converted characters
#################################################################
toup:
    	# Save ra on the stack
	addi $sp, $sp,-4
	sw $ra,0($sp)
	
	lb $t6, smallA			#load smallA into t6
	lb $t7, smallZ			#Load smallZ into t7
	
	li $t2,0 			#init array index
	li $s7, 0			#Init number of converted characters
	j touploop
touploop:
	add $t0,$t2,$a0 		#Address + current array index = t0
	lb $t1,($t0) 			#Load byte into t1
	beq $t1,$zero,toupend		#if t1 = 0 (null terminated, string over), leave
	#If character is NOT lowercase, branch to NOT convert
	bgt $t1, $t7, toupnochange	#If character greater than smallZ, branch
	blt $t1, $t6, toupnochange	#If character less than smallA, branch
	xor $t1, $t1, 0x20		#Convert to uppercase
	add $t0, $t2, $a1		#t0 = resultant string at current index
	sb $t1, ($t0)			#Store the byte t1 there
	addi $s7, $s7, 1		#increment character converted count
	addi $t2,$t2,1 			#Increment index
	j touploop

toupnochange:
	add $t0, $t2, $a1		#t0 = resultant array at current index
	sb $t1, ($t0)			#Store byte t1 there
	addi $t2,$t2,1 			#Increment index
	j touploop

toupend:
	# pop $ra off the stack
	lw $ra,0($sp)
	addi $sp, $sp, 4
	move $v0,$s7 			#Move number of conv. characters to v0 for return and leave
	jr $ra

.include "utils.asm"
