.data
.text 
	li $v0,5
	syscall
	add $s0,$v0,$zero
	
	li $v0,5
	syscall
	add $s1,$v0,$zero
	
	li $v0,5
	syscall
	add $s2,$v0,$zero
	
	blt $s2,-3,case0
	bge $s2,7,case0
	
default:
	add $s2,$s0,$s1
	add $a0,$s2,$zero
	
	li $v0,1
	syscall
	j exit
	
case0:
	mul $s2,$s0,$s1
	add $a0,$s2,$zero
	li $v0,1
	syscall

exit: 
	li $v0,10
	syscall 