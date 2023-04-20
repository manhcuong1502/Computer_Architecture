.data
Xuatramanhinh: .asciiz" Nhap \t"

.text
main:
li $v0, 8 # system call code for printing string = 4
la $a0, Xuatramanhinh
li $a1, 10 # the limit of length 
syscall

li $v0, 4
syscall