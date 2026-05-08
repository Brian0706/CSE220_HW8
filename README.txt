# CSE220_HW8
# Brian Chau
# SBU ID: 116125954

Part A tests:

Test 1 - Smallest Triangle
Input: 
Shape: 0
Size: 1
Result: 
*

Test 2 - Smallest Square
Input: 
Shape: 1
Size: 1
Result: 
*

Test 3 - Smallest Pyramid
Input: 
Shape: 2
Size: 1
Result: 
* 

Test 4 - Base Triangle
Input: 
Shape: 0
Size: 5
Result: 
*
**
***
****
*****

Test 5 - Base Square
Input:
Shape: 1
Size: 5
Result: 
*****
*****
*****
*****
*****

Test 6 - Base Pyramid
Input: 
Shape: 2
Size: 5
Result: 
    * 
   * * 
  * * * 
 * * * * 
* * * * * 

Part B tests:
- The input is given as a comma seperated list. To run this take each number and input them into the console
  left to right
- Some of these tests have a data section before input, this indicates what needs to be copied into the data 
  section for the program to get the desired result along with the input in the console
- If the data is not given, use this default data section:
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

Test 1 - Same values
Input: 1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,0,0
Result: 1 1|2 2|3 3|4 4|5 5|6 6|7 7|8 8|9 9|0 0|

Test 2 - Base case
Input: 1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0
Result: 2 1|4 3|6 5|8 7|0 9|2 1|4 3|6 5|8 7|0 9|

Test 3 - Negative numbers
Input: 1,-2,-3,4,-5,6,-7,-8,9,0,1,-2,-3,4,5,6,-7,-8,9,0
Result: -2 1|4 -3|6 -5|-8 -7|0 9|-2 1|4 -3|6 5|-8 -7|0 9|

Test 4 - Different n
.data
.align 2
A: .space 20 #memory space for Array A
B: .space 20 #memory space for Array B
num: .word 5
startA: .asciiz "A["
startB: .asciiz "B["
ending: .asciiz "]="
newline: .asciiz "\n"
border: .asciiz "|"
space: .asciiz " "

Input: 1,2,3,4,5,6,7,8,9,0
Result: 2 1|4 3|6 5|8 7|0 9|

Test 5 - Smallest case
.data
.align 2
A: .space 4 #memory space for Array A
B: .space 4 #memory space for Array B
num: .word 1
startA: .asciiz "A["
startB: .asciiz "B["
ending: .asciiz "]="
newline: .asciiz "\n"
border: .asciiz "|"
space: .asciiz " "

Input: 1,2
Result: 2 1|

Part C tests:
-Tests will involve changing the data section
-Copy paste the input into data

Test 1: smallest test
Input:
.data
v: .word 10     #Array that will be sorted
n: .word 1      #Size of array
message: .asciiz "Sorted Array: "
space: .asciiz " "

Result:
Sorted Array: 10 

Test 2: Sorted in ascending order
Input:
.data
v: .word 0,1,2,3,4,5,6,7,8,9     #Array that will be sorted
n: .word 10                      #Size of array
message: .asciiz "Sorted Array: "
space: .asciiz " "

Result:
Sorted Array: 9 8 7 6 5 4 3 2 1 0 

Test 3: Already Sorted
Input:
.data
v: .word 9,8,7,6,5,4,3,2,1,0     #Array that will be sorted
n: .word 10                      #Size of array
message: .asciiz "Sorted Array: "
space: .asciiz " "

Result:
Sorted Array: 9 8 7 6 5 4 3 2 1 0 

Test 4: Repeated number
Input: 
.data
v: .word 1,4,6,7,3,4,8,11,12,45     #Array that will be sorted
n: .word 10                         #Size of array
message: .asciiz "Sorted Array: "
space: .asciiz " "

Result:
Sorted Array: 45 12 11 8 7 6 4 4 3 1 

Test 5: Negative values
Input:
.data
v: .word 1,4,6,-7,-3,4,8,11,-12,0     #Array that will be sorted
n: .word 10                           #Size of array
message: .asciiz "Sorted Array: "
space: .asciiz " "

Result:
Sorted Array: 11 8 6 4 4 1 0 -3 -7 -12 

Part D tests:
-Tests will involve changing the data section
-Copy paste the input into data

Test 1: Zero Matrix
Input:
.data
A: .word 1, 2, 3, 4       # Matrix to be multiplied n x m
.word 5, 6, 7, 8
.word 9, 10, 11, 12
.word 13, 14, 15, 16
B: .word 0, 0, 0, 0       # Matrix to be multiplied m x p
.word 0, 0, 0, 0
.word 0, 0, 0, 0
.word 0, 0, 0, 0
.align 2
C: .space 64 # 16 integers * 4 bytes each = 64 bytes
n: .word 4 # matrix dimension (4x4)
newline: .asciiz "\n"
space: .asciiz " "
Result:
0 0 0 0 
0 0 0 0 
0 0 0 0 
0 0 0 0 

Test 2: One by One Matrix
Input:
.data
A: .word 2       # Matrix to be multiplied n x m
B: .word 2       # Matrix to be multiplied m x p
.align 2
C: .space 4
n: .word 1 # matrix dimension (1x1)
newline: .asciiz "\n"
space: .asciiz " "
Result:
4 

Test 3: Reciprocal Matrices
Input:
.data
A: .word 4, 3       # Matrix to be multiplied n x m
.word 3, 2
B: .word -2, 3      # Matrix to be multiplied m x p
.word 3, -4
.align 2
C: .space 16 # 4 integers * 4 bytes each = 16 bytes
n: .word 2 # matrix dimension (2x2)
newline: .asciiz "\n"
space: .asciiz " "
Result:
1 0 
0 1 

Test 4: Base Case
Input:
.data
A: .word 1, 2, 3, 4       # Matrix to be multiplied n x m
.word 5, 6, 7, 8
.word 9, 10, 11, 12
.word 13, 14, 15, 16
B: .word 2, 0, 0, 0       # Matrix to be multiplied m x p
.word 0, 2, 0, 0
.word 0, 0, 2, 0
.word 0, 0, 0, 2
.align 2
C: .space 64 # 16 integers * 4 bytes each = 64 bytes
n: .word 4 # matrix dimension (4x4)
newline: .asciiz "\n"
space: .asciiz " "
Result:
2 4 6 8 
10 12 14 16 
18 20 22 24 
26 28 30 32 

Test 5: Negative Values
Input:
.data
A: .word 1, 2, -3, 4       # Matrix to be multiplied n x m
.word -5, 6, -7, 8
.word 9, -10, 11, 12
.word 13, 14, -15, 16
B: .word -2, 0, 0, 0       # Matrix to be multiplied m x p
.word 0, 2, 0, 0
.word 0, 0, -2, 0
.word 0, 0, 0, 2
.align 2
C: .space 64 # 16 integers * 4 bytes each = 64 bytes
n: .word 4 # matrix dimension (4x4)
newline: .asciiz "\n"
space: .asciiz " "
Result:
-2 4 6 8 
10 12 14 16 
-18 -20 -22 24 
-26 28 30 32 

Things to note about my functions

Part A
- size of 0 is considered to be invalid and as such, inputing a 0 for size will result in an error message
- giving a shape argument that is not 0,1 or 2 will result in an error message
- Also, to accomidate printing the stars of pyramid, the print_star_line takes two arguments instead of One
    -The two arguments are: times which is the number of times to print the string
                            string the string which is to repeadtly printed
- For the pyramid, there is an extra trailing space, as it calls print_star_line with the string "* "
    - This does not affect what the pyramid looks like and this can only be seen by highlighting it

Part B
- Part B uses two functions, one to swap the arrays and one to print the result
- Part B uses the num to figure out what the size of the array is. If the array is smaller than what num indicates
    -The function will go into memory that is unreserved causing undefined behavior

Part C
- The program assumes that num gives the correct size of the array
- If num is too large or too small, the program will either read too much or too little memory
- This function also has a trailing space in the output

Part D
- The program only works with square matrices, as there is only one size argument given
- The code can be easily modified by adding in additonal integer words in data and assigning them to a0, a1 or a2
- Likewise, to print out C correctly, you will need to change the code if you decide to add in more dimesions besides n.
- This function also has a trailing space in the output for each line


