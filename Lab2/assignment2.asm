# Lab 2, Assignment 2
# Mohammad Nadeem, mn535
# 172004960
main:
	# there are 25 prime numbers under 100
	# we really do not need to implement an algorithm to find primes
	# since our we are just dealing with primes less than 100
	# we can just precalculate them and create an array
	# then find the closest prime in that array
	li $t0, 101 # load 100 into $t0

	
	get_n :
		li $v0, 4 # string to ask user for n 
		la $a0, mess_n 
		syscall
	
		li $v0, 5 # get integer n
		syscall
	
	check:
		slt $t1, $v0, $t0 # check that n is <= 100
		bne $zero, $t1, find # if so go to find label to find nearest prime
		
		li $v0, 4 #print error
		la $a0, error 
		syscall
		
		j get_n #  get n again
	
	find:	
		addi $s0, $v0, 0 # store into s0, the number n
		
		# load into t2, the number n
		# this value will be temporary
		# may not need actually
		#addi $t2, $s0, 0 
		
		#load base address of array into t3
		la $t3, primes
		li $s2, 100 # load the max difference that can occur into s2
		
		j find_prime # procedure to find prime
		
	find_prime:
		lw $t4, 0($t3) # load current array value into t4
		beq $t4, $zero, end # if t4 is 0, then we have reached the end of the array
		
		# otherwise, find the difference between the current word and n
		# store result temprorarily into t5
		# the register s2 will hold the min value
		sub $t5, $s0, $t4
		
		#if the value is less than 0, we want to multiply by -1
		slt $t6, $zero, $t5 # will be one if t5 > 0
		beq $t6, $zero, get_neg # get the negative of this if t5 < 0
	
		# other wise compare
		slt $t7, $t5, $s2 # t7 will be 1 if t5 < s2
		
		# if the current prime is closer
		# then update the min value
		bne $t7, $zero, setMin # if t5 < s2 we want to set Min
		
		#else proceed
		addi $t3, $t3, 4 # move to next word of array
		j find_prime
	
	setMin:
		
		la $s3, 0($t4) # store t4 in s3
		
		#update min difference
		addi $s2, $t5, 0
		
		# proceed
		addi $t3, $t3, 4 # move to next word of array
		j find_prime
		
	get_neg:
		mul $t5, $t5, -1
		
		# compare the differences to see if this prime is closer
		slt $t7, $t5, $s2 # will be 1 if t5 < t2
		
		# if the current prime is closer
		# then update the min value
		bne $t7, $zero, setMin
		
		 # else jump back to loop
		addi $t3, $t3, 4 # move to next word of array
		j find_prime
	 
	exit_loop:	
		jr $ra
	
	end:
		li $v0, 4  # print result string message
		la $a0, prime_mess
		syscall
		
		li $v0, 1 #print actual results
		la $a0, 0($s3) # change s0 to register that holds result
		syscall
		
		li $v0, 10 # syscall to exit the program
		syscall

	
			
.data
	error: .asciiz "\n n must be less than or equal 100! \n"
	mess_n: .asciiz "\n Insert n(<=100) \n"
	prime_mess: .asciiz "\n The nearest prime number is: \n"
	primes: .word 2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97
