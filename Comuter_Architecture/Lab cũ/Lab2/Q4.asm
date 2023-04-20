	.data
array: .word 0:9 #Declare the array of 5 integer numbers
size: .word 10 #Declare size of array = 5

str1: .asciiz "\nType the element that is greater than 0 and less than 10 at index "

space: .asciiz ":\t"
str2: .asciiz "\nPlease type again the element that is greater than 0 and less than 10:\t"
str3: .asciiz "\nThe element has just been collected is: \t"
	.text
	la 	$t0, array # load address of array to $t0
	la	$s0, size # load address of size variable
	lw   	$s0, 0($s0) # load array size
	add	$t1, $0, $0 # create counter for loop: $t1, start from 0
	addi	$t2, $0, 10

# Loop to get integer number from user

Input: 
# print format "Type the element at index n " where n is index.

	li	$v0, 4 # system call code for printing string, code = 4
	la	$a0, str1 # load address of string to be printed into $a0
	syscall # call operating system to perform operation;
	
	add	$a0, $t1, $0 # copy value of index (counter) to $a0
	li	$v0, 1 # system call code for printing index (integer), code = 1
	syscall # call operating system to perform operation;
	
	li	$v0, 4 # system call code for printing string, code = 4
	la	$a0, space # load address of string " " into $a0
	syscall # call operating system to perform operation;
	
# get integer number from keyboard
GetN:
	li 	$v0, 5 # system call code for getting integer number, code = 5
	syscall # call operating system to perform operation;
	
	blez	$v0, TypeAgain
	subi	$t3, $v0, 10
	bgez	$t3, TypeAgain
	j	StoreData
		
TypeAgain:
	li	$v0, 4
	la	$a0, str2
	syscall
	j 	GetN
	
StoreData:
	sw	$v0, 0($t0) #store data to memory at address in $t0
	add	$t3, $v0, $0
	li	$v0, 4
	la	$a0, str3
	syscall
	
	add	$a0, $t3, $0
	li	$v0, 1
	syscall
	
	addi	$t0, $t0, 4 # increase memory address
	addi	$t1, $t1, 1 # increase counter 1 unit
	blt 	$t1, $s0, Input # check condition counter < size ($t2 < $t1)
				# if true, go to label Input, else continue;
