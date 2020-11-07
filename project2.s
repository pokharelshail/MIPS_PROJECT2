.data
	invalid: .asciiz "Invalid Input"
	reply: .space 1000
	four: .space 4
.text
.global main
main:
					#ask for user input
	li $v0,8
	la $a0, reply
	li $a1, 1000