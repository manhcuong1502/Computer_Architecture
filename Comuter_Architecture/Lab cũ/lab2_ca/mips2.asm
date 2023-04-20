	.data
str: .asciiz "Type a positive integer number: "
error: .asciiz "Not a positive number."
space: .asciiz "\t"

	.text
li $v0, 4 #goi ham in chuoi
la $a0, str #dua chuoi can in vao $a0
syscall #in chuoi str

li $v0, 5 #goi ham doc so nguyen, kq luu vao $v0
syscall 
move $t1, $v0 #di chuyen du lieu $v0 vao $t1, $t1 = $v0 :))

bgt $t1, $0, Print #kt lon hon 0 thi nhay den nhan Print
li $v0, 4 #goi ham in chuoiiiiiii
la $a0, error #dua chuoi can in vao $a0
syscall

j End #nhay vo dieu kien den nhan Endddddd 

Print:
addi $a0, $0, 0 #gan so can in vao $a0
li $v0, 1 #goi ham in so nguyen
syscall 

subi $t1, $t1, 1 #tru N di 1 don vi
beqz $t1, End #kt N bang 0 thi nhay den nhan Enddd

li $v0, 4 #goi ham in chuoi
la $a0, space #dua chuoi can in vao $a0 
syscall 

addi $a0, $0, 1 #gan so can in la 1 vao $a0
li $v0, 1 #goi ham in so nguyen
syscall 

subi $t1, $t1, 1 #tru N di 1 don vi
beqz $t1, End #kt N bang 0 thi nhay den nhan End 

li $t0, 0 #t0 = 0
li $t2, 1 #t2 = 1

loop:
add $t3, $t0, $t2 #t3 = t0 + t2 

li $v0, 4 #goi ham in chuoi
la $a0, space #dua chuoi can in vao $a0
syscall

li $v0, 1 #goi ham in so nguyen
addi $a0, $t3, 0 #gan so can in vao $a0
syscall

add $t0, $t2, $0 #t0 = t2 + 0 :)
add $t2, $t3, $0 #t2 = t3 + 0 :))

subi $t1, $t1, 1 #tru N di 1 don vi, t1 = t1 - 1 =)))
beqz $t1, End #kt N bang 0 thi nhay den nhan End

j loop

End:
li $v0, 10
syscall 