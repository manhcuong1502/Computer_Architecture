
	.data
file: .asciiz "testfile.txt" # filename for output
msg0: .asciiz "Max value of array is \t"
buffer_read: .space 1024
ch: .word 1234
	.text
li $t0, 32 #save code of 'space' in hexa to $t0

# Open (for reading) a file
li $v0, 13 # system call for open file
la $a0, file # output file name
li $a1, 0 # Open for writing (flags are 0: read, 1: write)
li $a2, 0 # mode is ignored
syscall # open a file (file descriptor returned in $v0)
move $s6, $v0 # save the file descriptor
###############################################################
# Read from file
li $v0, 14 # system call for read
move $a0, $s6 # file descriptor
la $a1, buffer_read # address of buffer read
li $a2, 1024 # hardcoded buffer length
syscall # read file

move $t3, $v0 #save length of string
# Close the file
li $v0, 16 # system call for close file
move $a0, $s6 # file descriptor to close
syscall # close file

la $s0, buffer_read
li $t9, 0 #registor store max value
li $t8, 0 #current element reading
li $t7, 0 #count letter
read:

lb $t1, 0($s0)
addi $t7, $t7, 1
beq $t1, $t0, compare
addi $t1, $t1, -48
mul $t8, $t8, 10
add $t8, $t8, $t1
j setcondition
compare:
addi $t6, $t8, 0
li $t8, 0
ble $t6, $t9, setcondition
move $t9, $t6
setcondition:
addi $s0, $s0, 1
bne $t3, $t7, read

li $v0, 4
la $a0, msg0
syscall

li $v0, 1
move $a0, $t9
syscall

li $v0, 10
syscall
