	.data
array: .word 0:9 #Declare the array of 5 integer numbers
size: .word 10 #Declare size of array = 5

str1: .asciiz "Type the element at index "
space: .asciiz "\t"
str2: .asciiz "\nThe reverse of array is: \t"
	.text
	la 	$t0, array # load address of array to $t0
	la	$t5, size # load address of size variable
	lw   	$t5, 0($t5) # load array size
	add	$t1, $t5, $0 # save value of array size to $t1
	add	$t2, $0, $0 # create counter for loop: $t2, start from 0

# Loop to get integer number from user

Input: 
# print format "Type the element at index n " where n is index.

	li	$v0, 4 # system call code for printing string, code = 4
	la	$a0, str1 # load address of string to be printed into $a0
	syscall # call operating system to perform operation;
	
	add	$a0, $t2, $0 # copy value of index (counter) to $a0
	li	$v0, 1 # system call code for printing index (integer), code = 1
	syscall # call operating system to perform operation;
	
	li	$v0, 4 # system call code for printing string, code = 4
	la	$a0, space # load address of string " " into $a0
	syscall # call operating system to perform operation;
	
# get integer number from keyboard
	li 	$v0, 5 # system call code for getting integer number, code = 5
	syscall # call operating system to perform operation;
	
	add	$t6, $v0, $0 #copy data to $t6
	sw	$t6, 0($t0) #store data to memory at address in $t0
	addi	$t0, $t0, 4 # increase memory address
	addi	$t2, $t2, 1 # increase counter 1 unit
	blt 	$t2, $t1, Input # check condition counter < size ($t2 < $t1)
				# if true, go to label Input, else continue;

saveArray:
	la	$a2, array # load address of array to $a2
	addi	$a2, $a2, 36 # increase address 4*4 = 16 unit to start at end of array

# Print array in reverseing	
	li	$v0, 4 
	la 	$a0, str2
	syscall

Print:	lw	$a0, 0($a2)
	li	$v0, 1
	syscall
	
	li	$v0, 4
	la	$a0, space
	syscall
	
	addi	$a2, $a2, -4
	subi	$t5, $t5, 1
	bgtz 	$t5, Print # check condition value of $t5 > 0 
				# if True, go to lable Print, else continue
	
	li   $v0, 10          # system call for exit
	syscall               # we are out of here.


