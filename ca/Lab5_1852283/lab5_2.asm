.data
	p: .asciiz "invalid"
	s: .asciiz "\n"
	r: .float 3.141592
	f2: .float 2
	
.text
	li $v0, 6
	syscall
	
	c.lt.s $f0, $f12	
	bc1t e1
	c.eq.s $f0, $f12
	bc1t e2
	
	jal e3
	li $v0, 10
	syscall
	
e1:
	li $v0, 4
	la $a0, p
	syscall
	
	li $v0, 10
	syscall
e2:
	li $v0, 4
	la $a0, s
	syscall
	
	li $v0, 2
	mov.s $f12, $f3
	syscall
	
	li $v0, 4
	la $a0, s
	syscall
	
	li $v0, 2
	mov.s $f12, $f4
	syscall
	
	li $v0, 10
	syscall
e3:
	lwc1 $f1, r
	lwc1 $f2, f2
	
	mul.s $f3, $f0, $f1
	mul.s $f3, $f3, $f2
	mul.s $f4, $f0, $f0
	mul.s $f4, $f4, $f1
	
	j e2