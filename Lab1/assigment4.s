# Mohammad Nadeem
# RUID:1720004960 netid: mn535

#1.	Register $v0 is the register that has the system call
#coded loaded into it when syscall is run. Based on that
#value in $v0, the operating system runs a specific operation.
#Register $v0 holds the value that is returned when a function
#is returned a value. Otherwise, if a function does not
#return a value, the register $v0 does not hold a value.
.text
  main:
      #display to user to input number
      li $v0, 4
      la $a0, side
      syscall

      #get user input
      li $v0, 5
      syscall

      #calculating cube of the number
      addi $t0, $v0, 0
      mult $v0, $v0
      mult $v0, $t0
      addi $t0, $v0, 0

      #printing out result
      li $v0, 1
      li $a0, $t0
      syscall

      li $v0, 10
    	syscall

.data
  side: .asciiz "Enter side length"
  mess: .asciiz "\nCalculating cube’s volume with side  inches"
