.data
	invalid: .asciiz "Invalid Input"
	reply: .space 1000		
	four: .space 4			
.text
.globl main
main:
					#ask for user input
	li $v0, 8
	la $a0, reply
	li $a1, 1000	
	syscall
	               #load adrees of a1 from reply to i++ .check all values. If 0 then valid character not founf
	la $a1, reply			
	li $t9, 0				
.globl main
Start:
	lb $a0,($a1)        			
	addi $a1, $a1, 1  # increment  the pointer by 1		
	
	beq $a0, 0, Null		
	beq $a0, 10, Null

	beq $a0, 32, Start  # keeps looping from space in front and back
	
	beq $t9, 1, invalidError		
						
	li $t9, 1				
	
	la $s6, four				#loading the adress of Four to s6 
	
	lb $a0, -1($a1)                         #storing the first non-space character to the starting address of Four
	sb $a0, 0($s6)                 

	lb $a0, 0($a1) 			#storing the second non-space character to 1+ starting address of Four
	sb $a0, 1($s6)
	
	lb $a0, 1($a1) 			#storing the third non-space character to 2+ starting address of Four
	sb $a0, 2($s6)
	lb $a0, 2($a1) 			#storing the fourth non-space character to 3+ starting address of Four
	sb $a0, 3($s6)
	
	addi $a1, $a1, 3 		# added 3 to $a1 because 4 characters from input string have already been read
	j Start
.globl main
Null:
	beq $t9, 0, invalidError		# if $t9 = 0 then, it means no non-space character is found.

						
	li $s5, 0			# this register holds the final sum of the Base-28 number
	li $t4, 1			# this register holds the exponent of 28. 
	li $t7, 0			# loop counter if it equals 3 the loop exits. 
	la $s6, four+4		#  start at the end of the string
.globl main
Loop:
	beq $t7, 4, print			#if the value of the counter = 4, then the loop exits
	addi $t7, $t7, 1 			# incrementing the value of the counter
	addi $s6, $s6, -1			#decreasing the value of the address to load 
	lb $t0, ($s6)				
	# if there is an end line, space or null character then continue the loop
	beq $t0, 10, Loop  		
	beq $t0, 32, Space		

	li $a3, 1			
				
	slti $t2, $t0, 58       	  		#Valid digit check
	li $t3, 47
	slt $t3, $t3, $t0                          
	and $t3, $t3, $t2  			
	addi $t9, $t0, -48			# initialising t9 for the original values have been calculated by substracting the overflowing ASCII
	beq $t3, 1, convert	


	slti $t2, $t0, 83		# Range from A to R. R =82. so 82 +1 must be used
	li $t3, 64 				
	slt $t3, $t3, $t0 			
	and $t3, $t3, $t2  			
	addi $t9, $t0, -55     
	beq $t3, 1, convert	

	slti $t2, $t0, 115			# Range from a to r. r =114. so 114 +1 must be used	
	li $t3, 96
	slt $t3, $t3, $t0
	and $t3, $t3, $t2  			
	addi $t9, $t0, -87
	bne $t3, 1, invalidError		
.globl main
convert:
	move $a0, $t9
	move $a2, $t4
	jal converter
	add $s5, $s5, $v0
	mul $t4, $t4, 28
	j Loop
	converter:
		mul $v0, $a0, $a2
		jr $ra
		
	

Space:					#sees if the space is in between or is at ending points, by using a3 as bool
	beq $a3, 1, invalidError		
	j Loop					
	 
print:  #print sum of all conveted values
	li $v0, 1			
	add $a0, $zero, $s5 
	syscall
	j exit
invalidError:				#print "Invalid Input" for invalid inputs
	li $v0, 4	
	la $a0, invalid
	syscall
	
				
exit:
	li $v0, 10			#terminate after all these labels
	syscall