.data
a : .asciiz "a: \t"
b : .asciiz "b: \t"
c : .asciiz "c: \t"
d : .asciiz "d: \t"
x : .asciiz "x: \t"
fx : .asciiz  "f(x): \t"

.text

li $v0, 4 # system call code for printing string = 4
la $a0, a
syscall

li $v0, 5
syscall
add $t0, $v0, $zero

li $v0, 4 # system call code for printing string = 4
la $a0, b
syscall

li $v0, 5
syscall
add $t1, $v0, $zero

li $v0, 4 # system call code for printing string = 4
la $a0, c
syscall

li $v0, 5
syscall
add $t2, $v0, $zero

li $v0, 4 # system call code for printing string = 4
la $a0, d
syscall

li $v0, 5
syscall
add $t3, $v0, $zero

li $v0, 4 # system call code for printing string = 4
la $a0, x
syscall

li $v0, 5
syscall
add $t4, $v0, $zero

li $v0, 4 # system call code for printing string = 4
la $a0, fx
syscall

mul $t6, $t0, $t4
add $t6, $t6, $t1
mul $t6, $t6, $t4
sub $t6, $t6, $t2
mul $t6, $t6, $t4
sub $t6, $t6, $t3

li $v0, 1
move $a0, $t6
syscall