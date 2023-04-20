	.data
fA:	.asciiz "A.txt"
fB:	.asciiz "B.txt"
fRes:	.asciiz "result.txt"
buffer:	.space 2048 #buffer to store data write to file or read from file
dimA:	.word 0,0
dimB:	.word 0,0
dimRes:	.word 0,0
pMatA:	.word 0 #Pointer of matrix A
pMatB:	.word 0 #pointer of matrix B
pMatRes:.word 0 #pointer of matrix Result
msg0:	.asciiz "Input the number of row of multiplier matrix:    \t"
msg1:	.asciiz "Input the number of column of multiplier matrix: \t"
msg2:	.asciiz "Input the number of row of multiplicand matrix:  \t"
msg3:	.asciiz "Input the number of column of multiplicand matrix: \t"

	.text
###---------------- MATRIX MULTIPLICATION PROGRAM ----------------###	
main:
### SET DIMENSION OF RESULT MATRIX ###
	la	$t2, dimRes
### GET DIMENSION OF MULTIPLIER MATRIX ###
	la	$t0, dimA
	li	$v0, 4
	la	$a0, msg0
	syscall
	
	li	$v0, 5
	syscall
	sw	$v0, 0($t0)
	sw	$v0, 0($t2) #Set row of result matrix
	
	li	$v0, 4
	la	$a0, msg1
	syscall
	
	li	$v0, 5
	syscall
	sw	$v0, 4($t0)
	
### GET DIMENSION OF MULTIPLICAND MATRIX ###
	la	$t1, dimB
	li	$v0, 4
	la	$a0, msg2
	syscall
	
	li	$v0, 5
	syscall
	sw	$v0, 0($t1)
	
	li	$v0, 4
	la	$a0, msg3
	syscall
	
	li	$v0, 5
	syscall
	sw	$v0, 4($t1)
	sw	$v0, 4($t2) #Set column of result matrix
	
### Dynamic allocate space for multiplier matrix ###
	lw	$t3, 0($t0)
	lw	$t4, 4($t0)
	mult	$t3, $t4
	mflo	$a0
	li	$a1, 4
	jal	Dynamic_Alloc_Memory
	bnez	$v0, Error

	la	$t0, pMatA
	sw	$v1, 0($t0)
	
### Dynamic allocate space for multiplicand matrix ###
	lw	$t3, 0($t1)
	lw	$t4, 4($t1)
	mult	$t3, $t4
	mflo	$a0
	li	$a1, 4
	jal	Dynamic_Alloc_Memory
	bnez	$v0, Error
	
	la	$t1, pMatB
	sw	$v1, 0($t1)

### Dynamic allocate space for result matrix ###
	lw	$t3, 0($t2)
	lw	$t4, 4($t2)
	mult	$t3, $t4
	mflo	$a0
	li	$a1, 4
	jal	Dynamic_Alloc_Memory
	bnez	$v0, Error

	la	$t2, pMatRes
	sw	$v1, 0($t2)
	
### Randomly generate integer value for matrix ###
	la	$a2, dimA
	la	$a3, pMatA
	lw	$a3, 0($a3)
	jal	Initial_matrix
	
	la	$a2, dimB
	la	$a3, pMatB
	lw	$a3, 0($a3)
	jal	Initial_matrix

### Write Matrix A to file A.txt ###
	la	$a1, buffer
	la	$a2, dimA
	la	$a3, pMatA
	lw	$a3, 0($a3)
	jal 	Mat_2_Ascii_Arr
	la	$a1, fA
	li	$a2, 1
	la	$a3, buffer
	jal	IO_File
	
### Write Matrix B to file B.txt ###
	la	$a1, buffer
	la	$a2, dimB
	la	$a3, pMatB
	lw	$a3, 0($a3)
	jal 	Mat_2_Ascii_Arr
	la	$a1, fB
	li	$a2, 1
	la	$a3, buffer
	jal	IO_File
	
### Compute the product of Matrix A and B, then store to matrix Result
	la	$a0, pMatA
	lw	$a0, 0($a0)
	la	$a1, pMatB
	lw	$a1, 0($a1)
	la	$a2, pMatRes
	lw	$a2, 0($a2)
	jal	Matrix_Mul	
	bnez	$v0, Error # Check error of multiplication

### Write the result matrix to file result.txt ###
	la	$a1, buffer
	la	$a2, dimRes
	la	$a3, pMatRes
	lw	$a3, 0($a3)
	jal 	Mat_2_Ascii_Arr
	la	$a1, fRes
	li	$a2, 1
	la	$a3, buffer
	jal	IO_File
	
	
	li $v0, 10 # End program
	syscall
	
	Error:
	li	$a0, -1
	li	$v0, 1
	syscall
	li	$v0, 10
	syscall

###---------------- END PROGRAM ----------------###



#########################################################################
####################### SOME SUPPORTED PROCEDURES #######################
#########################################################################

Write_Int: #Write an integer to buffer as Ascii code
	#Parameter:	# $a0: An integer will be write
			# $a1: referenc of pointer to buffer
	#Return: None
	li	$t1, 10
	li	$t2, 0
	move	$t0, $a0
	bgez	$t0, Count_Length
	li	$t7, 45
	sb	$t7, 0($a1)
	addi	$a1, $a1, 1
	sub	$a0, $zero, $a0
	move	$t0, $a0
	Count_Length:
		addi	$t2, $t2, 1
		div	$t0, $t1
		mflo	$t0
		bnez	$t0, Count_Length
		
	add	$a1, $a1, $t2

	W_Row:
		addi	$a1, $a1, -1
		div	$a0, $t1
		mflo	$a0
		mfhi	$t0
		addi	$t0, $t0, 48
		sb	$t0, 0($a1)
		bnez	$a0, W_Row

	add	$a1, $a1, $t2
	jr	$ra

Mat_2_Ascii_Arr: # Write an array of matrix to buffer as Ascii code
	# Parameter:	
			# $a1: Address of Array to Store Matrix.
			# $a2: First address of array store matrix Size
			# $a3: First Element Address of Matrix
	#Return: None
	# Save value of: s1, s0, ra
	addi	$sp, $sp, -12
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	
	li	$s0, 32 # Space Ascii
	li	$s1, 10 # Endl Ascii

	li	$t4, 0 #Row Counter
	lw	$t5, 0($a2)
	lw	$t6, 4($a2)

	Row_Reversed:
		beq	$t4, $t5, End_Row_Reversed
		li	$t3, 0
		Col_Reversed:
			beq	$t3, $t6, End_Col_Reversed

			lw	$a0, 0($a3)
			jal	Write_Int
			
			sb	$s0, 0($a1)
			addi	$a1, $a1, 1
			addi	$a3, $a3, 4
			addi	$t3, $t3, 1
			j	Col_Reversed
		End_Col_Reversed:
		sb	$s1, 0($a1)
		addi	$a1, $a1, 1
		addi	$t4, $t4, 1
		j	Row_Reversed
	End_Row_Reversed:
	sb	$zero, 0($a1)
	lw	$s1, 8($sp)
	lw	$s0, 4($sp)
	lw	$ra, 0($sp)
	jr	$ra

	
Initial_matrix:  # Initialize value of matrix
	# Parameter: 	# a2: array dimension of matrix( row and column)
			# a3: address of first element of matrix
	# Return : None
	lw	$t0, 0($a2)
	lw	$t1, 4($a2)
	mult	$t0, $t1
	mflo	$t1	# Number elements of matrix
	li	$t0, 0	#Counter
	li	$a1, 200 #Set upper bound = 200
	Generate_Loop:
		beq	$t0, $t1, End_Generate_Loop
		li	$a0, 0 #Set lower bound = 0
		li	$v0, 42
		syscall
		addi	$a0, $a0, -100
		sw	$a0, 0($a3)
		addi	$t0, $t0, 1
		addi	$a3, $a3, 4
		j	Generate_Loop
	End_Generate_Loop:
	jr	$ra
#########################################################################
#########################################################################
#########################################################################
	
			
########################### READ / WRITE FILE PROCEDURE ###########################

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
	
################################################################################

	
			
######################## DYNAMICALLY ALLOCATE PROCEDURE ########################

Dynamic_Alloc_Memory:
	#Parameter: $a0: number of elements, $a1: size of each element, 
	#Retrun: $v0: success(0) or fail (-1), $v1: first address of array

#Note data need to be saved:

	mult	$a0, $a1
	mflo	$a0
	li	$a1, 65536
	blt	$a1, $a0, fail
#Satisfy allocate condition
	success:
	li	$v0, 9
	syscall
	move	$v1, $v0
	li	$v0, 0
	jr	$ra
#Unsatisfy allocate condition
	fail:
	li	$v0, -1
	li	$v1, 0
	jr	$ra
##############################################################################



###################### MATRIX MULTIPLICATION PROCEDURES ######################
Matrix_Mul:
	#Parameter: $a0: first address of matrix A
		  # $a1: first address of matrix B
		  # $a2: first address of matrix Result
					
	#Return: $v0: Multiply success (0), Multiply fail (-1)
	
	
	la	$t0, dimA 
	la	$t1, dimB 
	lw	$t2, 4($t0)
	lw	$t3, 0($t1)
	bne	$t2, $t3, Unsatisfy
	Satisfy:
	# Note data need to be saved:
	la	$t2, dimRes
	lw	$t3, 0($t2)
	lw	$t4, 4($t2)
	mult	$t3, $t4
	mflo	$t2  # total element of result matrix.
	lw	$t0, 4($t0) # Get number of column of matrix A again to use
	lw	$t1, 4($t1)
	li	$t3, 0	#Counter loop1
	assign_each_resElemt:
	beq	$t3, $t2, return
	li	$t4, 0 #Registor save the result at index $t3
	li	$t5, 0 #Counte loop2
		loop_assign:
		beq	$t5, $t0, end_loop_assign
		### GET INDEX OF MATRIX A ###
		div	$t3, $t1
		mflo	$t6
		mult	$t6, $t0
		mflo	$t6
		add	$t6, $t6, $t5
		sll	$t6, $t6, 2
		### END GET INDEX ###
		
		### GET INDEX OF MATRIX B ###
		mult 	$t5, $t1
		mflo	$t7
		div	$t3, $t1
		mfhi	$t8
		add	$t7, $t7, $t8
		sll	$t7, $t7, 2
		### END GET INDEX ###
		
		### GET VALUE AT INDEX $t6 OF MATRIX A ###
		add	$t6, $a0, $t6
		lw	$t6, 0($t6)
		
		### GET VALUE AT INDEX $t7 OF MATRIX B ###
		add	$t7, $a1, $t7
		lw	$t7, 0($t7)
		
		### COMPUTE VALUE AT INDEX $t3 OF MATRIX RESULT ###
		mult 	$t6, $t7
		mflo	$t6
		add	$t4, $t4, $t6
		
		addi	$t5, $t5, 1
		j	loop_assign
		end_loop_assign:
	sw	$t4, 0($a2)
	addi	$a2, $a2, 4
	addi	$t3, $t3, 1
	j	assign_each_resElemt
	return:
	li	$v0, 0
	jr	$ra
	Unsatisfy:
	li	$v0, -1
	jr	$ra
##############################################################################
		
