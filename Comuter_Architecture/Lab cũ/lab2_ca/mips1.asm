	.data
str: .asciiz "Ho Chi Minh City University of Technology\n"
invStr: .asciiz "\nThe Inverse string is: "
space:	.ascii " \0"
ch: .byte
length: .word 41

	.text
	la 	$s0, str
	la	$t0, ch
	la	$s1, length
	lw	$s1, 0($s1)
	
PrintStr:
	li	$v0, 4
	la	$a0, 0($s0)
	syscall		
	addi	$t1, $0, 0
	
PrintinvStr:	
	li	$v0, 4
	la	$a0, space
	syscall
	addi	$s0, $s0, 1
	addi	$t1, $t1, 1
	bne	$t1, $s1, PrintinvStr

#Print Inverse String

	li	$v0, 4
	la	$a0, invStr
	syscall
Print:
	addi	$s0, $s0, -1
	addi	$t1, $t1, -1
	lb	$t2, 0($s0)
	sb	$t2, ch 
	li	$v0, 4
	la	$a0, ch
	syscall
	bgtz 	$t1, Print
	
	li	$v0, 10
	syscall
	
	
