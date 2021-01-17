.data
	n: .word 1
	
.text
.globl main

main:	
	li x1, 1	# counter
	li x2,0		# Compare to 0
	li x3,1		# Compare to 1
	lw x4,n		# Input n
	li x6, 0	# 1st integer
	li x9, 1	# 2nd integer
	li x8, 000000	# sum
	
	beq x4,x2 ZERO		# Checks if n == 0 
	beq x4, x3 ONE		# Checks if n == 1 
LOOP:	beq x4,x1 EXIT		# # Checks if counter == 47
	beq x2, x8, NULL	# If x2 == x8 == 0, printe 0
BCA:	beq x3, x1, PRINT	# If counter == 1, print 1 once
		
ABC:	li x17, 11		# Load code to print ascii char in next process
	li x10, 0x0a		# Load the actual ascii char
	ecall			# syscall
	li x17, 36		# Prints an Integer unsigned
	add x10, x6,x9		# sum x6, x9 in x10, to print result
	ecall			# syscall
	add x8,x6,x9		# add 1st and 2nd integer
	ori x6,x9,0		# Or with 0 and predecessor (x6) gets value of successor
	ori x9, x8,0		# Or with 0 and successor (x9) gets value of sum
	add x1, x1, x3		# Count = Count + 1
	
	j LOOP			# jump to label LOOP

NULL:	li x17,1 		# Print 0 as first integer if n > 1
	li x10, 0
	ecall
	li x17, 11
	li x10, 0x0a		
	ecall
	j BCA
			
ZERO:	li x17, 1		# Case if n == 0
	add x10, x10, x0	# x10 = 0
	ecall			# Print 0
	li x17,10		# Close Program
	ecall			

ONE:	li x17, 1		# case if n == 1
	li x10, 1		# x10 = 1
	ecall			# Print 1	
	li x17, 10		# Close Program
	ecall

EXIT:	#li x17, 36		# Just printed the last number up to n in previous version
	#add x10, x8,x0
	#ecall	
	li x17, 10		
	ecall			
	
PRINT:	li x17, 36		# prints an 1, because f(1) = 1
	li x10, 1		
	ecall			
	j ABC			# jumps to ABC, one time call, because counter = counter +1 and so beq not reachable anymore
