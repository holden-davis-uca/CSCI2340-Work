#Holden Davis
#Assignment 1

.data
welcome: .asciiz "Welcome.\n"
foodquery: .asciiz "What is your favorite food? "
foodfreqquery: .asciiz "How many times a week do you eat your favorite food? "
foodresult: .asciiz "\n\nYour favorite food is "
foodfreqresult1: .asciiz "and you eat it "
foodfreqresult2: .asciiz " times a week.\n"
goodbye: .asciiz "Goodbye!"
.align 2
favfood: .space 40
maxSize: .word 41

.text
main:

#Print welcome
li $v0, 4
la $a0, welcome
syscall

#Print foodquery
li $v0, 4
la $a0, foodquery
syscall

#Read in response
la $a0, favfood
lw $a1, maxSize
li $v0, 8
syscall

#Print foodfreqquery
li $v0, 4
la $a0, foodfreqquery
syscall

#Read in response
li $v0, 5
syscall

#Save response
move $t0, $v0

#Print foodresult
li $v0, 4
la $a0, foodresult
syscall

#Print favfood
la $a0, favfood
li $v0, 4
syscall

#Print foodfreqresult1
li $v0, 4
la $a0, foodfreqresult1
syscall

#Print foodfreq
move $a0, $v0
li $v0, 1
syscall

#Print foodfreqresult2
li $v0, 4
la $a0, foodfreqresult2
syscall

#Print goodbye
li $v0, 4
la $a0, goodbye
syscall

#Exit
li $v0, 10
syscall

