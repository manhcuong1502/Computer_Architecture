.data
array: .space 40
prompt1: .asciiz "\n Enter 10 positive integers: \n"
prompt2: .asciiz "\n\n Which base would you like for the numbers? \n"
newLine: .asciiz "\n"
maxMessage: .asciiz "\n Max = "
minMessage: .asciiz "\n Min = "
avgMessage: .asciiz "\n Avg = "

.text
.globl main

main:
jal inputArray
jal findMMA
# jal convert
# jal done

inputArray:
li $t0, 0 # sets index to 0
li $t1, 0 # sets input num to 0
li $t2, 0 # sets count to 0

li $v0, 4 # print the prompt
la $a0, prompt1
syscall # asks OS to print message

loop:
beq $t2, 10, done # if count = 10, loop to main
li $v0, 5 # service number to read integer
syscall # asks OS to read integer
move $t1, $v0 # sets input to num
sb $t1, array($t0) # stores integer in array
addi $t0, $t0, 4 # increments index by 4
addi $t2, $t2, 1 # increments count
j loop # around input loop
done:
jr $ra

findMMA:
li $t3, 0 # sets sum to 0
li $t5, 0 # sets max to 0
la $t4, ($t1) # sets min to last number entered
li $t6, 0 # sets avg to 0
li $t0, 0 # clears index to 0
li $t2, 0 # clears count to 0

while:
beq $t2, 10, avg # exits loop when everything is read
lw $t1, array($t0)
add $t3, $t3, $t1 # calculates sum
bgt $t1, $t4, max # checks for min
move $t4, $t1 # changes min
max:
blt $t1, $t5, avg # checks for max
move $t5, $t1 # changes max

addi $t0, $t0, 4 # increments address
addi $t2, $t2, 1 # increments count
j while
avg:
div $t6, $t3, $t2 # calculates average

li $v0, 4 # service number
la $a0, maxMessage
syscall # asks OS to print message

li $v0, 1 # service number
move $a0, $t5
syscall # asks OS to print max

li $v0, 4 # service number
la $a0, minMessage
syscall # asks OS to print message

li $v0, 1 # service number
move $a0, $t4
syscall # asks OS to print min

li $v0, 4 # service number
la $a0, avgMessage
syscall # asks OS to print message

li $v0, 1 # service number
move $a0, $t6
syscall # asks OS to print avg

li $v0, 10
syscall

#convert:
#done:
