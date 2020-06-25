# 
# Homework 3 for Assembly Language
#
#	$t0 <-- n
#	$t1 <-- result
#	$s0 <-- counter
#	$sp <-- stack pointer
#
	.data
msg:    .asciiz "Enter a number between 1 and 10: "
	.space 64
resMsg:	.asciiz "'s Factorial Value is "
	.space 64

	.text
	.globl main
# Main Function - Asks user for input, then calls factorial function, after function runs, it outputs the result
main:	
	# Ask user for input
	li $v0, 4			# 4 means cout
	la $a0, msg			# msg stored into $a0 
	li $a1, 64			# allocate memory for msg
	syscall				# print msg

	# Store user input as n ($t0)
	li $v0, 5			# 5 means cin
	syscall				# cin the input

	move $t0, $v0		# store n into $t0
	move $a0, $t0		# $a0 <= n

	addi $sp, $sp, -8	# Push the stack frame by 8 bytes
	sw $t0, 0($sp)		# store n into $t0 at the top of the stack
	sw $ra, 4($sp)		# store return address into $ra at the bottom of the stack

	jal factorial		# go to factorial function

	lw $t0, 0($sp)		# store n into $t0 at the top of the stack
	lw $ra, 4($sp)		# store return address into $ra at the bottom of the stack

	li $v0, 1			# 1 means print int... $a0, is still n
	syscall				# return n 

	li $v0, 4			# 4 means cout
	la $a0, resMsg		# print resMsg
	li $a1, 64			# allocate memory for message
	syscall				# return msg

	li $v0, 1			# 1 means print int
	move $a0, $t1		# move result into $a0
	syscall				# return the factorial of n

	addi $sp, $sp, 8	# Pop the stack frame by 8 bytes
	li $v0, 10			# 10 means terminate program
	syscall				# end program

# Factorial Function - Input: $t1 (n)
factorial:
	# Factorial Without Recursion
	li $s0, 1			# counter = 1
	li $t1, 1			# result = 1
	lw $t0, 0($sp)		# load n into $t0

	# Loop is a label inside of factorial, not a seperate function
	loop:
		bgt $s0, $t0, exit	# if counter > n, go to done
		mul $t1, $t1, $s0	# fact = fact * counter
		addi $s0, $s0, 1	# increment counter
		b loop				# go back to loop
		
	# Exit is also label inside of factorial, not a seperate function
	exit:
		sw $t1, 0($sp)		# store result in $t2
		jr $ra				# jump back