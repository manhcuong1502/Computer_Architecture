	.data
filename: 	.asciiz "testfile.txt"
buffer: 	.asciiz "abcde\n"
	.text
main:
	la $a0, filename
	la $a2, buffer
	li $a1, 1
	jal read_write_File
	li $v0, 10
	syscall
#data_process:
	

read_write_File: #argument $a0 to store file name
		# argument $a1 to identify : Read(0), Write(1)
		# argument $a2 to store address of buffer
	addi  $sp, $sp, -8
	sw $ra, 0($sp)
	sw $a2, 4($sp)
#Open file
	li $v0, 13 # system call for open file
	li $a2, 0 # mode is ignored
	syscall # open a file (file descriptor returned in $v0)
	move $s6, $v0 # save the file descriptor
###############################################################
	
	beqz $a1, Read # if a1 = 0 do read instruction, else do write instruction
	
	Write:
	li $v0, 15 # system call for write to file
	move $a0, $s6 # file descriptor
	lw $a1, 4($sp) #load address of buffer memory to a1
	
#Count number of character will be read	
	move $s0, $a1 
	li $t0, 0
	
	count:
	lb $t1, 0($s0)
	addi $t0, $t0, 1
	addi $s0, $s0, 1
	bnez $t1, count
	addi $t0, $t0, -1
##############################################################

	move  $a2, $t0 # hardcoded buffer length
	syscall # write to file
	j Close
	
	Read:
# Read from file
	li $v0, 14 # system call for read
	move $a0, $s6 # file descriptor
	lw $a1, 4($sp) # address of buffer read
	li $a2, 2048 # hardcoded buffer length
	syscall # read file
# Close file
	Close:
	li $v0, 16 # system call for close file
	move $a0, $s6 # file descriptor to close
	syscall # close file
	lw $ra, 0($sp)
	addi $sp, $sp, 8
	jr $ra
	