# Lab 2, Assignment 4
# Mohammad Nadeem, mn535
# 172004960
main:
	
	get_1:
		li $v0, 4 # print message to insert string
		la $a0, mess
		syscall
		
		li $v0, 8 # get string
		la $a0, string1
		li $a1, 20
		syscall
	
		addi $s0, $a0, 0 # store string in $s0
	
	get_2:
		li $v0, 4 # print message to insert string
		la $a0, mess # load arguments 
		syscall
		
		li $v0, 8 # get string
		la $a0, string2 # load arguments
		li $a1, 20
		syscall
		
		addi $s1, $a0, 0 # store string in $s1
		
	isMatch:
		#TODO: compare strings
		addi $t0, $s0, 0 # store address of string1 in t0
		addi $t1, $s1, 0 # store address of string2 in t1
		li $t6, 0 # load 0 into $t6, if t6 is still 0 after, then strings are equal
		jal checkDiff
		
		bne $t6, $zero, get_2 # if t6 != 0, then strings are not equal
		j exit #else exit
	
	exit:
		li $v0, 4 # print out even sum message
		la $a0, exit_mess
		syscall
		
		li $v0, 10 # exit program
		syscall
	 
	checkDiff:
		# load next characters in strings 1 and 2 into t2 and t3 respectively
		lbu $t2, 0($t0)
		lbu $t3, 0($t1)
		
		# branch if at null terminator
		# go back to ask for second string
		beq $t2, $zero, check_1
		beq $t3, $zero, check_2 
		
		# else print out value if they are different
		bne $t2, $t3, print
		
		addi $t0, $t0, 1 # iterate t1
		addi $t1, $t1, 1 # iterate t2
		# then jump to get_2
		j checkDiff
		
	print:	
		li $v0, 4 # print message to insert string
		la $a0, mismatch
		syscall
		
		addi $t6, $t6, 1 # change value of t6 to signify that string are not equal
		li $v0, 11 # print difference in characters
		la $a0, 0($t3) # load the character
		syscall
		
		addi $t0, $t0, 1 # iterate t1
		addi $t1, $t1, 1 # iterate t2
		j checkDiff
		
	check_1:
		beq $t3, $zero, return # check if the second string is also at the null terminator
		# if so, strings are equal
		# else ask for string again
		j get_2
	
		
	check_2:
		beq $t2, $zero, return # check if the first string is also at the null terminator
		# if so, strings are equal
		# else ask for string again
		j get_2
		
	return:
		jr $ra
	
.data
	diff_mess: .asciiz "\n The strings are not equal \n"
	mismatch: .asciiz "\n Mismatch Character: \n"
	mess: .asciiz "\n Insert a string\n"
	exit_mess: .asciiz "\n The strings match!\n"
	string1:  .space 20
	string2: .space 20
