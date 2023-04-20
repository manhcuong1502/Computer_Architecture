	.data
msg0:	.asciiz "Type the number of elements: \t"
msg1: .asciiz "Type the element at index "
msg2: .asciiz "File has been written successfully\n"
space: .asciiz "\t "
sp: .ascii " "
filename: .ascii "testfile.txt"
	.text
main:	
	la $t9, sp
	lb $t9, 3($t9)
	li $v0, 4
	la $a0, msg0
	syscall
	
	li $v0, 5
	syscall
	addi $s1, $v0, 0 #number of element store at $s1
	li $v0, 9	#instruction of sbrk (dynamic array)
	addi $t0, $0, 4
	mult $t0, $s1
	mflo $a0
#	li $a0,4 #
#	syscall
#	li $v0, 9
#	li $a0, 0
	syscall
	move $s0, $v0 #s0 store address of dynamic array
	
	addi $t1, $0, 0 #Counter $t1
Loop:	li $v0, 4
	la $a0, msg1
	syscall
	
	add $a0, $t1, $0
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	li $v0, 5
	syscall
	sw $v0, 0($s0)
	
	addi $s0, $s0, 4
	addi $t1, $t1, 1
	bne $t1, $s1, Loop
	
	li $t1, 4
	mult $s1, $t1
	mflo $t1
	sub $s0, $s0, $t1
	

###############################################################
# Open (for writing) a file that does not exist
	li $v0, 13 # system call for open file
	la $a0, filename # output file name
	li $a1, 1 # Open for writing (flags are 0: read, 1: write)
	li $a2, 0 # mode is ignored
	syscall # open a file (file descriptor returned in $v0)
	move $s6, $v0 # save the file descriptor
	li $t3, 0
	
write:

# Data Processing
	lw $t6, 0($s0)
	li $t0, 0
count_length:
	addi $t0, $t0, 1
	div $t6, $t6, 10
	bnez $t6, count_length
	
	li $v0, 9
	move $a0, $t0
	syscall
	move $t8, $v0
	lw $t6, 0($s0)
	add $t8, $t8, $t0
toAscii:
	div $t6, $t6, 10
	mfhi $t7
	addi $t7, $t7, 48 
	sb $t7, 0($t8)
	addi $t8, $t8, -1
	bnez $t6, toAscii
	addi $t8, $t8, 1

# Write to file just opened
	li $v0, 15 # system call for write to file
	move $a0, $s6 # file descriptor
	la $a1, 0($t8) # address of buffer from which to write
	move $a2, $t0 # hardcoded buffer length
	syscall # write to file

	li $v0, 15 # system call for write to file
	move $a0, $s6 # file descriptor
	la $a1, sp # address of buffer from which to write
	li $a2, 1 # hardcoded buffer length
	syscall # write to file
	
	
	addi $t3, $t3, 1
	addi $s0, $s0, 4
	bne $t3, $s1, write
# Close the file
	li $v0, 16 # system call for close file
	move $a0, $s6 # file descriptor to close
	syscall # close file	
###############################################################
	li $v0, 4
	la $a0, msg2
	syscall

	li $v0, 10
	syscall

