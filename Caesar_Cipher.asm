# ==============================================================================
# Project:      RISC-V Caesar Cipher
# File:         Caesar_Cipher.asm
# Author:       [Landy Zhong]
# Date:         3-6-2026
# Description:  Reads a string from user input and applies a Caesar cipher 
#               encryption (shift by 3) to alphabetic characters.
#               - Supports case-sensitive wrap-around logic.
#               - Ignores spaces, numbers, and punctuation.
# ==============================================================================
.data
	prompt: .asciz "Please enter a string: "
	result: .asciz "Encrypted: "
	buffer: .space 100	# Preserve 100 bytes for user to input
	
.text
.global main

main:
	li a7, 4		# Print prompt
	la a0, prompt
	ecall
	
	li a7, 8		# Request user's string
	la a0, buffer
	li a1, 100		# Max input length (matches buffer size)
	ecall
	
	la t0, buffer		# Initialize loop variables t0: Address of input string 
	li t1, 3		# t1: Offset of encrypt
	
encrypt_loop:	
	lb t2, 0(t0)		# Read single byte from string
	li t3, 0		# Check for null terminator (0 = end of string)
	beq t2, t3, end_loop
	
	li t3, 65		
	blt t2, t3, skip_encrypt# Skip if char is below 'A' (not a letter)
	
	li t3, 122
	bgt t2, t3, skip_encrypt# Skip if char is above 'z' (not a letter)
	
	li t3, 97		# Skip if char is in ASCII gap (91–96), e.g. [ \ ] ^ _ `
	bge t2, t3, do_lowercase
	
	li t3, 90
	bgt t2, t3, skip_encrypt
	
do_uppercase:
	add t2, t1, t2		# Get the byte after offset
	
	li t3, 90		# Detect whether the result after off_set is out of range
	bgt t2, t3, out_of_range
	
	j save_and_next
	
do_lowercase:
	add t2, t1, t2		# Get the byte after offset
	
	li t3, 122		# Detect whether the result after off_set is out of range
	bgt t2, t3, out_of_range
	
	j save_and_next

out_of_range:
	li t3, 26		# Wrap around: subtract 26 to stay within A-Z or a-z
	sub t2, t2, t3

save_and_next:
	sb t2, 0(t0)		# Write encrypted byte back to buffer
	
	addi t0, t0, 1		# Increase the address by 1
	
	j encrypt_loop
	
skip_encrypt:
	addi t0, t0, 1		# Increase the address by 1
	
	j encrypt_loop

end_loop:
	li a7, 4		# Print result and exit
    	la a0, result
    	ecall
	
	li a7, 4
	la a0, buffer
	ecall
	
	li a7, 10
	ecall
	