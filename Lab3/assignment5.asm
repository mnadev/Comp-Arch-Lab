# Mohammad Nadeem, netid: mn535
# RUID: 172004960
# Lab Section 2B
# Assignment 5


	main:
		j getPercentFull
		
	# procedure to get amount tank is full
	getPercentFull:
		li $v0, 4 # ask user to input how full tank is
		la $a0, fullMess
		syscall
		
		li $v0, 6 # get entered float
		syscall
		
		mov.s $f1, $f0 # store in f1
	
	# check that inputted number is between 0 and 1 
	checkFull:
		# make f5 our zero register
		add.s $f5, $f5, $f5
		
		c.lt.s $f5, $f1 # coprocessor will be 0 if 0 < f1

		# if f1 < 0 we want to print out an error and ask again
		bc1f errorFull
		
		# load 1 into f6
		li.s $f6, 1.0
		
		c.lt.s $f6, $f1 # coprocessor will be 0 if 0 < f1

		# if f1 < 0 we want to print out an error and ask for radius again
		bc1t errorFull
		
	# procedure to get amount tank is full
	getTankCap:
		li $v0, 4 # ask user to input tank capacity
		la $a0, tankMess
		syscall
		
		li $v0, 6 # get entered float
		syscall
		
		mov.s $f2, $f0 # store in f2
	
	# check that inputted number is positive 
	checkTankCap:
		# make f5 our zero register
		add.s $f5, $f5, $f5
		
		c.lt.s $f5, $f2 # coprocessor will be 0 if 0 < f2

		# if f2 < 0 we want to print out an error and ask again
		bc1f errorTank
		
		
	# procedure to get amount tank is full
	getPrice:
		li $v0, 4 # ask user to input tank capacity
		la $a0, priceMess
		syscall
		
		li $v0, 6 # get entered float
		syscall
		
		mov.s $f3, $f0 # store in f3
	
	# check that inputted number is positive
	checkPrice:
		# make f5 our zero register
		add.s $f5, $f5, $f5
		
		c.lt.s $f5, $f3 # coprocessor will be 0 if 0 < f3

		# if f3 < 0 we want to print out an error and ask again
		bc1f errorPrice
		
	calc:
		# find how many gallons are in the car
		# by doing percentfull*capacity
		mul.s $f1, $f2, $f1
		
		# now find how many gallons needed to fill it by
		# capacity - amount in tank
		sub.s $f1, $f2, $f1
		
		# now multiply that result by the price
		# and we get our answer
		mul.s $f3, $f3, $f1
		
			
	exit:
		li $v0, 4 # print result message
		la $a0, result
		syscall
		
		# print result
		li $v0, 2 # print result message
		mov.s $f12, $f3
		syscall
		
		li $v0, 10 # exit program
		syscall
	
	errorFull:
		li $v0, 4 # print error message
		la $a0, errorFullM
		syscall
		
		j getPercentFull
	
	errorTank:
		li $v0, 4 # print error message
		la $a0, errorTankM
		syscall
	
		j getTankCap
	
	
	errorPrice:
		li $v0, 4 # print error message
		la $a0, errorPriceM
		syscall
		
		j getPrice
.data
	fullMess: .asciiz "\nHow full is the tank: \nEnter a number between 0 and 1.\n"
	tankMess: .asciiz "\nHow much gas can the tank hold in gallons:\n"
	priceMess: .asciiz "\nWhat's the price of gas per gallon in USD:\n"
	errorFullM: .asciiz "\nNumber has to be between 0 and 1!\n"
	errorTankM: .asciiz "\nNumber has to be posiitve!\n"
	errorPriceM: .asciiz "\nNumber has to be posiitve!\n"
	result: .asciiz "\nThis is how much it will cost to fill up your tank in USD:\n"