.data 
	input: .asciiz "Computer Architecture CSE-HCMUT"
	
.text 
	la $t1, input
	lb $s1,($t1)
	addi $t2,$zero,0
	
case0:
	lb $s1,($t1)
	beq $s1, 114,case1
	beq $s1, 0, case2
	la $t1, input
	add $t1,$t1,$t2
	addi $t2,$t2,1
	b case0
	
case1:
	add $a0,$t2,-1
	li $v0,1
	syscall 
	li $v0,10
	syscall
	
case2:
	la $a0,-1
	li $v0,1
	syscall