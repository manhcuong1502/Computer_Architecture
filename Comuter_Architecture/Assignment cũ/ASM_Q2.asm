
	.text
IO_File:
	#Parameter:	# $a1: Name of file will be written or read
			# $a2: Identify function: 0 for Read, 1 for write as a new file, 9 for write as a new file or append.
			# $a3: first address of array to store of write data to file
			
#Open file
	li	$v0, 13 # system call for open file
	move	$a0, $a1 # output file name
	move	$a1, $a2 # Flag
	li	$a2, 0 # mode is ignored
	syscall # open a file (file descriptor returned in $v0)
	move	$s6, $v0 # save the file descriptor
	
	beqz	$a1, Read
	Write:
	move	$t0, $a3
	Count_Length_Of_Array:
		lb	$t1, 0($t0)
		beq	$t1, $0, End_Count_Length
		addi	$a2, $a2, 1
		addi	$t0, $t0, 1
		j	Count_Length_Of_Array 	
	End_Count_Length:
	
	li	$v0, 15
	move	$a0, $s6
	move	$a1, $a3
	syscall
	j	Close
	
	Read:
	li	$v0, 14
	move	$a0, $s6
	move	$a1, $a3
	li	$a2, 2048
	syscall
	
	Close:
	li	$v0, 16
	move	$a0, $s6
	syscall
	
	jr	$ra