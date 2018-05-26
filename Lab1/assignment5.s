# Mohammad Nadeem
# RUID:1720004960 netid: mn535

.text

main:
  li $t0, -1
  j out
  out:
  addi, $t0, $t0, 1 # iterate i
  beq $t0, $s0, end # start with for loop condition for i
    li $t1, 0 # set j to 0
    in:
    beq $t1, $s1, out # for loop condition for j
      #square i and j
      mult $t0, $t0
      mflo $t2 # store i**2
      mult $t1, $t1
      mflo $t3 # store j**2
      add $t2, $t3, $t2 # add i^2 and j^2
      sll $t3, $t1, 2 #multiply j by 4
      add $t3, $t3, $s2 #get address of D[j]
      sw $t2, 0($t3) #store result in D[j]
      addi $t1, $t1, 1 # iterate j
      j in
  end:
  li $v0, 10
  syscall
