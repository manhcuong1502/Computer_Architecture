.data 
	array: .space 80
	num: .word 20
	a: .asciiz "\n"
	
.text
	la $t1, array
	
	add $t0, $0, $0
	lw $s0, num
	mul $s0, $s0, 4
	jal ess
	
	lwc1 $f3, array
	lwc1 $f4, array
	add $t0, $0, 4
	la $t1, array
	jal mem
	
	jal e2
	
	li $v0, 10
	syscall
	
ess:
	li $v0, 6
	syscall
	
	add $t1, $t1, 4
	swc1 $f0, ($t1)
	add $t0, $t0, 4
	
	blt $t0, $s0, ess
	jr $ra
	
mem:
	add $t1, $t1, 4
	lwc1 $f1, ($t1)
	c.lt.s $f1, $f3
	bc1t e0
	mov.s $f3, $f1
	
e0:
	c.lt.s $f4, $f1
	bc1t e1
	mov.s $f4, $f1
	
e1:
	addi $t0, $t0, 4
	ble $t0, $s0, mem
	jr $ra

e2:
	li $v0, 4
	la $a0, a
	syscall
	
	li $v0, 2
	mov.s $f12, $f4
	syscall
	
	li $v0, 4
	la $a0, a
	syscall
	
	li $v0, 2
	mov.s $f12, $f3
	syscall
	
	li $v0, 10
	syscall
	
