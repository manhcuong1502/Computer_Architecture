	.text
Dynamic_Alloc_Memory:
	#Parameter: $a0: number of elements, $a1: size of each element, 
	#Retrun: $v0: success(0) or fail (-1), $v1: first address of array

#Note data need to be saved:

	mult	$a0, $a1
	mflo	$a0
	li	$a1, 65536
	blt	$a1, $a0, fail
#Satisfy allocate condition
	success:
	li	$v0, 9
	syscall
	move	$v1, $v0
	li	$v0, 0
	jr	$ra
#Unsatisfy allocate condition
	fail:
	li	$v0, -1
	li	$v1, 0
	jr	$ra