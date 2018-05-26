# program 1 is used in assignments 1 and 2
.text 0x00400000
		.globl main
		
main:

		lw $10, Number1($0) # this instruction loads word from RAM
		ori $11, $0, 1  # OR immediate instruction
		ori $9, $0, 1
	
# compute factorial of Number ($10)!
factloop: 
		bge $11, $10, factexit # branch greater or equal instruction
		mul $9, $10, $9 # multiply contents of regs 10 and 9, store in 9
		sub $10, $10, 1 # subtract 1 from 10, store in 10
		j factloop # jump to label factloop

factexit:
		# computation of factorial number has finished now.
		# we want to know if the result is correct, result in 9 is in hexadecimal
		
		li $2, 10 # load immediate number 10 into reg 2
		syscall
			
			.data 0x10000000
			.align 2
			
		Number1: .word 18