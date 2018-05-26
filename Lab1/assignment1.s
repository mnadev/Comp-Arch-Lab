# Mohammad Nadeem
# RUID:1720004960 netid: mn535

.text

main:
	# The corresponding binary code
	# instruction can be found in the lab writeup.

	addi $3, $zero, 5
	# for this instruction, the opcode is addi
	# rs is $0, while $rt is $3,
	# the constant is 5

	mul $8, $8, $12
	# for this instruction, the opcode is mul
	# rs is $8 while rt is $12
	# rd in this case is $8, since it is the destination register
	# the shift amount (shamt) is zero in this case
	# the function is nonexistent
	li $v0, 10
	syscall
