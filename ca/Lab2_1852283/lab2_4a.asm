.data
.word 18 30 13 5 2 6 9 1 4 54
.text

addi $t0, $t0, 2
subi $t0, $t0, 9

li $v0, 1
move $a0, $t0
syscall