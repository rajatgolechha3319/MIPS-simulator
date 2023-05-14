.data  # data section to store the data values
out1: .asciiz "Enter the string: " # take a string as input
input_string: .space 100 # allocation of memory to the variable where input is stored
.text #text section where main function is run
main:  # main function 
    la $a0,out1 # loading the memory address of the out1 string
    li $v0,4 # system call for printing the string
    syscall # syscall

    li $v0,8 # system call for taking input by laoding systeam call code
    la $a0,input_string # loading the memory address of the input_string 
    li $a1,100 # specifying the maximum number of characters to read
    syscall # syscall

    la $a0,input_string
    li $v0,4 # system call for printing the input string
    syscall # here no need to load the ouput string address in $a0 as it is already done
            # above and we haven't changed the $a0 
    
    li $v0,10 # sytem call for exiting 
    syscall
# here we don't need to use the .data to define a variable to store the input there as 
# we are outputing the string as we take it and store it in the heap

