# Mohammad Nadeem, netid: mn535
# RUID: 172004960
# Lab Section 2B
# Assignment 6

	main:
		la $t0, array # load base address of array into t0
		li $t1, 9 # load the length of the array into t1

		j printInit

	printInit:
		# print sorted message
		li $v0, 4
		la $a0, init
		syscall

		j printArrInit

	printArrInit:
		l.s $f2, 0($t0) # load current element into f2

		# set f1 to zero
		li.s $f1, 0.0

		# check if current value is 0
		c.eq.s $f1, $f2

		# exit if so
		bc1t next

		# else print array element
		li $v0, 2
		mov.s $f12,$f2
		syscall

		# print comma
		li $v0, 4
		la $a0, comma
		syscall

		# add 4 to get to next element
		addi $t0, $t0, 4

		j printArrInit

	next:
		la $t0, array # load base address of array into t0
		li $t1, 9 # load the length of the array into t1

		j outer

	#this is the outer loop that will iterate n times where n = array.length
	outer:
		# if t1 is 0, then we have finished sorting and
		# can move on to the next part: search
		la $t0, array # load base address of array into t0
		beq $t1, $zero, print

		# load base address of array into t2 as well
		addi $t2, $t0, 0

		# t4 is inner counter variable
		li $t4, 8

		jal inner

		addi $t1, $t1, -1 # decrement t1
		j outer

	inner:
		l.s $f2, 0($t2) # load current float into f2
		l.s $f3, 4($t2) # load next float into f3

		# set coprocessor to 1 iff f3 >s f2
		c.lt.s $f2, $f3

		# if f3 < f2, then we want to swap the values
		bc1f swap

		# break if t4 is 0
		beq $t4, $zero, return

		addi $t2, $t2, 4 # iterate t2 to get to next word
		addi $t4, $t4, -1 # decrement t4
		j inner

	return:
		jr $ra

	swap:
		# swap the memory locations of the floats
		s.s $f2, 4($t2)
		s.s $f3, 0($t2)

		# break if t4 is 0
		beq $t4, $zero, return

		addi $t2, $t2, 4 # iterate t2 to get to next word
		addi $t4, $t4, -1 # decrement t4
		j inner

	print:
		# print sorted message
		li $v0, 4
		la $a0, sort
		syscall

		j printArr

	printArr:
		l.s $f2, 0($t0) # load current element into f2

		# set f1 to zero
		li.s $f1, 0.0

		# check if current value is 0
		c.eq.s $f1, $f2

		# exit if so
		bc1t exit

		# else print array element
		li $v0, 2
		mov.s $f12,$f2
		syscall

		# print comma
		li $v0, 4
		la $a0, comma
		syscall

		# add 4 to get to next element
		addi $t0, $t0, 4

		j printArr

	exit:
		li $v0, 10
		syscall

.data
	init: .asciiz "\nInitial Array: "
	sort: .asciiz "\nSorted Array: "
	array: .float 9.0,8.0,7.0,6.0,5.0,4.0,3.0,2.0,1.0
	comma: .asciiz ","
