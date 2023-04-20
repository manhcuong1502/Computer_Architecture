.data 
nhap: .asciiz "1852283 - Nguyen Tran Manh Cuong"
.text 
	lb $s0, nhap
	lb $s1, nhap+31
	lb $s2, nhap
	la $t1, nhap
	sb $s1,($t1)
	addi $t1,$t1,31
	sb $s2,($t1)
	
	li $v0, 4
	la $a0, nhap
	syscall