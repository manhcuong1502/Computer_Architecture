.data
str0: .asciiz "Computer Science and Engineering, HCMUT" 
str1: .asciiz "Computre Architecture 2022"
.text 

main:
	li $v0, 5
	syscall
	
	addi $s0, $v0, 0
	add $t1, $zero, 2
	div $s0, $t1
	mfhi $s1
	beq $s1, 1, case0
	
default:
	la $a0, str0
	li $v0, 4
	syscall
	j exit
	
case0:
	la $a0, str1
	li $v0, 4
	syscall

exit: 
	li $v0, 10
	syscall 
	