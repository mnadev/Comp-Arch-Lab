# Mohammad Nadeem, 172004960
# Lab Section 2B
# Lab 5, Assignment 3

.data 0x10000860
vector_A: .word 1,2,3,4,0,0,0,0
.data 0x10000880
matrix_B: .word 1,2,3,4,5,6,7,8
	.data 0x10000C80
	.word 2,3,4,5,6,7,8,9
	.data 0x10001080
	.word 3,4,5,6,7,8,9,10
	.data 0x10001480
	.word 4,5,6,7,8,9,10,11
	.data 0x10000840
vector_C: .word 0,0,0,0,0,0,0,0

.text 0x00400000
.globl main # main program starts in the next line

main:
	#Your code starts from here
	li $s7, 0 # holds counter for outer loop
	li $t8, 8, # holds value at which loop will end
	li $t6, 4 # value to get to next part of matrix B
	li $s6, 4 # holds counter for inner loop
	li $s5, 0 # holds sum
	la $s0, vector_A # holds base address of vector_A
	la $s1, matrix_B # holds base address of matrix_B
	la $s2, vector_C # holds base address of vector_C
	j outer

outer:
	beq $s7, $t8, exit #branch to exit loop if counter is 8
	mul $t4, $s7, $t6 # get i*4 and then add to base address of B to get matrix_B[0][i]
	add $t1, $s1, $t4 # get next part of matrix b

	addi $s7, $s7, 1 # increment counter
	li $s6, 4 # set counter to value
	li $s5, 0 # load 0 into sum register
	la $s0, vector_A # load base address of A inot $s0
	j inner
inner:
	beq $s6, $zero, return # branch to return loop if counter is 0
	addi $s6, $s6, -1 # decrement counter
	lw $t0, 0($s0) # get vector_A[j]
	lw $t2, 0($t1) # get matrix_B[j][i]

	mul $t7, $t0, $t2 # vector_A[j] * matrix_B[j][i]
	add $s5, $s5, $t7 # sum = sum + vector_A[j] * matrix_B[j][i]
	addi $s0, $s0, 4 # iterate address of vector A
	addi $t1, $t1, 0x400 # iterate address of matrix B
	j inner


return:
	sw $s5, 0($s2)  # store sum in vector_C[i]
	addi $s2, $s2, 4 # iterate address of vector_C
	#li $v0, 1
	#addi $a0, $s5, 0
	#syscall
	j outer # return to outer loop

exit:
	li $v0, 10
	syscall
