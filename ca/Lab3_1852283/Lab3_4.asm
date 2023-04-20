.data
	throw: .asciiz "invalid input"
.text 
	li $v0,5
	syscall
	add $s0,$v0,$zero
	
	blt $s0,0,case1
	beq $s0,0,case2
	beq $s0,1,case3
	b case4
	
case1:
	la $a0, throw
	li $v0,4
	syscall
	j exit
	
case2:
	add $a0,$zero,$zero
	li $v0,1
	syscall
	j exit
	
case3:
	add $a0,$zero,1
	li $v0,1
	syscall
	j exit
	
case4:
	add $s1,$zero,$zero
	addi $s2,$zero,1
	
case5:
	beq $s0, 1,case6
	add $s3,$s2,$zero
	add $s2, $s2,$s1
	add $s1,$s3,$zero
	addi $s0,$s0,-1
	
	b case5
	
case6:
	add $a0,$s2,$zero
	li $v0,1
	syscall 
	
exit: 
	li $v0,10
	syscall 
