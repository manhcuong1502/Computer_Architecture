.data
	array: .space 40
	prompt: .asciiz "Type 10 elements: "
	space: .asciiz "\t"
	descend: .asciiz "descending: "
	sum: .asciiz "Sum: "
	average: .asciiz "Average: "
	min: .asciiz "Min: "
	max: .asciiz "Max: "
.text

.globl main

main:
	li $v0, 4
	la $a0, prompt
	syscall
	la $s1, array
	
	
loop:
	li $v0, 5
	syscall
	sw $v0, 0($s1)
	addi $s1, $s1, 4
	addi $t1, $t1, 1
	bne $t1, 10, loop
	
	la $s1, array
	sub $t1, $t1, $t1
	
	
sorting:
	beq $t2, 9, contsort
	lw $t3, 0($s1)
	lw $t4, 4($s1)
	addi $s1, $s1, 4
	addi $t2, $t2, 1
	bge $t3, $t4, sorting
	sw $t3, 0($s1)
	sw $t4, -4($s1)
	bne $t2, 9, sorting
	
contsort:
	la $s1, array
	addi $t1, $t1, 1
	addi $t2, $t1, 0
	bne $t1, 9, sorting
	
	li $v0, 4
	la $a0, descend
	syscall
	la $s1, array
	sub $t1, $t1, $t1
	
printsort:
	li $v0, 1
	lw $a0, 0($s1)
	syscall
	li $v0, 4
	la $a0, space
	syscall
	addi $s1, $s1, 4
	addi $t1, $t1, 1
	bne $t1, 10, printsort
	
	sub $t1, $t1, $t1
	sub $t2, $t2, $t2
	sub $t3, $t3, $t3
	sub $t4, $t4, $t4
	
	la $s1, array
	li $v0, 4
	la $a0, sum
	syscall
	
#sum:
	lw $t3, 0($s1)
	addi $s1, $s1, 4
	add $t4, $t3, $t4
	addi $t1, $t1, 1
	bne $t1, 10, sum
	
	move $a0, $t4
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, average
	syscall
	
	addi $t7, $t7, 10
	div $t4, $t7
	mflo $s7
	mfhi $s6
	move $a0, $s7
	li $v0, 1
	syscall
	move $a0, $s6
	li $v0, 1
	syscall
	
	la $s1, array
	li $v0, 4
	la $a0, max
	syscall
	
	lw $t5, 0($s1)
	move $a0, $t5
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, min
	syscall
	
	lw $t6, 36($s1)
	move $a0, $t6
	li $v0, 1
	syscall
	
li $v0, 10
syscall
	