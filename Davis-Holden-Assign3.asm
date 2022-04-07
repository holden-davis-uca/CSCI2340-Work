#Holden Davis
#Assignment 3

#Premise is as follows:
#	Print the intro
#	Read in an integer
#	Convert it from seconds to minutes and print it
#	Convert it from seconds to hours and print it
#	Print a goodbye and exit
#Functions are used to print a message, read in the integer, perform both types of conversions, and print the integer after a message
#To avoid redundant code, getInt and printInt both call printMsg as part of their operations - these nested function calls can be accomplished by temporarily moving the $ra value before making a nested call via jal

.data
intro: .asciiz "Welcome to the time converter.\n"
outro: .asciiz "\nGoodbye!"
prompt: .asciiz "Enter the number of seconds: "
mins: .asciiz "Number of minutes: "
hrs: .asciiz "\nNumber of hours: "

.text
main:
#Say hello - load the introduction phrase and go to printMsg
la $a0, intro
jal printMsg
#Get integer - load the request phrase and go to getInt, then store it in $a0 for further usage
la $a0, prompt
jal getInt
move $a0, $v0
#Calculate minutes - go to calcMins and store return value in $s0, then temporarily move the original int to $s1
jal calcMins
move $s0, $v0
move $s1, $a0
#Print Minutes - load the minutes phrase and move the minute calc result to $a1 (both required params), then go to printInt
la $a0, mins
move $a1, $s0
jal printInt
#Calculate hours - move the original int back to $a0, then go to calcHours and move result to $s0
move $a0, $s1
jal calcHours
move $s0, $v0
#Print Hours - load the hours phrase and move the hours calc result to $a1 (both required params), then go to printInt
la $a0, hrs
move $a1, $s0
jal printInt
#Say goodbye - load the outro phrase then go to printInt, then go to exit label
la $a0, outro
jal printMsg
j exit
#Exit
exit:
li $v0, 10
syscall

.text
###############################################################
#printMsg: Prints a message
#Parameters:
#	a0 = message to print
#Returns:
#	None
###############################################################
printMsg:
li $v0, 4
syscall
jr $ra

###############################################################
#getInt: Prompts user for integer and returns value
#Parameters:
#	a0 = message to print
#Returns:
#	v0 = integer entered by user
###############################################################
getInt:
move $t0, $ra
jal printMsg
li $v0, 5
syscall
move $ra, $t0
jr $ra

###############################################################
#calcMins: Converts seconds to minutes
#Parameters:
#	a0 = integer representing seconds
#Returns:
#	v0 = integer representing minutes
###############################################################
calcMins:
li $t0, 60
div $v0, $a0, $t0
jr $ra

###############################################################
#calcHours: Converts seconds to hours
#Parameters:
#	a0 = integer representing seconds
#Returns:
#	v0 = integer representing hours
###############################################################
calcHours:
li $t0, 3600
div $v0, $a0, $t0
jr $ra

###############################################################
#printInt: Prints a label and an integer
#Parameters:
#	a0 = string to print
#	a1 = integer to print
#Returns:
#	None
###############################################################
printInt:
move $t0, $ra
jal printMsg
move $a0, $a1
li $v0, 1
syscall
move $ra, $t0
jr $ra

