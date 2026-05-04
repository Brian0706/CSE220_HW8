.data
typeprompt: .asciiz "Triangle(0) or Square(1) or Pyramid (2)? "
sizeprompt: .asciiz "Required size? "
invalid_shape: .asciiz "Must give a 0,1,2 for the shape"
invalid_size: .asciiz "The size must be a positive number\n"

.text 
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
	la $a0, '\n'      #printf("\n");
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
	la $a0, '\n'      #printf("\n");
	syscall
	
	#Check if user gave a valid size
	bgt $t1, $zero, valid_size   #if(size > 0) goto valid_size
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
	li $v0, 4           #printf("Must give a 0,1,2 for the shape")
	la $a0, invalid_shape
	syscall

done:
	li $v0, 10
	syscall


#square(int width, int curHeight)
square: 
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	#Check for base case
	beq $a0, $a1, s_reset     #if(width == curHeight) goto s_end
	
	#Prepare loop variables
	li $t1, 0                #counter = 0
	move $t2, $a0            #t2 = width

s_loop: 
	#Print a line of the square
	li $v0, 11
	la $a0, '*'             #a0 = '*'
	syscall                 #printf("%c",a0);
	addi $t1, $t1, 1        #counter = counter + 1
	blt $t1, $t2, s_loop    #if(counter < width) goto s_loop

s_end:
	#Print a newline and recursively call to print next line
	li $v0, 11
	la $a0, '\n'           #a0 = '\n'
	syscall                #printf("%c",a0);
	move $a0, $t2          #a0 = width
	addi $a1, $a1, 1       #curHeight = curHeight + 1
	jal square             #square(width, curHeight + 1)

s_reset:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra


#triangle(int width, int curHeight)
triangle: 
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	#Check for base case
	beq $a0, $a1, t_reset       #if(width == curHeight) goto t_end
	
	#Prepare loop variables
	li $t1, 0                 #counter = 0
	move $t2, $a0             #t2 = width

t_loop: 
	#Print a line of the triangle
	li $v0, 11
	la $a0, '*'               #a0 = '*'
	syscall                   #printf("%c",a0);
	addi $t1, $t1, 1          #counter = counter + 1
	ble $t1, $a1, t_loop      #if(counter <= curHeight) goto t_loop

t_end:
	#Print a newline and recursively call to print next line
	li $v0, 11
	la $a0, '\n'             #a0 = '\n'
	syscall                 #printf("%c",a0);
	move $a0, $t2           #a0 = width
	addi $a1, $a1, 1        #curHeight = curHeight + 1
	jal triangle            #triangle(width, curHeight + 1)

t_reset:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

#pyramid(int width, int curHeight)
pyramid:      
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	#Check for base case
	beq $a0, $a1, p_end       #if(width == curHeight) goto t_end

	#Prepare loop variables
	li $t1, 0                #counter = 0
	move $t2, $a0            #t2 = width

	#Determine how many spaces before and after stars
	sub $t3, $a0, $a1        #bounds = width - curHeight
	addi $t3, $t3, -1        #bounds = bounds - 1
	move $a0, $t3

l_bound:
	#Print left boundary
	li $v0, 11
	bge $t1, $t3, l_end      #if(counter < bounds) goto l_end
	la $a0, ' '              #a0 = ' ';
	syscall                  #printf("%c", a0);
	addi $t1, $t1, 1         #counter = counter + 1
	j l_bound                #goto l_bound
l_end:
	#Reset counter
	li $t1, 0                #counter = 0
	
middle:
	#Print out the middle section of stars and spaces alternating
	li $v0, 11
	la $a0, '*'              #a0 = "*"
	syscall                  #printf("%c",a0)
	la $a0, ' '              #a0 = " "
	syscall                  #printf("%c",a0)
	addi $t1, $t1, 1         #counter = counter + 1
	ble $t1, $a1, middle     #if(counter <= curHeight) goto middle
	
middle_end:
	li $t1, 0                #counter = 0

r_bound:
	#Print right boundary
	li $v0, 11
	bge $t1, $t3, r_end     #if(counter < bounds) goto r_end
	la $a0, ' '             #a0 = " "
	syscall                 #printf('%c', a0)
	addi $t1, $t1, 1        #counter = counter + 1
	j r_bound               #goto r_bound
	
r_end:
	#Print a newline and recursively call to print next line
	li $v0, 11
	la $a0, '\n'            #a0 = '\n'
	syscall                 #printf('%c', a0)
	move $a0, $t2           #a0 = width
	addi $a1, $a1, 1        #curHeight = curHeight + 1
	jal pyramid             #pyramid(width, curHeight + 1)

p_end:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
