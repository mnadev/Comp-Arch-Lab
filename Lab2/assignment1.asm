# Lab 2, Assignment 1
# Mohammad Nadeem, mn535
# 172004960
main:
	
	get_n:
		#print message to insert n
		# n is the smaller number
		li $v0, 4 #syscall code to print string
		la $a0, mess_n  #pass string to argument register
		syscall
		
		li $v0, 5 # syscall to get integer
		syscall
	
	# make sure n is greater than 0
	check_n: 
		slt $t0, $v0, $zero  # check if the integer recieved is less than 0
		beq $t0, $zero, exit_n # if n > 0 proceed to exit
		jal print_error # else print error
		j get_n # and get integer again
	
	exit_n:	
		addi $s0, $v0, 0 # store n in $s0
	
	
	
	get_m:
		# print message to get m
		# m is larger than n
		li $v0, 4  # syscall code for printing string
		la $a0, mess_m # message to user to input m
		syscall
		
		li $v0, 5 # syscall code for getting integer
		syscall
	
	# check that m is greater than both 0 and n
	check_m: 
		slt $t1, $v0, $s0 # check that m is greater than n
		beq $t1, $zero, exit_m # if m > n, proceed
		jal print_error_m #else alert user that m must be > n
		j get_m # ask for m again
		
		slt  $t0, $v0, $zero # check that m > 0
		beq $t0, $zero, exit_m # if  m > 0  proceed
		jal print_error # else print error 
		j get_m # ask for m again
		
	exit_m:
		addi $s1, $v0, 0 # store m in $s1
	
	# add 1 to m so we can exit loop	
	addi $t0, $s1, 1
	li $s2, 0 #$s2 will be what we store the result in
	
	#loop through and sum ints m through n
	sum:	
		beq $s0, $t0, end # check if n is equal to m + 1, if so exit 
		add $s2, $s2, $s0 # add n to $s2
		addi $s0, $s0, 1 # iterate n
		j sum # repeat loop
			
	end:
		li $v0, 4 # print string about result
		la $a0, result
		syscall
		
		li $v0, 1  # print result
		la $a0, 0($s2)
		syscall
		
		li $v0, 10 # exit program
		syscall
	
	print_error_m:
		li $v0, 4  # print error that m must be > n
		la $a0, error_m
		syscall
		jr $ra
	
	print_error:
		li $v0, 4 # print error that the integer must be > 0
		la $a0, error
		syscall
		jr $ra
.data
	mess_n: .asciiz "Insert n, the smaller number\n"
	mess_m: .asciiz "Insert m, the larger number\n"
	error: .asciiz "Integer must be greater than 0\n"
	error_m: .asciiz "m must be greater than n\n"
	result: .asciiz "The result is:\n"
