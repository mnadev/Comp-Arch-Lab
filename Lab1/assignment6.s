# Mohammad Nadeem
# RUID:1720004960 netid: mn535

.text
 main:

      #display to user to input number a1
      li $v0, 4
      la $a0, a1
      syscall

      #get input
      li $v0, 5
      syscall

      addi $t0, $v0, 0 #store in $t0

      #display to user to input number n
      li $v0, 4
      la $a0, n
      syscall

      #get input
      li $v0, 5
      syscall

      addi $t1, $v0, 0 #store in $t1

      #display to user to input number d
      li $v0, 4
      la $a0, d
      syscall

      #get input
      li $v0, 5
      syscall

      addi $t2, $v0, 0 #store in $t2

      #now
      #for loop
      loop:
        beq $t1, $zero, exit
        add $t0, $t0, $t2
        addi $t1, $t1, -1
        j loop
      exit:
      li $v0, 10
    	syscall

.data
  a1: .asciiz "Enter a1"
  n: .asciiz "Enter n"
  d: .asciiz "Enter d"
