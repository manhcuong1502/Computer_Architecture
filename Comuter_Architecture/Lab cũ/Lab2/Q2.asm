	.data
array: .word 2,4,5,6,7,8,9,0,12,13
size: .word 10
str0: .asciiz "\nSum of all array's elements at odd index are: \t"
str1: .asciiz "\nSum of all array's elements at even index are: \t"
	.text
	la $t0, array
	la $t1, size
	lw $t1, 0($t1)
	add $t2, $0, $0 # $t2 is counter
	add $t3, $0, $0 # $t3 store sum of even index
	add $t6, $0, $0 # $t6 store sum of odd index
	addi $t7, $0, 2
	
loop: 	lw $t5, 0($t0)
	div $t2, $t7
	mfhi $t8
	beq $t8, $0, addEven
addOdd:	add $t6, $t6, $t5
cont:	add $t0, $t0, 4
	addi $t2, $t2, 1
	blt $t2, $t1, loop
	j print	
	
addEven: add $t3, $t3, $t5
	j cont

print: 	li $v0, 4
	la $a0, str1
	syscall
	
	add $a0, $0, $t3
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, str0
	syscall
	
	add $a0, $0, $t6
	li $v0, 1
	syscall