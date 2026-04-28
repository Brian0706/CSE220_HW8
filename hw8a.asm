.data
typeprompt: .asciiz "Triangle(0) or Square(1) or Pyramid (2)? "
sizeprompt: .asciiz "Required size? "
newline: .asciiz "\n"
invalid: .asciiz "Must give a 0,1,2 for the shape"
star: .word '*'
space: .word ' '

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

bne $t0, $t2, not_square     #if(type != 0) goto not_square

not_square:
bne $t0, $t3, not_triangle  #if(type != 0) goto not_triangle

not_triangle:
bne $t0, $t4, not_shape     #if(type != 0) goto not_shape

not_shape:
la $a0, invalid
li $v0, 4           #printf("Must give a 0,1,2 for the shape")
syscall

done:
li $v0, 10
syscall