	.data
TypeInteger1: .asciiz "Type the 1st number: \t"
TypeInteger2: .asciiz "Type the 2nd number: \t"
Result: .asciiz "Your result is: \t"

	.text
main:

li $v0, 4 # system call code for printing string = 4
la $a0, TypeInteger1
syscall

li $v0, 5
syscall
add $t0, $v0, $zero

li $v0, 4 # system call code for printing string = 4
la $a0, TypeInteger2
syscall

li $v0, 5
syscall
add $t1, $v0, $zero

li $v0, 4 # system call code for printing string = 4
la $a0, Result
syscall

add $a0, $t0, $t1
li $v0, 1 # Print integer a0
syscall

