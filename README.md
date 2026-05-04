# CSE220_HW8

Part A tests:

Test 1 - Smallest Triangle
Input: 0, 1
Result: 
*

Test 2 - Smallest Square
Input: 1, 1
Result: 
*

Test 3 - Smallest Pyramid
Input: 2, 1
Result: 
*

Test 4 - Base Triangle
Input: 5, 1
Result: 
*

Test 5 - Base Square
Input: 5, 1
Result: 
*

Test 6 - Base Pyramid
Input: 5, 1
Result: 
*

Part B tests:
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
- Set n to 5
Input: 1,2,3,4,5,6,7,8,9,0
Result: 2 1|4 3|6 5|8 7|0 9|

Test 5 - Smallest case
- Set n to 1
Input: 1,2
Result: 2 1|

Part C tests:
-Tests will involve changing v in the data section

Test 1: smallest test
Input:
v: .word 10
Result:
Sorted Array: 10

Test 2: Sorted in ascending order
Input:
v: .word 0,1,2,3,4,5,6,7,8,9
Result:
Sorted Array: 9,8,7,6,5,4,3,2,1,0

Test 3: Already Sorted
Input:
v: .word 9,8,7,6,5,4,3,2,1,0
Result:
Sorted Array: 9,8,7,6,5,4,3,2,1,0

Test 4: Repeated number
Input: 
v: .word 1,4,6,7,3,4,8,11,12,45
Result:
Sorted Array: 45 12 11 8 7 6 4 4 3 1

Test 5: Negative values
Input:
v: .word 1,4,6,-7,-3,4,8,11,-12,0
Result:
Sorted Array: 11 8 6 4 4 1 0 -3 -7 -12

Part D tests:
Test 1: Zero Matrix
Input in .data:
A: .word 1, 2, 3, 4
.word 5, 6, 7, 8
.word 9, 10, 11, 12
.word 13, 14, 15, 16
B: .word 0, 0, 0, 0 
.word 0, 0, 0, 0
.word 0, 0, 0, 0
.word 0, 0, 0, 0
.align 2
C: .space 64 # 16 integers * 4 bytes each = 64 bytes
n: .word 4 # matrix dimension (4x4)
Result:
0 0 0 0 
0 0 0 0 
0 0 0 0 
0 0 0 0

Test 2: One by One Matrix
Input in .data:
A: .word 2
B: .word 2
.align 2
C: .space 4
n: .word 1 # matrix dimension (1x1)
Result:
4

Test 3: Reciprocal Matrices
Input in .data:
A: .word 4, 3
.word 3, 2
B: .word -2, 3
.word 3, -4
.align 2
C: .space 16 # 4 integers * 4 bytes each = 16 bytes
n: .word 2 # matrix dimension (2x2)
Result:
1 0
0 1

Test 4: Base Case
Input in .data:
A: .word 1, 2, 3, 4
.word 5, 6, 7, 8
.word 9, 10, 11, 12
.word 13, 14, 15, 16
B: .word 2, 0, 0, 0
.word 0, 2, 0, 0
.word 0, 0, 2, 0
.word 0, 0, 0, 2
.align 2
C: .space 64 # 16 integers * 4 bytes each = 64 bytes
n: .word 4 # matrix dimension (4x4)
Result:
2 4 6 8 
10 12 14 16 
18 20 22 24 
26 28 30 32

Test 5: Negative Values
Input in .data:
A: .word 1, 2, -3, 4
.word -5, 6, -7, 8
.word 9, -10, 11, 12
.word 13, 14, -15, 16
B: .word -2, 0, 0, 0
.word 0, 2, 0, 0
.word 0, 0, -2, 0
.word 0, 0, 0, 2
.align 2
C: .space 64 # 16 integers * 4 bytes each = 64 bytes
n: .word 4 # matrix dimension (4x4)
Result:
-2 4 6 8 
10 12 14 16 
-18 -20 -22 24 
-26 28 30 32

