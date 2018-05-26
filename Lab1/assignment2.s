# Mohammad Nadeem
# RUID:1720004960 netid: mn535

.text
	main:
		# translate following C code to MIPS
		# A[8*i] = A[2*i] - B[2*i];

		# part a
		# assume size of elements in arrays A and B are one byte
		sll $t0, $s3, 1 #multiply i by 2
		sll $t1, $s3, 3 #multiply i by 8
		add $t5, $t1, $s6 #address of A[8i]
		add $t6, $t0, $s6 # address of A[2i]
		add $t7, $t0, $s7 # address of B[2i]
		lb $t2, 0($t6) #load A[2i] into $t2
		lb $t3, 0($t7) #load B[2i] into $t3
		sub $t4, $t2, $t3 #assume A[2i] is stored in $t2 and B[2i] is stored in $t3
		sb $t4, 0($t5)  #store $t4 into A[8i]

		# part b
		# assume size of elements in arrays A and B are four bytes
		sll $t0, $s3, 3 #multiply i by 8
		sll $t1, $s3, 5 #multiply i by 32
		add $t5, $t1, $s6 #address of A[8i]
		add $t6, $t0, $s6 # address of A[2i]
		add $t7, $t0, $s7 # address of B[2i]
		lw $t2, 0($t6)  #load A[2i] into $t2
		lw $t3, 0($t7)  #load B[2i] into $t3
		sub $t4, $t2, $t3 #assume A[2i] is stored in $t2 and B[2i] is stored in $t3
		sw $t4, 0($t5) #store $t4 into A[8i]

		li $v0, 10
		syscall
