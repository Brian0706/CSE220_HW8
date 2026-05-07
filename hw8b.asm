# Brian Chau
# SBU Id: 116125954

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
.globl main
main:
	#Load in variables
	la $s0, A        #Create a pointer to A
	la $s1, B        #Create a pointer to B
	lw $s2, num      #size = num
	move $t0, $s0    #Pointer to navigate through A
	move $t1, $s1    #Pointer to navigate through B
	
	#Because matrix is zero-indexed but count starts at 1
	#counter is initalized to 1
	li $t3, 1        #counter = 1

#Gets intial value from users
init_loop:
	bgt $t3, $s2, init_end  #if(counter > num) goto init_end
	
	#This section prints out A[counter]=
	li $v0, 4
	la $a0, startA          #printf("A[")
	syscall
	li $v0, 1
	move $a0, $t3
	syscall                 #printf("%d", counter)
	li $v0, 4
	la $a0, ending
	syscall                 #printf("]=")
	#Gets value for A[counter-1] from user
	li $v0, 5              
	syscall                 
	sw $v0, 0($t0)          #scanf("%d", pointerA)
	
	#This section prints out B[counter]=
	li $v0, 4
	la $a0, startB          #printf("B[")
	syscall
	li $v0, 1
	move $a0, $t3
	syscall                 #printf("%d", counter)
	li $v0, 4
	la $a0, ending
	syscall                 #printf("]=")
	#Gets value for B[counter-1] from user
	li $v0, 5              
	syscall                 
	sw $v0, 0($t1)          #scanf("%d", pointerB)
	
	
	addi $t3, $t3, 1        #Increment counter
	addi $t0, $t0, 4        #Move pointer to next element in A
	addi $t1, $t1, 4        #Move pointer to next element in B
	j init_loop             #goto init_loop
init_end: 
	
	#Move arguments to arg registers and call swap
	move $a0, $s0           #a0 = A
	move $a1, $s1           #a1 = B
	move $a2, $s2           #a2 = num
	jal swap                #swap(A,B,num)
	
	#Move arguments to arg registers and call print_loop
	move $a0, $s0           #a0 = pointer to A
	move $a1, $s1           #a1 = pointer to B
	move $a2, $s2           #a2 = num
	jal print_loop          #print_loop(A,B,num)

	li $v0, 10
	syscall               

#Swaps the values of matrix A and matrix B
#swap(int* A, int* B, int size)
swap:
	move $t0, $a0           #pointer to matrix A
	move $t1, $a1           #pointer to matrix B
	move $t2, $a2
	li $t3, 0               #counter = 0

swap_loop:
	bge $t3, $t2, swap_end  #if(counter >= num) goto swap_end
	#Store A[counter] and B[counter] in registers
	lw $t4, 0($t0)          #temp = A[counter]
	lw $t5, 0($t1)          #temp2 = B[counter]
	#Swap the values of the arrays
	sw $t4, 0($t1)          #B[counter] = temp
	sw $t5, 0($t0)          #A[counter] = temp2
	
	addi $t3, $t3, 1        #Increment counter
	addi $t0, $t0, 4        #Move pointer to next element in A
	addi $t1, $t1, 4        #Move pointer to next element in B
	j swap_loop             #goto swap_loop
swap_end:
	jr $ra

#Prints out arrays A and B as specified in the assignment
#print_loop(int* A, int* B, int size)
print_loop:
	move $t0, $a0           #pointer to matrix A
	move $t1, $a1           #pointer to matrix B
	move $t2, $a2           #t2 = num
	li $t3, 1               #counter = 1
	
#Loops through arrays and prints them out
out_loop:
	#Print out value of A[counter - 1] and B[counter-1], then |
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
	addi $t3, $t3, 1       #counter = counter + 1
	addi $t0, $t0, 4       #pointerA = pointerA + 1
	addi $t1, $t1, 4       #pointerB = pointerB + 1
	j out_loop             #goto out_loop
out_end:
	jr $ra
