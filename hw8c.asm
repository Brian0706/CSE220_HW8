.data
v: .word 1,4,6,-7,-3,4,8,11,-12,0
n: .word 10

message: .asciiz "Sorted Array: "
space: .asciiz " "
.text
main:
	#Store the array and its size in local variables
	la $s0, v         #pointer to array v
	lw $s1, n         #s1 = n

	#Call bubble_sort function
	move $a0, $s0
	move $a1, $s1
	jal bubble_sort       #bubble_sort(v, n)

	#Print out message
	li $v0, 4          
	la $a0, message
	syscall          #printf("Sorted Array: ")
	
	
	li $t0, 0             #counter = 0
#Loop through v and print out all its elements
p_loop:
	bge $t0, $s1, p_end   #if(counter >= n) goto p_end
	li $v0, 1             
	lw $a0, 0($s0)
	syscall              #printf("%d", s0)
	li $v0, 4
	la $a0, space
	syscall              #printf(" ")
	addi $t0, $t0, 1     #Increment counter
	addi $s0, $s0, 4     #Go to next element in v
	j p_loop             #goto p_loop
p_end:

li $v0, 10
syscall

bubble_sort:
	addi $sp, $sp, -8   # Set aside space in stack
	sw $s0, 0($sp)      # Store s0 in stack frame
	sw $s1, 4($sp)      # Store s1 in stack frame
	move $s0, $a0       # arr[] = a0
	move $s1, $a1       # num = a1

	#Set up bounds of outer loop
	move $t0, $s1       # t0 = n
	addi $t0, $t0, -1        # t0 = t0 - 1
	li $t1, 0           # i = 0
	li $t2, 0           # j = 0

#Loop through all indices from 0 to n-1
out_loop: 
	bge $t1, $t0, out_end     #if(i >= n-1) goto out_end
	li $t2, 0                 # j = 0
	move $t3, $t0             #t3 = n - 1
	sub $t3, $t3, $t1         #t3 = n - 1 - i
#Loop through all indices from 0 to n-1-i and perform one iteration of bubble sort
in_loop:
	bge $t2, $t3, in_end      #if(j >= n-1-i) goto in_end
	sll $t4, $t2, 2           #t4 = j * 4
	add $t4, $t4, $s0         #t4 = arr[j]
	move $t5, $t4             #t5 = arr[j]
	addi $t5, $t5, 4          #t5 = arr[j+1]
	#if(arr[j] >= arr[j+1]) swap them 
	lw $t6, 0($t4)          #temp = arr[j]
	lw $t7, 0($t5)          #temp2 = arr[j+1]
	bge $t6, $t7, if_end    #if(arr[j] >= arr[j+1]) goto if_end
	sw $t6, 0($t5)          #arr[j] = temp
	sw $t7, 0($t4)          #arr[j] = temp2
if_end:
	addi $t2, $t2, 1          #j = j + 1
	j in_loop
in_end:
	addi $t1, $t1, 1          #i = i + 1  
	j out_loop

out_end:
	lw $s0, 0($sp)      # Retrieve s0 in stack frame
	lw $s1, 4($sp)      # Retrieve s1 in stack frame
	addi $sp, $sp, 8    # Clear stack frame
	jr $ra              # return

