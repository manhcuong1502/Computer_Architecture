.data
	b1: .word 100
	c1: .word 2
.text 
	li $v0,5
	syscall
	add $s0,$v0,$zero
	lw $s2,b1
	lw $s3,c1
	
	beq $s0,1,case1
	beq $s0,2,case2
	beq $s0,3,case3
	beq $s0,4,case4
	b default
case1:
	add $s0,$s2,$s3
	add $a0,$s0,$zero
	li $v0,1
	syscall
	j exit
	
case2:
	sub $s0,$s2,$s3
	add $a0,$s0,$zero
	li $v0,1
	syscall
	j exit
	
case3:
	mul $s0,$s2,$s3
	add $a0,$s0,$zero
	li $v0,1
	syscall
	j exit
	
case4:
	div $s0,$s2,$s3
	add $a0,$s0,$zero
	li $v0,1
	syscall
	j exit
	
default:
	add $s0,$zero,$zero
	add $a0,$s0,$zero
	li $v0,1
	syscall
	j exit
	
exit: 
	li $v0,10
	syscall 
