# Assign4-starter.asm
# Starter file for Assign 4
.text
# Write code to load x,y,z, and q 
# into registers $s0-$s3 using lw
lw $s0, x
lw $s1, y
lw $s2, z
lw $s3, q
# Write the code to print the value
# in registers $s0-$s3
#$s0
la $a0, prompt1
jal PrintMsg
move $a0, $s0
jal PrintInt
move $s0, $a0
#$s1
la $a0, prompt2
jal PrintMsg
move $a0, $s1
jal PrintInt
move $s1, $a0
#$s2
la $a0, prompt3
jal PrintMsg
move $a0, $s2
jal PrintInt
move $s2, $a0
#$s3
la $a0, prompt4
jal PrintMsg
move $a0, $s3
jal PrintInt
move $s3, $a0
# Write code to load the 4 integers starting
# at label a using indirect access 
# into registers $s0-$s3
# Make sure the memory location is always set 
# to point to the integer you want to load
# Example: 
# After loading the address into $t0
# use lw to load the value from the address
# lw $s0,($t0)
# After loading the value, you need to advance
# the memory pointer to point to the next integer
la $t0, a
lw $s0, ($t0)
addi $t0, $t0, 4
lw $s1, ($t0)
addi $t0, $t0, 4
lw $s2, ($t0)
addi $t0, $t0, 4
lw $s3, ($t0)
# Write the code to print the value
# in registers $s0-$s3
#$s0
la $a0, prompt1
jal PrintMsg
move $a0, $s0
jal PrintInt
move $s0, $a0
#$s1
la $a0, prompt2
jal PrintMsg
move $a0, $s1
jal PrintInt
move $s1, $a0
#$s2
la $a0, prompt3
jal PrintMsg
move $a0, $s2
jal PrintInt
move $s2, $a0
#$s3
la $a0, prompt4
jal PrintMsg
move $a0, $s3
jal PrintInt
move $s3, $a0
# Write code to load the 4 integers starting
# at label e using direct access 
# into registers $s0-$s3
# Example: 
# After loading the address into $t0
# use lw to load the value from the address
# Use the offset into the memory location to
# get to the correct address
# lw $s0,0($t0)
la $t0, e
lw $s0,0($t0)
lw $s1,4($t0)
lw $s2,8($t0)
lw $s3,12($t0)
# Write the code to print the value
# in registers $s0-$s3
#$s0
la $a0, prompt1
jal PrintMsg
move $a0, $s0
jal PrintInt
move $s0, $a0
#$s1
la $a0, prompt2
jal PrintMsg
move $a0, $s1
jal PrintInt
move $s1, $a0
#$s2
la $a0, prompt3
jal PrintMsg
move $a0, $s2
jal PrintInt
move $s2, $a0
#$s3
la $a0, prompt4
jal PrintMsg
move $a0, $s3
jal PrintInt
move $s3, $a0
#Exit the program
j Exit
##############################################
# PrintInt - Print an integer
# Parameters:
# 	$a0 - int to display
# Returns:
#	None
##############################################
PrintInt:
li $v0, 1
syscall
jr $ra
##############################################
# PrintMsg - Print a string
# Parameters:
# 	$a0 - message to display
# Returns:
#	None
##############################################
PrintMsg:
li $v0, 4
syscall
jr $ra
##############################################
# Exit - Exit cleanly
# Parameters:
# 	None
# Returns:
#	None
##############################################
Exit:
li $v0, 10
syscall

.data

x: .word 10
y: .word 15
z: .word 7
q: .word 8
a: .word 2
   .word 4
   .word 6 
   .word 12
e: .word 5
   .word 10
   .word 15
   .word 20
prompt1: .asciiz "\nThe value in $s0 is : "
prompt2: .asciiz "\nThe value in $s1 is : "
prompt3: .asciiz "\nThe value in $s2 is : "
prompt4: .asciiz "\nThe value in $s3 is : "

#   .include "utils.asm"
