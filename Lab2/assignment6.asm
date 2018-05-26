# Lab 2, Assignment 6
# Mohammad Nadeem, mn535
# 172004960
.text
	li $t0, 9 # load the length of the array into t0
	la $s1, array # load base address of array into s1
	
	
	#this is the outer loop that will iterate n times where n = array.length
	outer:
		# if t0 is 0, then we have finished sorting and
		# can move on to the next part: search
		beq $t0, $zero, ask
		
		# load base address of array into t1 as well
		addi $t1, $s1, 0
		
		jal inner
		
		
		addi $t0, $t0, -1 # decrement t0
		j outer
		
	inner:
		lw $t2, 0($t1) # load current word into t2
		lw $t3, 4($t1) # load next word into t3
		
		slt $t4, $t3, $t2 # set t4 to 1 iff t3 < t2
		
		# if t3 > t2, then we want to swap the values
		beq $t4, $zero, swap
		
		# if next word is null, then we are at the end of the array
		beq $t3, $zero, return
		
		addi $t1, $t1, 4 # iterate t1 to get to next word
		j inner
		
	return:
		jr $ra
	
	swap:
		# swap the memory locations of the words
		# and we have swapped the array
		sw $t2, 4($t1)
		sw $t3, 0($t1)
		
		addi $t1, $t1, 4 # iterate t1 to get to next word
		j inner
		
	ask:
		li $v0, 4 # ask user for number to search 
		la $a0, askMessage
		syscall
		
		li $v0, 5 # get integer
		syscall

		addi $s2, $v0, 0 # load integer into s2
		addi $t1, $s1, 0 # update t1 to base address
		li $t4, 0 # t4 will hold index of what we find
		j search
		
	search:
		lw $t2, 0($t1) # load word from array
		
		# if we branch on this statement we have not found the elemnet
		# and must add it to array
		beq $t2, $zero, toEnd 

		beq $t2, $s2, exit # if we found the element we want to quit

		addi $t4, $t4, 1 # iterate index
		addi $t1, $t1, 4 # iterate address 
		
	# we will insert new element at end of array and then sort it
	toEnd:
		li $v0, 4 # notify user element not found
		la $a0, error
		syscall

		li $v0, 4 # notify user element not found
		la $a0, error_add
		syscall

		addi $t1, $s1, 0 # make t1 base address
		j iterate
		
	iterate:
		lw $t2, 0($t1) # load current word into t2
		
		li $v0, 1 # print index of element
		la $a0, 0($t2)
		syscall
		
		beq $t3, $zero, addTo # if we have reached the end of the array then we return
		
		addi $t1, $t1, 4 # go to next word
		j iterate
		
	addTo:
		lw $s2, 0($t1)
		
		jal length # find length of array again
		j outer # sort array again
		
	exit: 
		li $v0, 4 # notify user element found
		la $a0, success
		syscall
		
		li $v0, 1 # print index of element
		la $a0, 0($t4)
		syscall
		
		li $v0, 10 # exit program
		syscall
	
	# procedure to find length of array
	length:
		lw $t2, 0($t1) # load current word into t2
		
		addi $t0, $t0, 1 # add 1 to t0, which holds length of array
		
		beq $t2, $zero, return # if we have reached the end of the array then we return
		
		addi $t1, $t1, 4 # go to next word
		j length

.data
	array: .word 45, 85, 1, 34, 79, 13, 20, 5, 0xF
	buffer: .space 10
	askMessage: .asciiz "\n Enter number to search: \n"
	buffer1: .space 4
	error: .asciiz "\n Numerical value not found!  "
	buffer2: .space 4
	error_add: .asciiz "Element added to array. \n"
	buffer3: .space 4
	success: .asciiz "\n Element found at index "