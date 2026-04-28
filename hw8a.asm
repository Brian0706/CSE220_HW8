.data
typeprompt: .asciiz "Triangle(0) or Square(1) or Pyramid (2)? "
sizeprompt: .asciiz "Required size? "
newline: .asciiz "\n"
invalid_shape: .asciiz "Must give a 0,1,2 for the shape"
invalid_size: .asciiz "The size must be a positive number\n"
star: .asciiz "*"
space: .asciiz " "

.text 
main:
li $t2, 0            #Used to check if $t0 == 0
li $t3, 1            #Used to check if $t0 == 1
li $t4, 2            #Used to check if $t0 == 1

li $v0, 4
la $a0, typeprompt   #printf("Triangle(0) or Square(1) or Pyramid (2)? ")
syscall

li $v0, 5            
syscall
move $t0, $v0        #scanf("%d",&type)

li $v0, 4
la $a0, newline      #printf("\n")
syscall
la $a0, sizeprompt   #printf("Required size? ")
syscall

li $v0, 5            
syscall
move $t1, $v0        #scanf("%d",&size)

li $v0, 4
la $a0, newline      #printf("\n")
syscall

bgt $t1, $zero, valid_size   #if(size > 0) goto valid_size
la $a0, invalid_size         #printf("The size must be a positive number\n")
syscall
j done  

valid_size:
bne $t0, $t2, not_triangle   #if(type != 0) goto not_triangle
move $a0, $t1                #a0 = size
move $a1, $zero              #a1 = 0 
jal triangle                 #triangle(size, 0)                
j done

not_triangle:
bne $t0, $t3, not_square    #if(type != 1) goto not_square
move $a0, $t1               #a0 = size
move $a1, $zero             #a1 = 0 
jal square                  #square(size, 0)  
j done

not_square:
bne $t0, $t4, not_shape     #if(type != 2) goto not_shape
move $a0, $t1               #a0 = size
move $a1, $zero             #a1 = 0 
jal pyramid                 #pyramid(size, 0)
j done

not_shape:
la $a0, invalid_shape
li $v0, 4           #printf("Must give a 0,1,2 for the shape")
syscall

done:
li $v0, 10
syscall



square:          #square(int width, int curHeight)
addi $sp, $sp, -4
sw $ra, 0($sp)

beq $a0, $a1, s_end       #if(width == curHeight) goto s_end

li $t1, 0                #counter = 0
move $t2, $a0            #t2 = width
li $v0, 4

s_loop: 
la $a0, star            #a0 = "*"
syscall                 #printf("*")
addi $t1, $t1, 1        #counter = counter + 1
blt $t1, $t2, s_loop      #if(counter < width) goto s_loop

la $a0, newline         #a0 = "\n"
syscall                 #printf("\n")
move $a0, $t2           #a0 = width
addi $a1, $a1, 1        #curHeight = curHeight + 1
jal square              #square(width, curHeight + 1)

s_end:
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra



triangle:       #triangle(int width, int curHeight)
addi $sp, $sp, -4
sw $ra, 0($sp)

beq $a0, $a1, t_end       #if(width == curHeight) goto t_end

li $t1, 0                #counter = 0
move $t2, $a0            #t2 = width

li $v0, 4

t_loop: 
la $a0, star            #a0 = "*"
syscall                 #printf("*")
addi $t1, $t1, 1        #counter = counter + 1
ble $t1, $a1, t_loop    #if(counter <= curHeight) goto t_loop

la $a0, newline         #a0 = "\n"
syscall                 #printf("\n")
move $a0, $t2           #a0 = width
addi $a1, $a1, 1        #curHeight = curHeight + 1
jal triangle            #triangle(width, curHeight + 1)

t_end:
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra

pyramid:       #pyramid(int width, int curHeight)
addi $sp, $sp, -4
sw $ra, 0($sp)

beq $a0, $a1, p_end       #if(width == curHeight) goto t_end

li $t1, 0                #counter = 0
move $t2, $a0            #t2 = width

sub $t3, $a0, $a1        #bounds = width - curHeight
addi $t3, $t3, -1        #bounds = bounds - 1
move $a0, $t3
li $v0, 4

l_bound:
bge $t1, $t3, l_end      #if(counter < bounds) goto l_end
la $a0, space            #a0 = " "
syscall                  #printf(" ")
addi $t1, $t1, 1         #counter = counter + 1
j l_bound                #goto l_bound
l_end:

li $t1, 0                #counter = 0
middle:
la $a0, star             #a0 = "*"
syscall                  #printf("*")
la $a0, space            #a0 = " "
syscall                  #printf(" ")
addi $t1, $t1, 1        #counter = counter + 1
ble $t1, $a1, middle    #if(counter <= curHeight) goto middle

li $t1, 0                #counter = 0
r_bound:
bge $t1, $t3, r_end    #if(counter < bounds) goto r_end
la $a0, space            #a0 = " "
syscall                  #printf(" ")
addi $t1, $t1, 1         #counter = counter + 1
j r_bound                #goto r_bound
r_end:

la $a0, newline         #a0 = "\n"
syscall                 #printf("\n")
move $a0, $t2           #a0 = width
addi $a1, $a1, 1        #curHeight = curHeight + 1
jal pyramid             #pyramid(width, curHeight + 1)

p_end:
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
