#Holden Davis
#Assignment 6

.data
A: 		.word 11, 250, 20, 70, 60, 140,150, 80, 90,100, 1, 30, 40, 120,130, 5
size: 		.word 16 # length of array A
min: 		.word 0
max: 		.word 0
sum: 		.word 0
average: 	.word 0
largestInt: 	.word 2147483647 # You may want to use this for min procedure

minout:		.asciiz "The minimum is "
maxout:		.asciiz "The maximum is "
sumout:		.asciiz "The sum is "
avgout:		.asciiz "The average is "

.text

main:
	la $a0, A
	lw $a1, size
	jal min_start
	la $a0, minout
	move $a1, $v0
	jal PrintInt
	jal PrintNewLine
	
	la $a0, A
	lw $a1, size
	jal max_start
	la $a0, maxout
	move $a1, $v0
	jal PrintInt
	jal PrintNewLine
	
	la $a0, A
	lw $a1, size
	jal sum_start
	la $a0, sumout
	move $a1, $v0
	jal PrintInt
	jal PrintNewLine
	
	la $a0, A
	lw $a1, size
	jal sum_start
	move $a0, $v0
	lw $a1, size
	jal avg_start
	la $a0, sumout
	move $a1, $v0
	jal PrintInt
	jal PrintNewLine
	j Exit

#############################################################
#min_start - retuns the smallest value of the array
#Input:
#	$a0 - memory location of integer array A
#	$a1 - size of integer array A
#Output:
#	$v0 - the minimum value in the array
#############################################################
min_start:
	# Save ra on the stack
	addi $sp, $sp,-4
	sw $ra,0($sp)
  	# Save $a0 on the stack
	addi $sp, $sp,-4
	sw $a0,0($sp)
	# Save $a1 on the stack
	addi $sp, $sp,-4
	sw $a1,0($sp)
	
	#Designate the first value as the minimum
	#Iterate through elements of array
	#	If element is less that current minimum, replace the minimum
	#Return minimum when finished
	li $t0, 0
	#Load the first value in the array into s4
	li $t2, 0
	mul $t2, $t0, 4
	add $t2, $t2, $a0
	lw $s4,($t2)
	j min_loop
min_loop:
	bge $t0, $a1, min_exit
	li $t2, 0
	mul $t2, $t0, 4
	add $t2, $t2, $a0
	lw $s3,($t2)
	#in every iteration, $s3 now contains A[index]
	#If s3 less than s4 (current min), branch to min_min (creative, I know)
	blt $s3, $s4, min_min
	addi $t0, $t0, 1
	j min_loop
min_min:
	move $s4, $s3
	addi $t0, $t0, 1
	j min_loop
min_exit:
	move $v0, $s4	
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

#############################################################
#max_start - retuns the largest value of the array
#Input:
#	$a0 - memory location of integer array A
#	$a1 - size of integer array A
#Output:
#	$v0 - the greatest value in the array
#############################################################
max_start:
	# Save ra on the stack
	addi $sp, $sp,-4
	sw $ra,0($sp)
  	# Save $a0 on the stack
	addi $sp, $sp,-4
	sw $a0,0($sp)
	# Save $a1 on the stack
	addi $sp, $sp,-4
	sw $a1,0($sp)
	
	#Designate the first value as the maximum
	#Iterate through elements of array
	#	If element is greater that current maximum, replace the maximum
	#Return minimum when finished
	li $t0, 0
	#Load the first value in the array into s4
	li $t2, 0
	mul $t2, $t0, 4
	add $t2, $t2, $a0
	lw $s4,($t2)
	j max_loop
max_loop:
	bge $t0, $a1, max_exit
	li $t2, 0
	mul $t2, $t0, 4
	add $t2, $t2, $a0
	lw $s3,($t2)
	#in every iteration, $s3 now contains A[index]
	#If s3 greater than s4 (current max), branch to max_max (creative, I know)
	bgt $s3, $s4, max_max
	addi $t0, $t0, 1
	j max_loop
max_max:
	move $s4, $s3
	addi $t0, $t0, 1
	j max_loop
max_exit:	
	move $v0, $s4
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

#############################################################
#sum_start - retuns the sum of the values in the array
#Input:
#	$a0 - memory location of integer array A
#	$a1 - size of integer array A
#Output:
#	$v0 - the sum of the values in the array
#############################################################
sum_start:
	# Save ra on the stack
	addi $sp, $sp,-4
	sw $ra,0($sp)
  	# Save $a0 on the stack
	addi $sp, $sp,-4
	sw $a0,0($sp)
	# Save $a1 on the stack
	addi $sp, $sp,-4
	sw $a1,0($sp)
	
	#Designate sum as zero before beginning
	#Iterate through elements of array
	#	Add element to sum
	#Return sum when finished
	li $t0, 0
	li $v0, 0
	j sum_loop
sum_loop:
	bge $t0, $a1, sum_exit
	li $t2, 0
	mul $t2, $t0, 4
	add $t2, $t2, $a0
	lw $s3,($t2)
	#in every iteration, $s3 now contains A[index]
	add $v0, $v0, $s3
	addi $t0, $t0, 1
	j sum_loop

sum_exit:
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

#############################################################
#avg_start - retuns the average value of the array
#Input:
#	$a0 - sum of values in the array calculated from sum
#	$a1 - size of integer array A
#Output:
#	$v0 - the average value of an element in the array
#############################################################
avg_start:
	# Save ra on the stack
	addi $sp, $sp,-4
	sw $ra,0($sp)
  	# Save $a0 on the stack
	addi $sp, $sp,-4
	sw $a0,0($sp)
	# Save $a1 on the stack
	addi $sp, $sp,-4
	sw $a1,0($sp)
	
	#Simply divide sum by size of integer array and return it
	div $v0, $a0, $a1
			
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
