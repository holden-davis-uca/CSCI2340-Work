#Holden Davis
#Assignment 5


#	NOTE: Wow, I actually cannot figure this one out. I'm definintively certain that I'm overthinking this or missing something obvious, but I've rewritten it from scratch several times now and I've lots of other homework and deadline
#	      is approaching fast, so I'll have to the take the L on this one. Very dissapointed in myself.


#Continuously prompt user for integer
#While user input > 0, print triangle
#Using various subroutines from utils.asm

# int n = input("Please enter the edge length of the base of right triangle: ");
# for (int i = 0; i < n; i++)
#{
#	for (int j = 1; j < n; i++)
#	{
#		print("#");
#	}
#}

.text
main:
	#Load prompt to $a0, call PromptInt, $v0 contains resulting integer, move it to $s0
	la $a0, prompt
	jal PromptInt
	move $a0, $v0

	#If $a0 >= 0, printTriangle, otherwise exit
	bgtz $a0, printTriangle
	j fancyExit

##################################################################
#printTriangle: Given user input x, print x levels of triangle from 1 to x
#Parameters:
#	$a0 - edge length of base of right triangle (integer)
#Returns: 
#	None
#This one will be somewhat funky - we use two for loops: the first (outer) is to print the number of layers and the second (the inner) is to print the number of "#" symbols
##################################################################
printTriangle:
	#OUTER LOOP START
	#Move x from a0 to a1 so its not overwritten
	move $a1, $a0
	#Load the incrementer value (int i = 0) into s0
	li $s0, 0
	#Label for starting loop
	start:
		#As long as s0 is less than a1 (i < n), set t1 to 1, otherwise set t1 to 0
		slt $t1, $s0, $a1
		#If s0 >= n (i < n condition no longer valid), branch to end and leave immediately
		beqz $t1, end
		#INNER LOOP START
		#Load the incrementer value (int j = 0) into s1
		li $s1, 0
		#Label for starting loop
		startinner:
			#As long as s1 is less than a1 (j < n), set t2 to 1, otherwise set t2 to 0
			slt $t2, $s1, $a1
			#If s1 >= s0 (j < i condition no longer valid), branch to end and leave immediately
			beqz $t2, endinner
			#Otherwise, load the hash string and print string
			la $a0, hash
			move $s2, $ra
			jal PrintString
			move $ra, $s2
			#Increment variable
			addi $s1, $s1, 1
			#Branch back around to start
			b startinner
		endinner:
			#If we have arrived here, we can print new line
			move $s2, $ra
			jal PrintNewLine
			move $ra, $s2
			j main
		#INNER LOOP END
		#Increment s0 (i++)
		addi $s0, $s0, 1
		#Branch back around to start
		b start
	end:
	#Leave and go back to main
		j main
	#OUTER LOOP END
	
##################################################################
#fancyExit: Exit after printing string to match assignment instructions
#Parameters:
#	None
#Returns: 
#	None
##################################################################
fancyExit:
	la $a0, quit
	move $s1, $ra
	jal PrintString
	move $ra, $s1
	j Exit

.data
prompt: .asciiz "Please enter the edge length of the base of right triangle: "
quit: .asciiz "Exiting the program."
hash: .asciiz "#"

.include "utils.asm"
