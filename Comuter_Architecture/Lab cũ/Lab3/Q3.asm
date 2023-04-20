	.data
str0: .asciiz "please input an another integer numbers \n"
str1: .asciiz "Selection: \t"
	.text
addi	$t0, $0, 0
addi	$t1, $0, 1
addi	$t2, $0, 2
addi	$s0, $0, 10
addi	$s1, $0, 5

li	$v0, 4
la	$a0, str1
syscall

li	$v0, 5
syscall
beq	$v0, $t0, Case0
beq	$v0, $t1, Case1
beq	$v0, $t2, Case2
j	Default

Case0:
add	$s2, $s1, $s0
j	EndSwitch
Case1:
sub	$s2, $s0, $s1
j	EndSwitch
Case2:
sub	$s2, $s1, $s0
j	EndSwitch
Default:
li	$v0, 4
la	$a0, str0
syscall
EndSwitch:
