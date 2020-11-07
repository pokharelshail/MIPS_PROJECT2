.data

	invalid: .asciiz "Invalid Input"
	message: .space 1000
	four: .space 4

.text
.global main
main:
					#ask for user input
	li $v0,8
	la $a0, message
	li $a1, 1000
	syscall
                 #load adrees of a1 from reply to i++ .check all values. If 0 then valid character not founf
	la $a1, message
	li $t9, 0
.global main
Start:
	lb $a0,($a1)
	addi $a1, $a1, 1  # increment  the pointer by 1

	beq $a0, 0, Null 
	beq $a0, 10, Null

	beq $a0, 32, Start   # keeps looping from space in front and back

	beq $t9, 1, invalidError  #invalid error

	li $t9, 1 #non space character is discovered
	
	la $s6, four				#loading the adress of Four to s6 
	
	lb $a0, -1($a1)  
	sb $a0, 0($s6)   

	lb $a0, 0($a1) 			
	sb $a0, 1($s6) 

	lb $a0, 1($a1) 			#storing the third non-space the and the fourth non-space character to  2+ and 3+ starting address of Four respectively
	sb $a0, 2($s6)
	lb $a0, 2($a1) 			
	sb $a0, 3($s6)    

	addi $a1, $a1, 3      # Four charracters have been itterated through so add  3 to $a1  
	j Start
.global main
Null:                 
	beq $t9, 0, invalidError  #if $t9=0 no space character found
	li $s5, 0			# this register holds the final sum of the Base-28 number
	li $t4, 1			# this register holds the exponent of 28. 
	li $t7, 0			# loop counter if it equals 3 the loop exits. 
	la $s6, four+4		#  start at the end of the string


