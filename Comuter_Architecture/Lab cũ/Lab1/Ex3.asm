	.data
TypeInteger1: .asciiz "Type the value of a: \t"
TypeInteger2: .asciiz "Type the value of b: \t"
TypeInteger3: .asciiz "Type the value of c: \t"
TypeInteger4: .asciiz "Type the value of d: \t"
Resultf: .asciiz "\nResult of f = (a + b) - (c - d - 2) is: \t"
Resultg: .asciiz "\nResult of g = (a + b)*3 - (c + d)*2 is: \t"

	.text
main:

li $v0, 4 # system call code for printing string = 4
la $a0, TypeInteger1
syscall

li $v0, 5
syscall
add $t0, $v0, $zero # add a to $t0

li $v0, 4 # system call code for printing string = 4
la $a0, TypeInteger2
syscall

li $v0, 5
syscall
add $t0, $v0, $t0 #add a and b to t0

li $v0, 4 # system call code for printing string = 4
la $a0, TypeInteger3
syscall

li $v0, 5
syscall
add $t1, $v0, $zero #add c to t1

li $v0, 4 # system call code for printing string = 4
la $a0, TypeInteger4
syscall

li $v0, 5
syscall
add $t2, $v0, $t1 #c + d and assign to t2
sub $t1, $t1, $v0 #c - d and assign to t1 

subi $t1, $t1, 2 # $t1 - 2

li $v0, 4 # system call code for printing string = 4
la $a0, Resultf
syscall

sub $a0, $t0, $t1 
li $v0, 1 # Print integer a0
syscall

li $v0, 4 # system call code for printing string = 4
la $a0, Resultg
syscall
sll $t2, $t2, 1
add $t3, $t0, $t0
add $t3, $t3, $t0
sub $a0, $t3, $t2
li $v0, 1 # Print integer a0
syscall


