# Mohammad Nadeem, netid: mn535
# RUID: 172004960
# Lab Section 2B
# Assignment 4
	main:
		j getRadius
		
		
	# procedure to get radius from the user
	getRadius:
		li $v0, 4 # ask user to input radius
		la $a0, radiusMess
		syscall
		
		li $v0, 6 # get entered radius as a float
		syscall
		
		mov.s $f1, $f0 # store in f1
	
	#if the radius is negative then prompt user to reenter
	checkR:	
		# make f5 our zero register
		sub.s $f5, $f5, $f5
		
		c.lt.s $f5, $f1 # coprocessor will be 0 if 0 < f1

		# if f1 < 0 we want to print out an error and ask for radius again
		bc1f errorRad
		
		
	# procedure to get angle from the user
	getAngle:
		li $v0, 4 # ask user to input angle
		la $a0, angleMess
		syscall
		
		li $v0, 6 # get entered angle as a float
		syscall
		
		mov.s $f2, $f0 # store in f2
	
	#if the radius is negative then prompt user to reenter
	checkA:	
		# make f5 our zero register
		add.s $f5, $f5, $f5
		
		# check if 0 < f2 i.e. angle is negative
		c.lt.s $f5, $f2 

		# if f2 < 0 we want to print out an error and ask for anglw again
		bc1f errorAngle
		
		# load 361 into f3
		li.s $f3, 361.0
			
		# check if 360 > f2 i.e. angle is negative
		c.lt.s $f2, $f3 

		# if f2 > 260 we want to print out an error and ask for radius again
		bc1f errorAngle
		
		# else proceed
		
	area:
		# load PI into f4
		li.s $f4, 3.14159265
		
		# load 360.0 into $f2
		li.s $f3, 360.0
		
		# take angle/360 and store in f2
		div.s $f2, $f2, $f3
		
		# get r^2
		mul.s $f1, $f1, $f1
		
		# multiply r^2 times angle/360
		mul.s $f1, $f1, $f2
		
		# multiply result by pi
		mul.s $f1, $f1, $f4
		
		
	exit:
		li $v0, 4 # print area
		la $a0, areaMess
		syscall
		
		li $v0, 2
		mov.s $f12, $f1 # move result into f12
		syscall
		
		li $v0, 10 # exit program
		syscall
		
	errorRad:
		li $v0, 4 # print error to user that radius must be  > 0
		la $a0, errorRadM
		syscall
		
		# get radius again
		j getRadius
		
	errorAngle:
		li $v0, 4 # print error to user that radius must be  > 0
		la $a0, errorRadM
		syscall
		
		# get radius again
		j getAngle
.data
	errorRadM: .asciiz "\nRadius must be positive!\n"
	errorAngleM: .asciiz "\Angle must be between 0 and 360!\n"
	radiusMess: .asciiz "\nPlease input radius: \n"
	angleMess: .asciiz "\nPlease input angle: \n"
	areaMess: .asciiz "\nThe area of the circular sector is:\n"
