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
	#Load in variables
	la $t0, A        #Create a pointer to A
	la $t1, B        #Create a pointer to B
	lw $t2, num      #size = num
	#Because matrix is zero-indexed but count starts at 1
	#counter is initalized to 1
	li $t3, 1        #counter = 1

#Gets intial value from users
init_loop:
	bgt $t3, $t2, init_end  #if(counter > num) goto init_end
	
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
	
	#This section prints out A[counter]=
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

jal swap

jal print_loop

li $v0, 10
syscall

#Swaps the values of matrix A and matrix B
swap:
	la $t0, A               #pointer to matrix A
	la $t1, B               #pointer to matrix B
	li $t3, 1               #counter = 1

swap_loop:
	bgt $t3, $t2, swap_end  #if(counter > num) goto swap_end
	#Store A[counter-1] and B[counter-1] in registers
	lw $t4, 0($t0)          #temp = *pointerA
	lw $t5, 0($t1)          #temp2 = *pointerB
	#Swap the values of the arrays
	sw $t4, 0($t1)          #*pointerA = temp2
	sw $t5, 0($t0)          #*pointerB = temp
	
	addi $t3, $t3, 1        #Increment counter
	addi $t0, $t0, 4        #Move pointer to next element in A
	addi $t1, $t1, 4        #Move pointer to next element in B
	j swap_loop             #goto swap_loop
swap_end:
	jr $ra

#Prints out loops A and B as specified in the assignment
print_loop:
	la $t0, A               #Create a pointer to A
	la $t1, B               #Create a pointer to B
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
	addi $t3, $t3, 1        #counter = counter + 1
	addi $t0, $t0, 4        #pointerA = pointerA + 1
	addi $t1, $t1, 4        #pointerB = pointerB + 1
	j out_loop             #goto out_loop
out_end:
	jr $ra
