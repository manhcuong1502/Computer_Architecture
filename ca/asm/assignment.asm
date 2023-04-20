.data 
	prompt: .asciiz "Nhap: " 
     	space:    .asciiz " "
	out1: .asciiz "\nDecimal: " 
	out2: .asciiz "\nHexadecimal: " 
	result: .space 16  # noi luu tru ket qua chuen doi 
.text 
	# nhap gia tri
	la $a0, prompt 
 	li $v0, 4 
 	syscall 	
	li $v0, 5
	syscall
	add $t0, $0, $v0	
	li $v0, 4
	syscall 	
	li $v0, 5
	syscall
	add $t1, $0, $v0
	jal xet
	# tinh ket qua phep nhan	
	mult $t1,$t0
	mfhi $t2
	jal xet3
	
	mfhi $s0
	mflo $s1
	
	li $t0, 17 # bien dem
 	la $t3, result # load dia chi ket qua sau chuyen doi
 	bnez $t7, Loop
 	beq $t2,0,Loop
 	addi $t2, $t2, -1
 	b Loop
second:
	mflo $t2
	jal xet3
	addi $t0,$t0,-1
# ham chuyen doi gia tri thanh ghi $t2 sang thap luc phan va ghi vao result
Loop: 
	beq $t0,9, second
	beqz $t0, Exit 
	rol $t2, $t2, 4 # dich trai thanh ghi $t2 4bit
	and $t4, $t2, 0xf # lay gia tri 4bit cuoi cua $t2 vao $t4
	beq $t0,17,bit1 # xet bit dau
now:
# neu la so <=9 thi cong voi 48 nguoc lai cong voi 55
	ble $t4, 9, Sum # if less than or equal to nine, branch to sum 
	addi $t4, $t4, 55 # if greater than nine, add 55 
	b End 
Sum: 
	addi $t4, $t4, 48 # add 48 to result 
# luu gia tri vo result
End: 
	sb $t4, 0($t3) # store hex digit into result 
	addi $t3, $t3, 1 # increment address counter 
	addi $t0, $t0, -1 # decrement loop counter 
	j Loop 
# xuat ket qua va ket thuc chuong trinh
Exit: 
	
	la $a0, out1
	li $v0, 4
	syscall
	
	jal outdex
		
	la $a0, out2
	li $v0, 4
	syscall
	
	la $a0, result 
	syscall 
	
	la $v0, 10 
	syscall
	
bit1: #xet bit dau 
	bnez $t7, now
	addi $t4,$t4,8
	
	b now
	
xet:
	bltz $t1, tru
	addi $t7,$t7,1
	b xet2
tru:
	addi $t7,$t7,-1
xet2:
	bltz $t0, tru2
	addi $t7,$t7,1
	b jra
tru2:
	addi $t7,$t7,-1
	b jra
jra:
	jr $ra


xet3:
	bnez $t7, jra
	sub $t2, $0, $t2
	b jra
# suat so dang thap phan
outdex:
	beq $s0, -1, outhi
	li $v0, 1
	move $a0, $s0
	syscall
	
	li  $v0,4          
    	la  $a0,space       
    	syscall  
outhi:	
	li $v0,1
	move $a0, $s1
	syscall
	
	jr $ra
	
	