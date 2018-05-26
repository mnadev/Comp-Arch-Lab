# Mohammad Nadeem, 172004960
# Lab Section 2B
# Lab 5, Assignment 4

.data 0x10000800
ArrayARow_0: .word 1,2,3,4,5,6
ArrayARow_1: .word 7,8,9,10,11,12
ArrayARow_2: .word 13,14,15,16,17,18
ArrayARow_3: .word 19,20,21,22,23,24
ArrayARow_4: .word 25,26,27,28,29,30
ArrayARow_5: .word 31,32,33,34,35,36
.data 0x10000900
ArrayBRow_0: .word 72,70,68,66,64,62
ArrayBRow_1: .word 60,58,56,54,52,50
ArrayBRow_2: .word 48,46,44,42,40,38
ArrayBRow_3: .word 36,34,32,30,28,26
ArrayBRow_4: .word 24,22,20,18,16,14
ArrayBRow_5: .word 12,10,8,6,4,2

.text 0x00400000
main:
#Your code starts from here
	li $s7, 6 # load length of matrices
	la $t0, ArrayARow_0 # load address of first row of A
	la $t1, ArrayBRow_0 # load address of first row of B

loop_0:
	beq $s7, $zero, loop_1_init # exit if $s7 == 0
	addi $s7,$s7, -1 # decrement s7
	lw $s0, 0($t0) # load elelment in A
	lw $s1, 0($t1) # load element in B

	sw $s0, 0($t1) # store A element in B
	sw $s1, 0($t0) # store B element in A
	j loop_0 # loop back

loop_1_init:
	li $s7, 6 # load length of arrays
	la $t0, ArrayARow_1 # load address of second row of A
	la $t1, ArrayBRow_1 # load address of second row of B
	j loop_1

loop_1:
	beq $s7, $zero, loop_2_init # exit if $s7 == 0
	addi $s7,$s7, -1 # decrement s7
	lw $s0, 0($t0) # load elelment in A
	lw $s1, 0($t1) # load element in B

	sw $s0, 0($t1) # store A element in B
	sw $s1, 0($t0) # store B element in A
	j loop_1 # loop back

loop_2_init:
	li $s7, 6 # load length of matrices
	la $t0, ArrayARow_2 # load address of third row of A
	la $t1, ArrayBRow_2 # load address of third row of B
	j loop_2

loop_2:
	beq $s7, $zero, loop_3_init # exit if $s7 == 0
	addi $s7,$s7, -1 # decrement s7
	lw $s0, 0($t0) # load elelment in A
	lw $s1, 0($t1) # load element in B

	sw $s0, 0($t1) # store A element in B
	sw $s1, 0($t0) # store B element in A
	j loop_2 # loop back

loop_3_init:
	li $s7, 6 # load length of matrices
	la $t0, ArrayARow_3 # load address of fourth row of A
	la $t1, ArrayBRow_3 # load address of fourth row of B
	j loop_3

loop_3:
	beq $s7, $zero, loop_4_init # exit if $s7 == 0
	addi $s7,$s7, -1 # decrement s7
	lw $s0, 0($t0) # load elelment in A
	lw $s1, 0($t1) # load element in B

	sw $s0, 0($t1) # store A element in B
	sw $s1, 0($t0) # store B element in A
	j loop_3 # loop back

loop_4_init:
	li $s7, 6 # load length of matrices
	la $t0, ArrayARow_4 # load address of fifht row of A
	la $t1, ArrayBRow_4 # load address of fifth row of B
	j loop_4

loop_4:
	beq $s7, $zero, loop_5_init # exit if $s7 == 0
	addi $s7,$s7, -1 # decrement s7
	lw $s0, 0($t0) # load elelment in A
	lw $s1, 0($t1) # load element in B

	sw $s0, 0($t1) # store A element in B
	sw $s1, 0($t0) # store B element in A
	j loop_4 # loop back

loop_5_init:
	li $s7, 6 # load length of matrices
	la $t0, ArrayARow_5 # load address of sixth row of A
	la $t1, ArrayBRow_5 # load address of sixth row of B
	j loop_5

loop_5:
	beq $s7, $zero, exit # exit if $s7 == 0
	addi $s7,$s7, -1 # decrement s7
	lw $s0, 0($t0) # load elelment in A
	lw $s1, 0($t1) # load element in B

	sw $s0, 0($t1) # store A element in B
	sw $s1, 0($t0) # store B element in A
	j loop_5 # loop back

exit:
	li $v0, 10
	syscall
