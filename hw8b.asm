.data
.align 2
A: .space 40 #memory space for Array A
B: .space 40 #memory space for Array B
num: .word 10 #number of elements
startA: .asciiz "A["
startB: .asciiz "B["
ending: .asciiz "]="
newline: .asciiz "\n"
border: .asciiz "|"
space: .asciiz " "

.text
main:
la $t0, A        #pointerA = A
la $t1, B        #pointerB = B
lw $t2, num      #size = num
li $t3, 1        #counter = 1

init_loop:
bgt $t3, $t2, init_end  #if(counter > num) goto init_end

li $v0, 4
la $a0, startA          #printf("A[")
syscall
li $v0, 1
move $a0, $t3
syscall                 #printf("%d", counter)
li $v0, 4
la $a0, ending
syscall                 #printf("]=")
li $v0, 5              
syscall                 
sw $v0, 0($t0)          #scanf("%d", pointerA)
li $v0, 4
la $a0, newline
syscall                 #printf("\n")

li $v0, 4
la $a0, startB          #printf("B[")
syscall
li $v0, 1
move $a0, $t3
syscall                 #printf("%d", counter)
li $v0, 4
la $a0, ending
syscall                 #printf("]=")
li $v0, 5              
syscall                 
sw $v0, 0($t1)          #scanf("%d", pointerB)
li $v0, 4
la $a0, newline
syscall                 #printf("\n")

addi $t3, $t3, 1        #counter = counter + 1
addi $t0, $t0, 4        #pointerA = pointerA + 1
addi $t1, $t1, 4        #pointerB = pointerB + 1
j init_loop             #goto init_loop
init_end: 

jal swap

jal print_loop

li $v0, 10
syscall

swap:
la $t0, A               #pointerA = A
la $t1, B               #pointerB = B
li $t3, 1               #counter = 1
swap_loop:
bgt $t3, $t2, swap_end  #if(counter > num) goto swap_end
lw $t4, 0($t0)          #temp = *pointerA
lw $t5, 0($t1)          #temp2 = *pointerB
sw $t4, 0($t1)          #*pointerA = temp2
sw $t5, 0($t0)          #*pointerB = temp
addi $t3, $t3, 1        #counter = counter + 1
addi $t0, $t0, 4        #pointerA = pointerA + 1
addi $t1, $t1, 4        #pointerB = pointerB + 1
j swap_loop
swap_end:
jr $ra

print_loop:
la $t0, A               #pointerA = A
la $t1, B               #pointerB = B
li $t3, 1               #counter = 1
out_loop:
bgt $t3, $t2, out_end  #if(counter > num) goto out_end
li $v0, 1
lw $a0, 0($t0)
syscall                #printf("%d", *pointerA)
li $v0, 4
la $a0, space
syscall                #printf(" ")
li $v0, 1
lw $a0, 0($t1)
syscall                #printf("%d", *pointerB)
li $v0, 4
la $a0, border
syscall                #printf("|")
addi $t3, $t3, 1        #counter = counter + 1
addi $t0, $t0, 4        #pointerA = pointerA + 1
addi $t1, $t1, 4        #pointerB = pointerB + 1
j out_loop             #goto out_loop
out_end:
jr $ra