.data
	curr:	.asciiz 	"\nCurent state:\n"
	start:	.asciiz		"Let`s play tic-tac-toe 3x3"
	chooseway1:	.asciiz		"\nPlayer 1 choose your move:"
	chooseway2:	.asciiz		"\nPlayer 2 choose your move:"
	chagain1:	.asciiz		"\nPlayer 1 chose a already move, please choose another:"
	chagain2:	.asciiz		"\nPlayer 2 chose a already move, please choose another:"
	player1win:	.asciiz		"\nPlayer 1 wins"
	player2win:	.asciiz		"\nPlayer 2 wins"
	draw:		.asciiz		"\nDraw"
	line1str:	.asciiz		"1 2 3\n"
	line2str:	.asciiz		"4 5 6\n"
	line3str:	.asciiz		"7 8 9"
.text
main:
	la	$s0, line1str
	la	$s1, line2str
	la	$s2, line3str
	addi	$s3, $0, 0	#Using to check already move
	
	addi	$s7, $0, 1	#Player1 go  first X is 1, O is 2
	addi	$s6, $0, 0	#movement times
	
	li	$v0, 4
	la	$a0, start
	syscall
	
	li	$v0, 4
	la	$a0, curr
	syscall
	
	li	$v0, 4
	addi	$a0, $s0, 0
	syscall
	
	li	$v0, 4
	addi	$a0, $s1, 0
	syscall
	
	li	$v0, 4
	addi	$a0, $s2, 0
	syscall
	
whosnext:
	addi 	$t3, $0, 0	#Ket qua so sanh o duoi
	beq	$s7, 1, playX
	beq	$s7, 2,	playO
	
	
playX:
	li	$v0, 4
	la	$a0, chooseway1
	syscall
	
	li 	$v0, 12
	syscall
	add	$t1, $0, $v0
	j	whereabout1
chooseagain1:		#need to check after having check win lose
	addi	$s3, $0, 0
	li	$v0, 4
	la	$a0, chagain1
	syscall
	
	li 	$v0, 12
	syscall
	add	$t1, $0, $v0
whereabout1:
	addi	$t0, $0, 88
	slti	$t3, $t1, 52
	beq	$t3, 1, lineX1
	slti	$t3, $t1, 55
	beq	$t3, 1, lineX2
	slti	$t3, $t1, 58
	beq	$t3, 1, lineX3
	
	lineX1:
	beq	$t1, 49, slotX1.1
	beq	$t1, 50, slotX1.2
	beq	$t1, 51, slotX1.3
		slotX1.1:
	lb	$s3, 0($s0)
	beq	$s3, 88, chooseagain1
	beq	$s3, 79, chooseagain1
	
	sb	$t0, 0($s0)
	
	jal	checkresult
	j	nextstep
		slotX1.2:	
	lb	$s3, 2($s0)
	beq	$s3, 88, chooseagain1
	beq	$s3, 79, chooseagain1
	
	sb	$t0, 2($s0)
	
	jal	checkresult
	j	nextstep
		slotX1.3:
	lb	$s3, 4($s0)
	beq	$s3, 88, chooseagain1
	beq	$s3, 79, chooseagain1
				
	sb	$t0, 4($s0)
	
	jal	checkresult
	j	nextstep
	lineX2:
	beq	$t1, 52, slotX2.1
	beq	$t1, 53, slotX2.2
	beq	$t1, 54, slotX2.3	
		slotX2.1:
	lb	$s3, 0($s1)
	beq	$s3, 88, chooseagain1
	beq	$s3, 79, chooseagain1
				
	sb	$t0, 0($s1)
	
	jal	checkresult
	j	nextstep
		slotX2.2:
	lb	$s3, 2($s1)	
	beq	$s3, 88, chooseagain1
	beq	$s3, 79, chooseagain1	
		
	sb	$t0, 2($s1)
	
	jal	checkresult
	j	nextstep
		slotX2.3:
	lb	$s3, 4($s1)
	beq	$s3, 88, chooseagain1
	beq	$s3, 79, chooseagain1	
				
	sb	$t0, 4($s1)
	
	jal	checkresult
	j	nextstep
	lineX3:
	beq	$t1, 55, slotX3.1
	beq	$t1, 56, slotX3.2
	beq	$t1, 57, slotX3.3	
		slotX3.1:
	lb	$s3, 0($s2)
	beq	$s3, 88, chooseagain1
	beq	$s3, 79, chooseagain1	
				
	sb	$t0, 0($s2)
	
	jal	checkresult
	j	nextstep
		slotX3.2:
	lb	$s3, 2($s2)
	beq	$s3, 88, chooseagain1
	beq	$s3, 79, chooseagain1	
		
	sb	$t0, 2($s2)
	
	jal	checkresult
	j	nextstep
		slotX3.3:	
	lb	$s3, 4($s2)
	beq	$s3, 88, chooseagain1
	beq	$s3, 79, chooseagain1	
		
	sb	$t0, 4($s2)
	
	jal	checkresult
	j	nextstep
	nextstep:	
	addi	$s7, $0, 2
	j	whosnext
	
	
playO:
	li	$v0, 4
	la	$a0, chooseway2
	syscall
	
	li 	$v0, 12
	syscall
	add	$t1, $0, $v0
	j	whereabout2
chooseagain2:		#need to check after having check win lose
	addi	$s3, $0, 0
	li	$v0, 4
	la	$a0, chagain2
	syscall
	
	li 	$v0, 12
	syscall
	add	$t1, $0, $v0
whereabout2:
	addi	$t0, $0, 79
	slti	$t3, $t1, 52
	beq	$t3, 1, lineO1
	slti	$t3, $t1, 55
	beq	$t3, 1, lineO2
	slti	$t3, $t1, 58
	beq	$t3, 1, lineO3
	
	lineO1:
	beq	$t1, 49, slotO1.1
	beq	$t1, 50, slotO1.2
	beq	$t1, 51, slotO1.3
		slotO1.1:
	lb	$s3, 0($s0)
	beq	$s3, 88, chooseagain2
	beq	$s3, 79, chooseagain2
	
	sb	$t0, 0($s0)
	
	jal	checkresult
	j	nextstep2
		slotO1.2:	
	lb	$s3, 2($s0)
	beq	$s3, 88, chooseagain2
	beq	$s3, 79, chooseagain2
	
	sb	$t0, 2($s0)
	
	jal	checkresult
	j	nextstep2
		slotO1.3:
	lb	$s3, 4($s0)
	beq	$s3, 88, chooseagain2
	beq	$s3, 79, chooseagain2
				
	sb	$t0, 4($s0)
	
	jal	checkresult
	j	nextstep2
	lineO2:
	beq	$t1, 52, slotO2.1
	beq	$t1, 53, slotO2.2
	beq	$t1, 54, slotO2.3	
		slotO2.1:
	lb	$s3, 0($s1)
	beq	$s3, 88, chooseagain2
	beq	$s3, 79, chooseagain2
				
	sb	$t0, 0($s1)
	
	jal	checkresult
	j	nextstep2
		slotO2.2:
	lb	$s3, 2($s1)	
	beq	$s3, 88, chooseagain2
	beq	$s3, 79, chooseagain2	
		
	sb	$t0, 2($s1)
	
	jal	checkresult
	j	nextstep2
		slotO2.3:
	lb	$s3, 4($s1)
	beq	$s3, 88, chooseagain2
	beq	$s3, 79, chooseagain2	
				
	sb	$t0, 4($s1)
	
	jal	checkresult
	j	nextstep2
	lineO3:
	beq	$t1, 55, slotO3.1
	beq	$t1, 56, slotO3.2
	beq	$t1, 57, slotO3.3	
		slotO3.1:
	lb	$s3, 0($s2)
	beq	$s3, 88, chooseagain2
	beq	$s3, 79, chooseagain2	
				
	sb	$t0, 0($s2)
	
	jal	checkresult
	j	nextstep2
		slotO3.2:
	lb	$s3, 2($s2)
	beq	$s3, 88, chooseagain2
	beq	$s3, 79, chooseagain2	

	sb	$t0, 2($s2)
	
	jal	checkresult
	j	nextstep2
		slotO3.3:	
	lb	$s3, 4($s2)
	beq	$s3, 88, chooseagain2
	beq	$s3, 79, chooseagain2	
		
	sb	$t0, 4($s2)
	
	jal	checkresult
	j	nextstep2
	nextstep2:
	addi	$s7, $0, 1
	j	whosnext
	
printboard:
	li	$v0, 4
	la	$a0, curr
	syscall
	
	li	$v0, 4
	addi	$a0, $s0, 0
	syscall
	
	li	$v0, 4
	addi	$a0, $s1, 0
	syscall
	
	li	$v0, 4
	addi	$a0, $s2, 0
	syscall
	
endprboard:	jr	$ra

checkresult:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	addi	$t6, $0, 0
	addi	$t7, $0,0
	stage1:
	beq	$t7, 6, endstage1
	
	add	$t5, $s0, $t7
	lb	$t4, 0($t5)
	add	$t6, $t6, $t4
	
	beq	$t6, 264, end1
	beq	$t6, 237, end2
	
	addi	$t7, $t7, 2
	j	stage1
	endstage1: 	
	
	addi	$t6, $0, 0
	addi	$t7, $0,0
	stage2:
	beq	$t7, 6, endstage2
	
	add	$t5, $s1, $t7
	lb	$t4, 0($t5)
	add	$t6, $t6, $t4
	
	beq	$t6, 264, end1
	beq	$t6, 237, end2
	
	addi	$t7, $t7, 2
	j	stage2
	endstage2:	
	
	addi	$t6, $0, 0
	addi	$t7, $0,0
	stage3:
	beq	$t7, 6, endstage3
	
	add	$t5, $s2, $t7
	lb	$t4, 0($t5)
	add	$t6, $t6, $t4
	
	beq	$t6, 264, end1
	beq	$t6, 237, end2
	
	addi	$t7, $t7, 2
	j	stage3
	endstage3:
	
	addi	$t7, $0, 0
	stage456:
	addi	$t6, $0, 0
	beq	$t7, 6, endstage456
	
	add	$t5, $s0, $t7
	lb	$t4, 0($t5)
	add	$t6, $t6, $t4
	
	add	$t5, $s1, $t7
	lb	$t4, 0($t5)
	add	$t6, $t6, $t4
	
	add	$t5, $s2, $t7
	lb	$t4, 0($t5)
	add	$t6, $t6, $t4
	
	beq	$t6, 264, end1
	beq	$t6, 237, end2
	
	addi	$t7, $t7, 2
	j	stage456
	endstage456:

	
	addi	$t6, $0, 0
	stage7:
	addi	$t5, $s0, 0
	lb	$t4, 0($t5)
	add	$t6, $t6, $t4
	
	addi	$t5, $s1, 2
	lb	$t4, 0($t5)
	add	$t6, $t6, $t4
	
	addi	$t5, $s2, 4
	lb	$t4, 0($t5)
	add	$t6, $t6, $t4
	
	beq	$t6, 264, end1
	beq	$t6, 237, end2
	endstage7:
	
	addi	$t6, $0, 0
	stage8:
	addi	$t5, $s0, 4
	lb	$t4, 0($t5)
	add	$t6, $t6, $t4
	
	addi	$t5, $s1, 2
	lb	$t4, 0($t5)
	add	$t6, $t6, $t4
	
	addi	$t5, $s2, 0
	lb	$t4, 0($t5)
	add	$t6, $t6, $t4
	
	beq	$t6, 264, end1
	beq	$t6, 237, end2
	endstage8:
	addi	$t6, $0, 0
	
	stage9:
	endstage9:
	addi	$t6, $0, 0
	
endcheck:	jal	printboard
		addi	$s6, $s6, 1
		beq	$s6, 9, end3
		
		lw	$ra, 0($sp)
		addi	$sp, $sp, 4
		jr	$ra
end1:	
	jal	printboard

	li	$v0, 4
	la	$a0, player1win
	syscall
	
	li	$v0, 10
	syscall
	
end2:
	jal	printboard

	li	$v0, 4
	la	$a0, player2win
	syscall
	
	li	$v0, 10
	syscall

end3:
	li	$v0, 4
	la	$a0, draw
	syscall
	
	li	$v0, 10
	syscall
