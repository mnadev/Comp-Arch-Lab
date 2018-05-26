# Mohammad Nadeem, 172004960
# Lab Section 2B
# Lab 5, Assignment 2

.data 0x10000480

Array_A: .word 1,1,1,1,5,5,5,5,,10,10,10,10,15,15,15,15

Array_B: .word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16

.text
.globl main
 main:
la $2, Array_A
la $3, Array_B
li $6, 0 # result=0
li $4, 10 #number of elements
li $8, 0 # $8 will hold sum(Array_A[i]*Array_B[i])
loop: lw $5, 0($2)
lw $7, 0($3)
mul $5, $5, $7
add $8, $5, $8 # sum = sum + Array_A[i]*Array_B[i]
sub $6,$6,$5 #result= result + Array_A[i]*Array_B[i]
addi $2,$2,4
addi $3,$3,4
addi $4,$4,-1
sw $6, 0($3) #Array_B[i+1] = result
bgt $4, $0, loop #end of program
li $2, 10
syscall
