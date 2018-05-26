# Lab 2, Assignment 3
# Mohammad Nadeem, mn535
# 172004960
main:
	li $t0, 1001 # load 1000 into t0
	
	get_n :
		li $v0, 4  # print message to insert n
		la $a0, mess_n
		syscall
	
		li $v0, 5 # get n
		syscall

	check:
		slt  $t1, $v0, $t0 # check than n <= 1000
		bne $zero, $t1, end # if so, then proceed
		j get_n # else go back and get n
	
	end:
		addi $s0, $v0, 0 # store n in $s0
		
		# TODO: calculate sums
		li $t2, 0 # load 0 into even counter
		li $t6, 0 # load 0 into even sum
		li $t3, 1 # load 1 into odd counter
		li $t7, 0 # load 0 into odd sum
		jal even_sum # find even sum
		jal odd_sum # find odd sum
		
		
		
		sub $t4, $t7, $t6 # find difference between sums
		j exit # exit loop
		
	even_sum:
		slt $t4, $t2, $s0 # exit loop if t2 is greater than n
		beq $t2, $s0, add_n_even # if n is even then we have to add that as well
		beq $t4, $zero, exit_loop # if t4 is zero, meaning !($t2 < n), then we exit
		
		add $t6, $t6, $t2 # add next even to sum
		addi $t2, $t2, 2 # add 2 to counter
		j even_sum # repeat loop
	
	add_n_even:
		add $t6, $t6, $s0 # add n to even sum if needed
		j exit_loop
	
	exit_loop:
		jr $ra # jump to callee
	
	add_n_odd:
		add $t7, $t7, $s0 # add n to odd sum if needed
		j exit_loop
	
	
	odd_sum:
		slt $t4, $t3, $s0 # exit loop if t3 is greater than n
		beq $t3, $s0, add_n_odd # if n is odd then we have to add that as well
		beq $t4, $zero, exit_loop # exit if t3 >= n
		
		add $t7, $t7, $t3 # else, add the next odd to the sum
		addi $t3, $t3, 2 # add 2 to our counter
		j odd_sum # repeat loop
		
		
	exit:
		li $v0, 4 # print out even sum message
		la $a0, even_mess
		syscall
		
		li $v0, 1 # print out even sum
		la $a0, 0($t6)
		syscall
		
		li $v0, 4 # print out odd sum message
		la $a0, odd_mess
		syscall
		
		li $v0, 1 # print out odd sum
		la $a0, 0($t7) 
		syscall
		
		li $v0, 4 # print out difference message
		la $a0, diff_mess
		syscall
		
		li $v0, 1 # print out difference
		la $a0, 0($t4) 
		syscall
		
		li $v0, 10 # exit program
		syscall
		
.data
	mess_n: .asciiz "\n Insert n( <= 1000) \n"
	even_mess: .asciiz " The even sum is: \n"
	odd_mess: .asciiz "\n The odd sum is: \n"
	diff_mess: .asciiz "\n The difference is: \n"
