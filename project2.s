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

