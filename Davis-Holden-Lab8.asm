#Holden Davis
#Lab 8

#k = 0: a = b + c (15)
#k = 1: a = d + e (16)
#k = 2: a = d - e (2)
#k = 3: a = b - c (5)

.text
main:

#Print the initial prompt
la $a0, prompt
li $v0, 4
syscall

#Read in integer input for k and store in $s0
li $v0, 5
syscall
move $s0, $v0

#If block
b cond_three
#No invalid input block required
b end_if
cond_three:
	seq $t1, $s0, 3 
	beqz $t1, cond_two
	#k = 3: a = b - c (5)
	lw $t2, b
	lw $t3, c
	sub $t4, $t2, $t3
	sw $t4, a
	b end_if
cond_two:
	seq $t1, $s0, 2 
	beqz $t1, cond_one
	#k = 2: a = d - e (2)
	lw $t2, d
	lw $t3, e
	sub $t4, $t2, $t3
	sw $t4, a
	b end_if
cond_one:
	seq $t1, $s0, 1 
	beqz $t1, cond_zero
	#k = 1: a = d + e (16)
	lw $t2, d
	lw $t3, e
	add $t4, $t2, $t3
	sw $t4, a
	b end_if
cond_zero:
	seq $t1, $s0, 0 
	beqz $t1, else
	#k = 0: a = b + c (15)
	lw $t2, b
	lw $t3, c
	add $t4, $t2, $t3
	sw $t4, a
	b end_if
else:
	b end_if
end_if:	
	#Print the final return
	la $a0, return
	li $v0, 4
	syscall

	#Print the final value of a
	lw $a0, a
	li $v0, 1
	syscall	
	jal Exit	
	
#Exit
Exit:
li $v0, 10
syscall

.data

a: .word 0
b: .word 10
c: .word 5
d: .word 9
e: .word 7

prompt: .asciiz "Please enter a value for k: "
return: .asciiz "The value of a is: "