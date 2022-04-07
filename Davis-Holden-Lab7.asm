#Holden Davis
#Lab 7

#Premise is as follows:
#	Load miles and gallons values from memory
#	Do the division, store the result back into a memory value
#	Retrieve the memory value, print the output prompt and then print the value

.data
out: .asciiz "Your mpg is "
miles: .word 400
gallons: .word 15
mpg: .word

.text
main:

#Load miles and gallons into t0 and t1 respectively
lw $t0, miles
lw $t1, gallons

#Perform division of miles / gallons and store in t2
div $t2, $t0, $t1

#Store resulting value in mpg word
sw $t2, mpg

#Print out
li $v0, 4
la $a0, out
syscall

#Print resulting mpg
lw $a0, mpg
li $v0, 1
syscall

#Exit
li $v0, 10
syscall