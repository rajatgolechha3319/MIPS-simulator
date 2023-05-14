.data
z: .asciiz "\n"
out1: .asciiz "Enter the base: "
out2: .asciiz "Enter the exponent: "
out3: .asciiz "The result is: "
.text
main:
    li $v0,4 #print string to take base as input
    la $a0,out1
    syscall

    li $v0,5 #take base as input
    syscall 
    move $a0,$v0 #move base to $a0
    
    move $a2,$a0 #move base to $a2
    li $v0,4 #print string to take exponent as input
    la $a0,out2
    syscall
    move $a0,$a2 #move base back to $a0

    li $v0,5 #take exponent as input
    syscall
    move $a1,$v0 #move exponent to $a1

    jal fast_pow #call fast_pow function

    move $a2,$a0 #move base to $a2
    move $t7,$v0 #move result to $t7
    li $v0,4 #print string to show result
    la $a0,out3 
    syscall
    move $v0,$t7 #move result to $v0
    move $a0,$a2 #move base back to $a0

    move $a0,$v0 #move result to $a0
    li $v0,1 #print result
    syscall

    li $v0,4 #print new line
    la $a0,z
    syscall

    li $v0,10 #exit
    syscall

fast_pow:
    addi $sp,$sp,-8 #allocate space for $ra and $s0
    sw $ra,0($sp) #save $ra 
    sw $s0, 4($sp) #save $s0
    
    beq $a1,$zero,base #if exponent is 0, return 1
    div $a1,$a1,2 #divide exponent by 2 and store in $a1
    mfhi $s0  #store remainder in $s0
    
    jal fast_pow #call fast_pow function

    mul $v0,$v0,$v0 #square the number in $v0
    
    beq $s0,$zero,end #if remainder is 0, return the number
    mul $v0,$v0,$a0 #multiply the number by base
end:
    lw $ra, 0($sp) #restore $ra
    lw $s0, 4($sp) #restore $s0
    addi $sp,$sp,8 #deallocate space for $ra and $s0
    jr $ra #return to main
base:
    li $v0,1 #return 1
    j end #return to end then to main 

