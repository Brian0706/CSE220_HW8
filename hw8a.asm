# Brian Chau
# SBU ID: 116125954

.data
typeprompt: .asciiz "Triangle(0) or Square(1) or Pyramid (2)? "
sizeprompt: .asciiz "Required size? "
invalid_shape: .asciiz "Must give a 0,1,2 for the shape\n"
invalid_size: .asciiz "The size must be a positive number\n"
star: .asciiz "*"            #This is for square and triangle
star_and_space: .asciiz "* "  #This is for pyramid

.text
.globl main 
main:
	li $t2, 0            #Used to check if shape argument given is 0 for a triangle
	li $t3, 1            #Used to check if shape argument given is 1 for a square
	li $t4, 2            #Used to check if shape argument given is 2 for a pyramid
	
	#Prints out prompt to type in shape type
	li $v0, 4
	la $a0, typeprompt   #printf("Triangle(0) or Square(1) or Pyramid (2)? ");
	syscall

	#Read shape selection from user
	li $v0, 5            
	syscall
	move $t0, $v0        #scanf("%d",&type);
	
	li $v0, 11
	li $a0, '\n'         #printf("\n");
	syscall
	
	#Print out prompt to type in size
	li $v0, 4
	la $a0, sizeprompt   #printf("Required size? ");
	syscall

	#Read size from user 
	li $v0, 5            
	syscall
	move $t1, $v0        #scanf("%d",&size);

	li $v0, 11
	li $a0, '\n'         #printf("\n");
	syscall
	
	#Check if user gave a valid size
	bgt $t1, $zero, valid_size   #if(size > 0) goto valid_size
	li $v0, 4
	la $a0, invalid_size         #printf("The size must be a positive number\n")
	syscall
	j done  

valid_size:
	#Check if user asked for a triangle and print one if so
	bne $t0, $t2, not_triangle   #if(type != 0) goto not_triangle
	move $a0, $t1                #a0 = size;
	move $a1, $zero              #a1 = 0;
	jal triangle                 #triangle(size, 0);               
	j done

not_triangle:
	#Check if user asked for a square and print one if so
	bne $t0, $t3, not_square    #if(type != 1) goto not_square
	move $a0, $t1               #a0 = size
	move $a1, $zero             #a1 = 0 
	jal square                  #square(size, 0)  
	j done

not_square:
	#Check if user asked for a pyramid and print one if so
	bne $t0, $t4, not_shape     #if(type != 2) goto not_shape
	move $a0, $t1               #a0 = size
	move $a1, $zero             #a1 = 0 
	jal pyramid                 #pyramid(size, 0)
	j done

not_shape:
	#Tell user they did not give a valid shape type
	li $v0, 4           
	la $a0, invalid_shape
	syscall                     #printf("Must give a 0,1,2 for the shape\n")

done:
	li $v0, 10
	syscall


#square(int width, int curHeight)
square: 
	# Set aside space in stack and store callee-saved registers
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	#Check for base case
	beq $a0, $a1, s_reset     #if(width == curHeight) goto s_reset
	
	#Save the arguments before using argument registers
	move $s0, $a0               
	move $s1, $a1
	#Load values into argument registers and call print_star_line
	move $a0, $s0
	la $a1, star
	jal print_star_line        #print_star_line(width, "*");

	#Print a newline and recursively call to print next line
	li $v0, 11
	li $a0, '\n'           #a0 = '\n'
	syscall                #printf("%c",a0);
	move $a0, $s0          #a0 = width
	addi $a1, $s1, 1       #a1 = curHeight + 1
	jal square             #square(width, curHeight + 1)

s_reset:
	#Clear stack frame and retrieve stored values
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
	jr $ra


#triangle(int width, int curHeight)
triangle: 
	# Set aside space in stack and store callee-saved registers
	addi $sp, $sp, -12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	
	#Check for base case
	beq $a0, $a1, t_reset       #if(width == curHeight) goto t_reset
	#Save the arguments before using argument registers
	move $s0, $a0               
	move $s1, $a1
	#Load values into argument registers and call print_star_line
	addi $a0, $s1, 1            #times = curHeight + 1
	la $a1, star
	jal print_star_line         #print_star_line(curHeight+1, "*");
	
	#Print a newline and recursively call to print next line
	li $v0, 11
	li $a0, '\n'             #a0 = '\n'
	syscall                  #printf("%c",a0);
	move $a0, $s0            #a0 = width
	addi $a1, $s1, 1         #a1 = curHeight + 1
	jal triangle             #triangle(width, curHeight + 1)

t_reset:
	#Clear stack frame and retrieve stored values
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	addi $sp, $sp, 12
	jr $ra

#pyramid(int width, int curHeight)
pyramid:  
	# Set aside space in stack and store callee-saved registers    
	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	#Check for base case
	beq $a0, $a1, p_end       #if(width == curHeight) goto p_end
	#Save the arguments before using argument registers
	move $s0, $a0               
	move $s1, $a1
	
	
	#Determine how many spaces before stars
	sub $s2, $a0, $a1        #bounds = width - curHeight
	addi $s2, $s2, -1        #bounds = bounds - 1
	
	#Prepare loop variables
	li $t1, 0                #counter = 0
l_bound:
	#Print left boundary
	li $v0, 11
	bge $t1, $s2, l_end      #if(counter >= bounds) goto l_end
	li $a0, ' '              #a0 = ' ';
	syscall                  #printf("%c", a0);
	addi $t1, $t1, 1         #counter = counter + 1
	j l_bound                #goto l_bound
l_end:
	#Load values into argument registers and call print_star_line
	addi $a0, $s1, 1          #times = curHeight + 1            
	la $a1, star_and_space
	jal print_star_line       #print_star_line(curHeight+1, "* ");

	#Print a newline and recursively call to print next line
	li $v0, 11
	li $a0, '\n'            #a0 = '\n'
	syscall                 #printf('%c', a0)
	move $a0, $s0           #a0 = width
	addi $a1, $s1, 1        #a1 = curHeight + 1
	jal pyramid             #pyramid(width, curHeight + 1)

p_end:
        #Clear stack frame and retrieve values from it
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addi $sp, $sp, 16
	jr $ra

#Prints a string x number of times in a row
#print_star_line(int times, char* string)
print_star_line:
	li $t0, 0                      #counter = 0
	move $t1, $a0                  #t1 = times
	beqz $a0, print_end            #if(times == 0) goto print_end
print_loop:
	#Print a line of string
	li $v0, 4
	move $a0, $a1                    #a0 = string
	syscall                        #printf(string);
	addi $t0, $t0, 1               #counter = counter + 1
	blt $t0, $t1, print_loop       #if(counter < times) goto print_loop
print_end:
	jr $ra
