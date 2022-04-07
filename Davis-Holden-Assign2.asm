#Holden Davis
#Assignment 1

.data
queryx: .asciiz "Enter a value for x: "
queryy: .asciiz "Enter a value for y: "
queryz: .asciiz "Enter a value for z: "
result1: .asciiz "The result for expression 1 is: "
result2: .asciiz "\nThe result for expression 2 is: "
exit: .asciiz "\nGoodbye!"

.text
main:

#Throughout program:
#	X is in $s0
#	Y is in $s1
#	Z is in $s2

#Print query for x
li $v0, 4
la $a0, queryx
syscall
#Read in + move query for x
li $v0, 5
syscall
move $s0, $v0
#Print query for y
li $v0, 4
la $a0, queryy
syscall
#Read in + move query for y
li $v0, 5
syscall
move $s1, $v0
#Print query for z
li $v0, 4
la $a0, queryz
syscall
#Read in + move query for z
li $v0, 5
syscall
move $s2, $v0
#Compute expression 1
#	Mult 5 by x
mul $t7, $s0, 5
#	Mult 3 by y
mul $t6, $s1, 3
#	Add above two
add $t7, $t7, $t6
#	Add z
add $t7, $t7, $s2
#	Divide by 2
div $t7, $t7, 2
#	Mult by 3
mul $t7, $t7, 3
#Compute expression 2
#	Mult x by x
mul $s7, $s0, $s0
#	Mult above by x
mul $s7, $s7, $s0
#	Mult x by x
mul $s6, $s0, $s0
#	Mult above by 2
mul $s6, $s6, 2
#	Mult x by 3
mul $s5, $s0, 3
#	Add first two
add $t1, $s7, $s6
#	Add third with above
add $t1, $t1, $s5
#	Add four with above
add $t1, $t1, 4
#Print result 1 
li $v0, 4
la $a0, result1
syscall
#Print expression 1
move $a0, $t7
li $v0, 1
syscall
#Print result 2
li $v0, 4
la $a0, result2
syscall
#Print expression 2
move $a0, $t1
li $v0, 1
syscall
#Print exit
li $v0, 4
la $a0, exit
syscall
#Exit
li $v0, 10
syscall