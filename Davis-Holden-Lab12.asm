#Holden Davis
#Lab 12

# Shamelessly build from a torn-down factorial.asm! 
# Uses utils.asm for easier printing
# Stack manipulation remains effectively the same between both programs as a0 is the only parameter for both add_r and fact, so moving $ra and $a0 on and off the stack respectively are the only stack actions that occur
# Major differences between fact and add_r include:
#	add_r exit condition is n == 0, whereas fact is n == 1
#	add_r returns a 0 on the exit condition occurring, whereas fact returns a 1
#	add_r adds the previous result to the next, while fact multiples them together
#	These few differences result in relatively small changes made to the overall structure of the program; ie. only changing the bne from 1 to 0 and changing mul to add in recursion return value

.data
	InInteger:   .asciiz "Please enter an integer: "
	Result:      .asciiz "Returned value = "
.text

 	la $a0, InInteger 
	jal PrintString	
	addi $v0, $zero, 5
	syscall	
	move $a0, $v0
	jal add_r
	move $s0, $v0
 	la $a0, Result
 	move $a1, $s0
 	jal PrintInt
 	j Exit

##############################################	
# add_r
# Description:
#	Sums the number's predecessors, ie. 5 -> 5 + 4 + 3 + 2 + 1 = 15
#
#      if(n == 0) return 0;
#        else return (n + add_r(n-1));
#
# Parameters:
#    $a0 - n
#
# Returns:
#   $v0 - the result
##############################################	
add_r:
	# Push $ra on the stack
	addi $sp, $sp, -4     # adjust stack 
	sw   $ra, 0($sp)      # save return address
	# Push $a0 on the stack    
	addi $sp, $sp, -4     # adjust stack
	sw   $a0, 0($sp)      # save argument
	
	# Procedure logic starts here    
	bne  $a0,0,recur      # if n !-=0, branch to recur 
	addi $v0, $zero, 0    # if not, result is 0in $v0 - exit condition
	    
	# Pop $a0 off the stack    
	lw   $a0,0($sp)       
	addi $sp, $sp, 4        
	# Pop $ra off the stack   
	lw   $ra,0($sp)	     
	addi $sp, $sp, 4

	jr   $ra              # Last return

recur:	
	addi $a0, $a0, -1     # else decrement n ($a0)      
	jal  add_r             # recursive call
	    
	# Pop $a0 off the stack    
	lw   $a0,0($sp)        
	addi $sp, $sp, 4        
	# Pop $ra off the stack   
	lw   $ra,0($sp)	
	addi $sp, $sp, 4
	
	add  $v0, $a0, $v0    # multiply to get result    
	jr   $ra              # and return

.include "utils.asm"