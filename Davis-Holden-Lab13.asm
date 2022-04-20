#Holden Davis
#Lab 12
#
#My lord I did a shoddy job here but it technically works!
#After prompting the user for an integer, allocate that much space on the heap
#Then, iterate through the space by 4 bytes at a time (because integers), generate a pseudorandom number <= 100, insert it at that address, and the print it. Rinse and repeat

.data
Prompt: .asciiz "What is the size of the array to be created? "
Element: .asciiz "Element: "
.text
main:
	#Prompt for integer, and allocate heap memory with size of returned prompt value
	la $a0, Prompt
	jal PromptInt
	move $a0, $v0
	li $v0, 9
	syscall
	move $a1, $v0
	#Begin iterating through array space starting at $a1 of $a0 elements, adding a pseudorandom integer, then printing it
	jal loop_start
	j Exit
loop_start:
	# Save ra on the stack
	addi $sp, $sp,-4
	sw $ra,0($sp)
  	# Save $a0 on the stack
	addi $sp, $sp,-4
	sw $a0,0($sp)
	# Save $a1 on the stack
	addi $sp, $sp,-4
	sw $a1,0($sp)
	
	#Initialize sentinel and address iterator
	li $t0, 1
	li $t2, 0
	mul $t2, $t0, 4
	add $t2, $t2, $a1
	
	#Instead of lw we do sw here with the pseudorandom then move it to a1 for printing with a0 as 'Element' string (PrintInt)
	#Save a1 and a0
	move $s7, $a1
	move $s6, $a0
	#Call for pseudorandom
	li $a0, 1
	li $a1, 100
	li $v0, 42
	syscall
	#a0 now contains the pseudorandom number we need to store in t2 (at this index in the array) so we store it
	sw $a0,($t2)
	#Now we need a1 to be the number for printint so load it back out into a1
	lw $a1,($t2)
	#Load the prompt
	la $a0, Element
	jal PrintInt
	move $a1, $s7
	move $a0, $s6	
	j loop_loop
loop_loop:
	#I don't know why I'm doing it like this
	move $s7, $a1
	move $s6, $a0
	jal PrintNewLine
	move $a1, $s7
	move $a0, $s6	
	
	#Exit condition (outside of boundary of allocated space
	bge $t0, $a0, loop_end
	#Update iterator
	li $t2, 0
	mul $t2, $t0, 4
	add $t2, $t2, $a1
	#Instead of lw we do sw here with the pseudorandom then move it to a1 for printing with a0 as 'Element' string (PrintInt)
	#Save a1 and a0
	move $s7, $a1
	move $s6, $a0
	#Call for pseudorandom
	li $a0, 1
	li $a1, 100
	li $v0, 42
	syscall
	#a0 now contains the pseudorandom number we need to store in t2 (at this index in the array) so we store it
	sw $a0,($t2)
	#Now we need a1 to be the number for printint so load it back out into a1
	lw $a1,($t2)
	#Load the prompt
	la $a0, Element
	jal PrintInt
	move $a1, $s7
	move $a0, $s6	
	addi $t0, $t0, 1
	j loop_loop	
loop_end:
	# pop #a1 off the stack
	lw $a1,0($sp)
	addi $sp, $sp, 4
	# pop #a0 off the stack
	lw $a0,0($sp)
	addi $sp, $sp, 4
	# pop $ra off the stack
	lw $ra,0($sp)
	addi $sp, $sp, 4
	#Return
	jr $ra
.include "utils.asm"
