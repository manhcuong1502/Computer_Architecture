.data

.text
main:

addi $t0, $t0, 200000
addi $t1, $t0, 4000
subi $t2, $t1, 700

li $v0, 1
move $a0, $t2
syscall