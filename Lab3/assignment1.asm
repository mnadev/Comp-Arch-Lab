# Mohammad Nadeem, netid: mn535
# RUID: 172004960
# Lab Section 2B
# Assignment 1

.text
	main:
	 	j get
	get:
		li $v0, 4 # ask user to input number
		la $a0, inputA
		syscall
		
		li $v0, 5 # get entered integer
		syscall
		
		addi $s0, $v0, 0 # store the integer A in s0
		
		li $v0, 4 # ask user to input number
		la $a0, inputB
		syscall
		
		li $v0, 5 # get entered integer
		syscall
		
		addi $s1, $v0, 0 # store the integer B  in s1
		
		li $v0, 4 # ask user to input number
		la $a0, inputC
		syscall
		
		li $v0, 5 # get entered integer
		syscall
		
		addi $s2, $v0, 0 # store the integer C in s2
		
	logic:
		# THE FUNCTION WE ARE TRYING TO IMPLEMENT IS (A OR C)' AND (C AND B)'
		or $t0, $s0, $s2 # do the operation A OR C and store in $t0
		not $t0, $t0 # invert the result of A OR C
		
		and $t1, $s1, $s2 # do the operation A AND B and store in t1
		not $t1, $t1, # invert A AND B
		
		and $t2, $t0, $t1 # and the two results together
		
	exit:
		li $v0, 4 # print result message
		la $a0, result
		syscall
		
		li $v0, 1
		la $a0, 0($t2) # print result
		syscall
		
		li $v0, 10 # exit program
		syscall
.data
	inputA: .asciiz "\nPlease input integer A: \n"
	inputB: .asciiz "\nPlease input integer B: \n"
	inputC: .asciiz "\nPlease input integer C: \n"
	result: .asciiz "\nThe result is: \n"
