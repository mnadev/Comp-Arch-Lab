# Registers used:
# t0 - used to hold the original number
# t1 - used to hold NOT of the original number
.text
main:
li $t0, -106 # place the binary equivalent of -106 into register $t0
not $t1, $t0 # place NOT of -106 into register t1

li $v0, 1
la $a0, 0($t0)
syscall

li $v0, 1
la $a0, 0($t1)
syscall

li $v0,10 # place the binary equivalent of 10 into #register $v0
syscall # run syscall function for exit
# end of program