# Mohammad Nadeem, netid: mn535
# RUID: 172004960
# Lab Section 2B
# Assignment 2


	main:
		j getA	

	getA:
		li $v0, 4 # ask user to input number
		la $a0, inputA
		syscall
		
		li $v0, 5 # get entered integer
		syscall
		
		addi $s0, $v0, 0 # store the integer A in s0
	
	checkA:
		li $t0, 1001
		
		slt $t2, $s0, $t0 # t2 will be 1 if s0 <= 1000		
		slt $t3, $zero, $s0 # t3 will be 1 if 0 < s0

		# if both statements are true, we want to get B
		beq $t2, $t3, getB
		
		#otherwise get A again and alert user	
		li $v0, 4 # error message
		la $a0, error
		syscall
								
		j getA
		
	getB:	
		li $v0, 4 # ask user to input number
		la $a0, inputB
		syscall
		
		li $v0, 5 # get entered integer
		syscall
		
		addi $s1, $v0, 0 # store the integer B  in s1
	
	checkB:
		li $t0, 1001
		
		slt $t2, $s1, $t0 # t2 will be 1 if s1 <= 1000		
		slt $t3, $zero, $s1 # t3 will be 1 if 0 < s1

		# if both statements are true, we want to move on to divide
		li $t0, 0
		beq $t2, $t3, divide
		
		#otherwise get B again and alert user	
		li $v0, 4 # error message
		la $a0, error
		syscall
		
		j getB
	
	divide:
		# the quotient will be in t0
		# and the remainder will be in s0
		
		# add -1 to b, store in t2
		addi $t2, $s1, -1
		
		slt $t1 ,$t2, $s0 # t2 will be 1 if s1 - 1 < s0, i.e. s1 < s0 + 1 --> s1 < s0
		
		# if the statement is true then a > b and we can subtract b from a
		# otherwise we exit and print the quotient and remainder
		beq $t1, $zero, exit
		
		# set a = a - b
		sub $s0, $s0, $s1
		
		# iterate the quotient
		addi $t0, $t0, 1
		
		j divide # loop back
		
	exit:
		li $v0, 4 # print quotient message
		la $a0, quotient
		syscall
		
		li $v0, 1
		la $a0, 0($t0) # print quotient
		syscall
		
		li $v0, 4 # print remainder message
		la $a0, remainder
		syscall
		
		li $v0, 1
		la $a0, 0($s0) # print remainder
		syscall
		
		li $v0, 10 # exit program
		syscall
.data
	error: .asciiz "\nInteger must be between 1 and 1000!\n"
	inputA: .asciiz "\nPlease input integer a: \n"
	inputB: .asciiz "\nPlease input integer b: \n"
	quotient: .asciiz "\nThe quotient is: \n"
	remainder: .asciiz "\nThe remainder is: \n"
