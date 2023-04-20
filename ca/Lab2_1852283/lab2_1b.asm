.data
Xuatchuoi: .asciiz "Kien Truc May Tinh 2022""

.text
main:
li $v0, 4 # system call code for printing string = 4
la $a0, Xuatchuoi
syscall