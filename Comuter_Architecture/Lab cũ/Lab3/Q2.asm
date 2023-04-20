	.data
str:	.asciiz "Type the number: \t"
endl:	.asciiz "\n"	
rst:	.asciiz "Sum of all positive numbers is:\t"

	.text
add 	$s0, $0, $0
add	$v0, $0, $0
GetInput:
add 	$s0, $s0, $v0
li	$v0, 4
la	$a0, str
syscall

li	$v0, 5
syscall

bgtz 	$v0, GetInput

li	$v0, 4
la	$a0, rst
syscall

add	$a0, $s0, $0
li	$v0, 1
syscall
