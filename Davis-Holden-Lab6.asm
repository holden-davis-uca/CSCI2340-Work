#Holden Davis
#Lab 6

#Prints "Hello World", a newline character, and "Goodbye", then exits

.data
entry: .asciiz "Hello World"
nl: .asciiz "\n"
end: .asciiz "Goodbye!"

.text
main:
jal Hello
jal PrintNewLine
jal Goodbye
j exit

##########################################
#Hello: Prints Hello World
#Parameters:
#	None
#Returns:
#	None
##########################################
Hello:
la $a0, entry
li $v0, 4
syscall
jr $ra
##########################################
#PrintNewLine: Prints a new line character
#Parameters:
#	None
#Returns:
#	None
##########################################
PrintNewLine:
la $a0, nl
li $v0, 4
syscall
jr $ra
##########################################
#Goodbye: Prints Goodbye
#Parameters:
#	None
#Returns:
#	None
##########################################
Goodbye:
la $a0, end
li $v0, 4
syscall
jr $ra

##########################################
#Goodbye: Exits
#Parameters:
#	None
#Returns:
#	None
##########################################
exit: 
li $v0, 10
syscall