#====================================================
# Program: 4x4 Matrix Multiplication
#====================================================
.data
#-----------------------------------------------
# Matrices
#-----------------------------------------------
A: .word 1, 2, 3, 4
.word 5, 6, 7, 8
.word 9, 10, 11, 12
.word 13, 14, 15, 16
B: .word 1, 0, 0, 0 # This is a unit matrix
.word 0, 1, 0, 0
.word 0, 0, 1, 0
.word 0, 0, 0, 1
.align 2
C: .space 64 # 16 integers * 4 bytes each = 64 bytes
n: .word 4 # matrix dimension (4x4)
newline: .asciiz "\n"
space: .asciiz " "

.text
main: 
lw $a0, n            #n = n
lw $a1, n            #m = n
lw $a2, n            #p = n
la $a3, A            #A = A
addi $sp, $sp, -8    #Stack frame holds 2 additional arguments
la $t0, B            #B = B
la $t1, C            #C = C
sw $t0, 0($sp)       #Store B on the stack
sw $t1, 4($sp)       #Store C on the stack
move $fp, $sp        #Move frame pointer to end of stack frame

jal multiply

lw $t0, n            #numOfRows = n
lw $t1, n            #numOfCols = n
li $t2, 0            #i = 0\
la $t4, C            #pointer = C
p_loop:
bge $t2, $t0, p_end  #if(i >= numOfRows) goto p_end
li $t3, 0            #j = 0

in_loop:
bge $t3, $t1, in_end  #if(j >= numOfCols) goto p_end 
li $v0, 1
lw $a0, 0($t4)
syscall              #printf("%d", pointer)
li $v0, 4
la $a0, space 
syscall              #printf(" ")
addi $t3, $t3, 1     #j = j + 1
addi $t4, $t4, 4     #pointer = pointer + 1
j in_loop
in_end:

la $a0, newline
syscall              #printf("\n") 
addi $t2, $t2, 1     #i = i+1
j p_loop
p_end:
addi $sp, $sp, 8
li $v0, 10
syscall

multiply:
addi $sp, $sp, -12  #Allocate space for 3 local variables
sw $s0, 0($sp)      #Store s0 in stack
sw $s1, 4($sp)      #Store s1 in stack
sw $s2, 8($sp)      #Store s2 in stack

move $s0, $a3         #s0 = A
lw $s1, 0($fp)      #s1 = B
lw $s2, 4($fp)      #s2 = C
li $t0, 0           #r = 0

r_loop:
bge $t0, $a0, r_end #if(r >= n) goto r_end
li $t1, 0           #c = 0

c_loop:
bge $t1, $a1, c_end #if(c >= p) goto r_end
li $t5, 0           #sum = 0
li $t2, 0           #i = 0

#Getting the pointer to row r of A matrix
mul $t3, $t0, $a1   #pointerA = r * m
sll $t3, $t3, 2     #pointerA = r * m * 4
add $t3, $t3, $s0   #pointerA = A[r]

#Getting the pointer to col c of B matrix
sll $t4, $t1, 2     #pointerB = c * 4
add $t4, $t4, $s1   #pointerB = &B[0][c]

i_loop:
bge $t2, $a2, i_end #if(i >= m) goto i_end
lw $t6, 0($t3)      #operand1 = A[r][i]
lw $t7, 0($t4)      #operand2 = B[i][c]
mul $t6, $t6, $t7   #result = A[r][i] * B[i][c]
add $t5, $t5, $t6   #sum += A[r][i] * B[i][c]

sll $t7, $a2, 2     #shiftamt = p * 4
add  $t4, $t4, $t7  #pointerB = pointerB + p
addi $t3, $t3, 4    #pointerA = pointerA + 1
addi $t2, $t2, 1    #i = i + 1
j i_loop
i_end:

sw $t5, 0($s2)      #pointerC = sum
addi $s2, $s2, 4    #pointerC = pointerC + 1
addi $t1, $t1, 1    #c = c + 1 
j c_loop
c_end:

addi $t0, $t0, 1    #r = r + 1
j r_loop
r_end:

lw $s0, 0($sp)      #Retrieve s0 from stack
lw $s1, 4($sp)      #Retrieve s1 from stack
lw $s2, 8($sp)      #Retrieve s2 from stack
addi $sp, $sp, 12  #Clear stack frame
jr $ra
