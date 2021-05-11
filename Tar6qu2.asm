.data
.asciiz 
prtreq1: "please inter the size of the matrix 1 (the num of rows and colums):"
prtreq2: "please inter the size of the matrix 2 (the num of rows and colums):"
printIncorrect: "ERROR! PLEASE INTER NEW CORRECT SIZES"
interm1: "please inter values for metrix 1:"
interm2:  "please inter values for metrix 2:"
space: " " 
downline: "\n"
.word
.data 0x10010100
matrix1: 10 10 
.data 0x10010160
matrix2: 10 10
.data 0x100101c0
sizematrix3:
matrix3:

.text
#=============================
#======MULTING METRIXES=======
#=============================
input:
la $t0 matrix1
la $a0 prtreq1 #   input of the metrix1 size
li $v0 4
syscall
li $v0 5
syscall
sw $v0 0($t0)
li $v0 5
syscall
sw $v0 4($t0)

la $t1 matrix2
la $a0 prtreq2 #   input of the metrix2 size
li $v0 4
syscall
li $v0 5
syscall
sw $v0 0($t1)
li $v0 5
syscall
sw $v0 4($t1)

#checking if the sizes are correct
lw $t4 0($t0)
lw $t2 4($t0)
lw $t3 0($t1)
lw $t5 4($t1)
beq $t2 $zero zeroinput
beq $t3 $zero zeroinput
beq $t4 $zero zeroinput
beq $t4 $zero zeroinput

beq $t2 $t3 continue
zeroinput:
la $a0 printIncorrect
li $v0 4
syscall
j input


continue:
#input value for metrix1
# $t2=  $t4=
mult $t2 $t4
mflo $t9
la $a0 interm1
li $v0 4
syscall
addi $t0 $t0 8
loop1:
li $v0 5
syscall
sw $v0 0($t0)
addi $t0 $t0 4
addi $t9 $t9 -1
bne $t9 $zero loop1


#input value for metrix2
# $t3=  $t5=
mult $t3 $t5
mflo $t9
la $a0 interm2
li $v0 4
syscall
addi $t1 $t1 8
loop2:
li $v0 5
syscall
sw $v0 0($t1)
addi $t1 $t1 4
addi $t9 $t9 -1
bne $t9 $zero loop2

# BEGINIG OF THE REAL THING: CREATING NEW MULTED MATRIX3

la $t0 sizematrix3
la $s1 matrix1
la $s2 matrix2
lw $t3 0($s1)
lw $t4 4($s2)
sw $t3 0($t0)
sw $t4 4($t0)
# $t3=rows
# $t4=colums

addi $s1 $s1 8
addi $s2 $s2 8
#addi $t3 $t3 -1
#addi $t4 $t4 -1

la $t0 matrix3
addi $t0 $t0 8
li $t1 0  
loop:#row
li $t2 0          
innerloop:#colums
#li $t9 0 #sum

la $s1 matrix1
la $s2 matrix2
addi $s1 $s1 8
addi $s2 $s2 8

addi $a0 $t1 0
addi $a1 $t2 0
jal innerinnerloop 

# mikom
sw $v0 0($t0)
addi $t0 $t0 4

addi $t2 $t2 1
bne $t2 $t4 innerloop

addi $t1 $t1 1
bne $t1 $t3 loop

print: 

#=========================
#======print MATRIX 1=====
#=========================
la $t0 matrix1
lw $t1 0($t0) #rows
lw $t2 4($t0)  #colums
addi $t0 $t0 8

looprowsM1:
addi $t1 $t1 -1
add $t3 $t2 $zero #colums in loop
loopcolumsM1:
addi $t3 $t3 -1
lw $a0 0($t0)
addi $t0 $t0 4
li $v0 1
syscall
la $t5 space
lb $a0 0($t5)
li $v0 11
syscall
bne $t3 $zero loopcolumsM1
beq $t3 $zero printmovelineM1
printmovelineM1:
la $t5 downline
lb $a0 0($t5)
li $v0 11
syscall
bne $t1 $zero looprowsM1



#=========================
#======print MATRIX 2=====
#=========================
la $t0 matrix2
lw $t1 0($t0) #rows
lw $t2 4($t0)  #colums
addi $t0 $t0 8

looprowsM2:
addi $t1 $t1 -1
add $t3 $t2 $zero #colums in loop
loopcolumsM2:
addi $t3 $t3 -1
lw $a0 0($t0)
addi $t0 $t0 4
li $v0 1
syscall
la $t5 space
lb $a0 0($t5)
li $v0 11
syscall
bne $t3 $zero loopcolumsM2
beq $t3 $zero printmovelineM2
printmovelineM2:
la $t5 downline
lb $a0 0($t5)
li $v0 11
syscall
bne $t1 $zero looprowsM2




#=========================
#======print MATRIX 3=====
#=========================
la $t0 sizematrix3
lw $t1 0($t0) #rows

la $t3 matrix3
addi $t3 $t3 8
looprows:
addi $t1 $t1 -1
lw $t2 4($t0)  #colums
loopcolums:
addi $t2 $t2 -1
lw $a0 0($t3)
addi $t3 $t3 4
li $v0 1
syscall
la $t5 space
lb $a0 0($t5)
li $v0 11
syscall
bne $t2 $zero loopcolums
beq $t2 $zero printmoveline
printmoveline:
la $t5 downline
lb $a0 0($t5)
li $v0 11
syscall
bne $t1 $zero looprows

li $v0 10
syscall



innerinnerloop:
la $t6 matrix1
lw $t7 4($t6) 
li $t6 0
li $v0 0

mult $a0 $t7
mflo $t8
#add $t8 $t8 $a1
li $s7 4
mult $t8 $s7
mflo $s6
add $s1 $s1 $s6

mult $a1 $s7
mflo $t8
#li $t8 0
#add $t8 $t8 $a1
#li $s7 4
#mult $t8 $s7
#mflo $s6
add $s2 $s2 $t8
loopi:

lw $t9 0($s1)
addi $s1 $s1 4

lw $t5 0($s2)
mult $s7 $t7
mflo $s7
add $s2 $s2 $s7

addi $t6 $t6 1

mult $t9 $t5
mflo $s0

add $v0 $v0 $s0
bne $t6 $t7 loopi
jr $ra

