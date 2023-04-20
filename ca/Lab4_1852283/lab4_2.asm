.data
	iArray: .space 40
	mess1: .asciiz "The max in array:\n"
	mess2: .asciiz "The min in array:\n"
	mess3: .asciiz "The Range\n"
	mess4: .asciiz "\n"
	
	iArray_size: .word 10
.text
	la $s0, iArray
	la $s1, iArray_size
	lb $s1, ($s1)
	mul $s1, $s1, 4
	addi $s2, $0,0
	
	
	jal adss
	
	lb $t1, ($s0)
	addi $s2,$0,0
	jal range
	
	li $v0,4
	la $a0,mess2
	syscall
	li $v0,1
	move $a0,$t3
	syscall
	
	li $v0,4
	la $a0,mess4
	syscall
	la $a0,mess1
	syscall
	li $v0,1
	move $a0,$t4
	syscall
	
	li $v0,4
	la $a0,mess4
	syscall
	la $a0,mess3
	syscall
	li $v0,1
	move $a0, $t5
	syscall
	
	li $v0,10
	syscall
	
#Find range	
range:
	    addi $sp, $sp, -4 
	    sw $ra, 0($sp)
	        
	    addi $s2, $0, 4
	    lw $t4,($s0)
	    jal max
	    
	    addi $s2, $0, 4
	    lw $t3, ($s0)
	    jal min
	    
	    sub $t5, $t4, $t3
	    
	    lw $ra, 0($sp) 
	    addi $sp, $sp, 4
	    jr $ra
	    
##Find Min 	    
min:
	    add $s3,$s0,$s2
	    lw $t2,($s3)
	    blt $t3, $t2, l1
	    add $t3, $t2, 0
	    
l1:
	    addi $s2,$s2,4
	    blt $s2,$s1, min
	    jr $ra
#Find Max
max:
	    add $s3, $s0, $s2
	    lw $t2, ($s3)
	    bgt $t4, $t2, l2
	    add $t4, $t2,0
l2:
	    addi $s2,$s2,4
	    blt $s2, $s1, max
	    jr $ra
	    

adss: 
	    li $v0,5
	    syscall
	    add $s3,$s0,$s2
	    sw $v0,($s3)
	    addi $s2,$s2,4
	    blt $s2,$s1, adss
	    jr $ra
	    
	
