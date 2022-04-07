#Holden Davis
#Lab 5

#Program premise is as such:
#	Print request for number to divide by 8 + syscall
#	Accept number input, syscall and save in $s0
#	Divide number by 8 (srl 3), save in itself
#	Print result string + syscall + print result number + syscall
#		Do the above four steps again except multiply by 4 (sll 2) as operation
#	Load exit instruction + syscall

.text
main:
#Print div8 request prompt
li $v0, 4
la $a0, div8req
syscall

#Accept number input + save in $s0
li $v0, 5
syscall
move $s0, $v0

#Divide by 8
srl $s0, $s0, 3

#Print div8 result prompt
li $v0, 4
la $a0, div8result
syscall

#Print div8 result
li $v0, 1
move $a0, $s0
syscall

#Print mult4 request prompt
li $v0, 4
la $a0, mult4req
syscall

#Accept number input + save in $s0
li $v0, 5
syscall
move $s0, $v0

#Multiply by 4
sll $s0, $s0, 2

#Print mult4 result prompt
li $v0, 4
la $a0, mult4result
syscall

#Print mult4 result
li $v0, 1
move $a0, $s0
syscall

#Exit
li $v0, 10
syscall

.data
div8req: .asciiz "Please enter the number to divide by 8: "
div8result: .asciiz "That number divided by 8 is "
mult4req: .asciiz "\nPlease enter the number to multiply by 4: "
mult4result: .asciiz "That number multiplied by 4 is "