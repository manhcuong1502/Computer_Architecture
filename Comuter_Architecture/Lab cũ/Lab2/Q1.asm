	.data
array: .word 2,4,5,6,7,8,9,0,12,13
size: .word 10
str: .asciiz "Sum of all array's elements are: \t"
	.text
	la $t0, array
	la $t1, size
	lw $t1, 0($t1)
	add $t2, $0, $0
	add $t3, $0, $0
	
loop: 	lw $t5, 0($t0)
	add $t3, $t3, $t5
	add $t0, $t0, 4
	addi $t2, $t2, 1
	blt $t2, $t1, loop
	
print: 	li $v0, 4
	la $a0, str
	syscall
	
	add $a0, $0, $t3
	li $v0, 1
	syscall