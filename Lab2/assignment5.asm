# Lab 2, Assignment 5
# Mohammad Nadeem, mn535
# 172004960
main:
	li $t0, 2 # t0 will hold the value that will show how many times the user has
	# tried to create a password, if it is zero, the program will end
	
	get_pwd:
		li $v0, 4 # print message to insert password
		la $a0, mess
		syscall
		
		li $v0, 8 # get password initially, i.e. the one to create
		la $a0, pwd
		li $a1, 20
		syscall
	
	
		addi $s0, $a0, 0 # store password in $s0
		addi $t0, $t0, -1 # remove one try from t0
	
	isValid:
		#check how many tries the user has
		# if user is out of tries, exit
		beq $t0, $zero, exit_over
		
		#check if pwd is between 8 and 12 characters
		li $s1, 0 # length will be stored in s1
		addi $t1, $s0, 0 #address of string will be temporarily stored in t1 as well
		jal length # get length of string
		
		li $t3, 12 # load 12 into t3, this is max range of password
		li $t4, 8 # load 8 into t2, this is min range of password
		
		slt $t5, $s1, $t3 # if length(pwd) < 12, then t5 = 1
		slt $t6, $t4, $s1 # if length(pwd) > 8, then t6 = 1
		bne $t6, $t5, get_pwd # if both statements are not true then the user has to reenter password
		
		# otherwise we will ask for the user to reenter password
		# t7 holds the amount of tries the user has left to reenter
		li $t7, 3
		j get_again
	
	get_again:	
		# if attempts are used up, exit program with appropriate message
		beq $t7, $zero, exit_error
			
		# reenter the password to set it
		jal reenter
		
		# decrease the number of tries left
		addi $t7, $t7, -1
		
		addi $t1, $s0, 0 # reset t1 to hold base address of s0
		addi $t2, $s2, 0 #address of reentered password will be temporarily stored in t2
		jal isMatch # check if the passwords are correct
		
		# else alert user and ask again
		j printErrorInit
	
	length:
		lbu $t2, 0($t1) # load character into t2
		
		beq $t2, $zero, return # t2 will hold the current byte. if it is zero we reached the end of the string.
		
		addi $s1, $s1, 1 # add 1 to length of string
		addi $t1, $t1, 1 # iterate address of string to move to next one
		
		j length
		
	return:
		jr $ra
			
	reenter:
		li $v0, 4 # print message to insert password to check what was setup
		la $a0, enter
		syscall
		
		li $v0, 8 # get password try
		la $a0, pwd_check
		li $a1, 20
		syscall

		addi $s2, $a0, 0 # store reentered password in $s2
		j return
		
	isMatch:
		# load next characters in strings 1 and 2 into t2 and t3 respectively
		lbu $t3, 0($t1)
		lbu $t4, 0($t2)
		
		# branch if at null terminator
		# check if the two characters are equal
		# if so then we have 
		beq $t3, $zero, check  
		beq $t4, $zero, check

		# print out value if characters are different
		# and stop loop
		# if we do not branch at this ever, then our passwords match
		bne $t3, $t4, printErrorMatch
	
		
		addi $t1, $t1, 1 # iterate t1
		addi $t2, $t2, 1 # iterate t2
		j isMatch
	
	check: 
		# if the characters are equal, passwords match
		# and we will terminate program
		# otherwise, the pass word needs to be reentered
		beq $t3, $t4, exit 
		bne $t4, $t3, printErrorMatch
		
	exit_over:
		#exit if user used two tries to input password
		li $v0, 4 
		la $a0, overtry
		syscall
		
		li $v0, 10 # exit program
		syscall
	
	exit_error:
		#exit if user did not input correct pwd
		li $v0, 4 
		la $a0, exit_error_mess
		syscall
		
		li $v0, 10 # exit program
		syscall
	
	exit:
		#exit if user input correct pwd
		li $v0, 4 
		la $a0, exit_mess
		syscall
		
		li $v0, 10 # exit program
		syscall
	 
	printErrorInit:	
		li $v0, 4 # print out even sum message
		la $a0, wrong_length
		syscall
		
		# then jump to get_
		j get_pwd

	printErrorMatch:	
		li $v0, 4 # print out even sum message
		la $a0, wrong_pwd
		syscall
		
		# then jump to get_again
		j get_again
.data
	mess: .asciiz "\n Insert a password: \n"
	overtry: .asciiz "\n You have too many attempts to create password. Bye. \n"
	enter: .asciiz "\n Enter the password again: \n"
	wrong_length: .asciiz "\n Please enter a password of length 8 to 12: \n"
	wrong_pwd: .asciiz "\n Incorrect Password! \n"
	exit_error_mess: .asciiz "\n Password is not setup! You have used up your attempts. \n"
	exit_mess: .asciiz "\n Password is setup! \n"
	pwd: .space 20
	pwd_check: .space 20
