.data
out1: .asciiz "Yes at index "
out: .asciiz "\n"
out2: .asciiz "Not found\n"
out3: .asciiz "Enter the number of elements: "
out4: .asciiz "Enter the elements: "
out5: .asciiz "Enter the number to be searched: "

.text
.globl main
main:

    la $a0,out3 #print the string to ask user to type the  number of elements in the array
    li $v0,4 #print the string
    syscall 

    li $v0,5 #read integer entered by the user 
    syscall #read integer
    move $t0,$v0 #store the number of elements in $t0 
    
    sll $a0,$t0,2 # Memory allocation for the array in the heap 
    addi $a0,$a0,4 # Memory allocation
    li $v0,9 # Memory allocation for the array
    syscall 

    move $t2,$zero #initialise t2 to zero
    move $t1,$v0 # store the address of the array in $t1
    move $t3,$v0 # store the address of the array in $t3 also 

loop:
    bge $t2,$t0,next # jump to next once the value stored in $t2 is greater than or equal to the number of elements

    la $a0,out4 # print the string to ask user to type the elements of the array
    li $v0,4 #print the string	
    syscall

    li $v0,5 #read element to be searched
    syscall
    sw $v0,0($t3) #store the element in the array

    addi $t3,$t3,4 #increment the address of the array by 4 for the next element 
    addi $t2,$t2,1 # increment the value stored in $t2 by 1 so that the loop is only run n times where n is the number of elements
    j loop

next:
    la $a0,out5 #print the string to ask user to type the element to be binary searched in the array 
    li $v0,4 #print the string 
    syscall #print the string

    li $v0,5 #read element to be searched
    syscall
    move $t2,$v0 # store the element to be searched in $t2
    
    li $t3,0 #initialise $t3 to zero
    addi $t4,$t0,-1 #initialise $t4 to n-1 where n is the number of elements

binary_search:
    ble $t3,$t4,binary_loop # jump to binary_loop once the value stored in $t3 is less than or equal to the value stored in $t4

    la $a0,out2 #print the string to tell the user that the element is not found in the array
    li $v0, 4 #print the string
    syscall

    li $v0,10 #exit the program
    syscall

binary_loop:
    add $t5, $t3,$t4 #add the values stored in $t3 and $t4 and store the result in $t5 as high 
    sra $t5, $t5,1 #divide the value stored in $t5 by 2 and store the result in $t5 as mid

    sll $t6 ,$t5,2 #multiply the value stored in $t5 by 4 and store the result in $t6 
    add $t6,$t1,$t6 #obtain the address of the element in the array at index mid and store the result in $t6
    lw $t7,0($t6) #load the element in the array at index mid and store the result in $t7

    bgt $t7, $t2 , lower_half #jump to lower_half if the value stored in middle is greater than the value 
    blt $t7,$t2, upper_half #jump to upper_half if the value stored in middle is less than the value
    move $t8,$t5 #store the final result in $t8
    j exit #jump to exit branch 

lower_half:
    addi $t4, $t5,-1 #decrement the value stored in $t5 by 1 and store the result in $t4 as new high
    j binary_search #jump to binary_search

upper_half:
    addi $t3,$t5,1 #increment the value stored in $t5 by 1 and store the result in $t3 as new low
    j binary_search #jump to binary_search

exit:
    la $a0,out1 #print the string to tell the user that the element is found in the array
    li $v0,4 #print the string
    syscall

    move $a0,$t8 #print the index of the element in the array
    li $v0,1 #print the index of the element in the array
    syscall

    la $a0,out #print a new line
    li $v0,4 #print a new line
    syscall

    li $v0,10 #exit the program
    syscall

    

