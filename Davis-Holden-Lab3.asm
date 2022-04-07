#Holden Davis
#Lab 3

.text
main:

	li $v0, 4		#Kernel - Print string
	la $a0, birth		#Kernel - Print birth string
	syscall			#Execute
	
	li $v0, 4		#Kernel - Print String
	la $a0, life		#Kernel - Print life string
	syscall			#Execute
	
	li $v0, 4		#Kernel - Print String
	la $a0, death		#Kernel - Print death string
	syscall			#Execute
	
	li $v0, 10		#Kernel - Halt
	syscall			#Execute

#Define strings
.data 
birth: .asciiz "Hello World"
life: .asciiz "\n"
death: .asciiz "Goodbye Cruel World!"