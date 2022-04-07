#Holden Davis
#Lab 4

#Premise is as follows:
#	Print the request for the first integer, read it in and save it by moving
#	Do the exact same thing for the following two integers
#	Do the math by performing the addition (with the first and second integers) first and saving the result, then perform the subtraction (with the third integer and the result) and saving the result of that
#	Print the result string, then move the final math result into position and print it
#	Exit cleanly

.data
firstquery: .asciiz "Please enter the first value to add: "
secondquery: .asciiz "Please enter the second value to add: "
thirdquery: .asciiz "Please enter the third value to subtract: "
result: .asciiz "The result is "

.text
main:

#Print firstquery
li $v0, 4
la $a0, firstquery
syscall

#Read in response
li $v0, 5
syscall

#Save response
move $s1, $v0

#Print secondquery
li $v0, 4
la $a0, secondquery
syscall

#Read in response
li $v0, 5
syscall

#Save response
move $s2, $v0

#Print thirdquery
li $v0, 4
la $a0, thirdquery
syscall

#Read in response
li $v0, 5
syscall

#Save response
move $s3, $v0

#Save result of adding first number plus + second number
add $s4, $s1, $s2

#Save result of subtracting third number from previous result
sub $s5, $s4, $s3

#Print result
li $v0, 4
la $a0, result
syscall

#Print math result
move $a0, $s5
li $v0, 1
syscall

#Exit
li $v0, 10
syscall