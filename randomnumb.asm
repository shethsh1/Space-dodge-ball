#####################################################################
#
# CSCB58 Winter 2021 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Name, Student Number, UTorID
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8 (update this as needed)
# - Unit height in pixels: 8 (update this as needed)
# - Display width in pixels: 256 (update this as needed)
# - Display height in pixels: 256 (update this as needed)
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 1/2/3/4 (choose the one the applies)
#
# Which approved features have been implemented for milestone 4?
# (See the assignment handout for the list of additional features)
# 1. (fill in the feature, if any)
# 2. (fill in the feature, if any)
# 3. (fill in the feature, if any)
# ... (add more if necessary)
#
# Link to video demonstration for final submission:
# - (insert YouTube / MyMedia / other URL here). Make sure we can view it!
#
# Are you OK with us sharing the video with people outside course staff?
# - yes / no / yes, and please share this project github link as well!
#
# Any additional information that the TA needs to know:
# - (write here, if any)
#
#####################################################################

# Bitmap display starter code
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#

.eqv BASE_ADDRESS 0x10008000


.data
	asteroid_1:	.word	0
	asteroid_2:	.word	0
	asteroid_3:	.word	0
.text

	li $t0, BASE_ADDRESS # $t0 stores the base address for display
	li $t1, 0xd3d3d3 # $t1 stores the grey colour code
	li $t2, 0x000000 # $t2 stores the black colour code
	
	
asteroids:
	
	# asteroid 1
	li $v0, 42
	li $a0, 0	# a0 contains the random number from 0 to 32
	li $a1, 32
	syscall
	li $t3, 128
	mult $a0, $t3	# $a0 x 128 + 124
	mflo $a0
	addi $a0, $a0, 124
	
	la $t3, asteroid_1	# $t3 = addr(asteroid_1)
	sw $a0, 0($t3)		# $t3[0] = $a0
	add $t4, $t0, $a0 	# $t4 = addr($t0+$a0)
	sw $t1, 0($t4)		# $t4[0] = $t1 - grey
	
	
	# asteroid 2
	li $v0, 42
	li $a0, 0	# a0 contains the random number from 0 to 32
	li $a1, 32
	syscall
	li $t3, 128
	mult $a0, $t3	# $a0 x 128 + 124
	mflo $a0
	addi $a0, $a0, 124
	
	la $t3, asteroid_2	# $t3 = addr(asteroid_1)
	sw $a0, 0($t3)		# $t3[0] = $a0
	add $t4, $t0, $a0 	# $t4 = addr($t0+$a0)
	sw $t1, 0($t4)		# $t4[0] = $t1 - grey
	
	
	# asteroid 3
	li $v0, 42
	li $a0, 0	# a0 contains the random number from 0 to 32
	li $a1, 32
	syscall
	li $t3, 128
	mult $a0, $t3	# $a0 x 128 + 124
	mflo $a0
	addi $a0, $a0, 124
	
	la $t3, asteroid_3	# $t3 = addr(asteroid_1)
	sw $a0, 0($t3)		# $t3[0] = $a0
	add $t4, $t0, $a0 	# $t4 = addr($t0+$a0)
	sw $t1, 0($t4)		# $t4[0] = $t1 - grey
	
	
	li $t3, 0		# i = 0
	while_asteroids:
		beq $t3, 31 last_asteroid
	
		
		# erase asteroid 1
		la $t4, asteroid_1	# $t4 = addr(asteroid_1)
		lw $t5, 0($t4)		# $t5 = $t4[0]
		add $t6, $t5, $t0	# $t6 = addr(default + $t5)
		li $v0, 32
		li $a0, 10
		syscall
		sw $t2, 0($t6)			# $t6[0] = $t2 - black
		addi $t5, $t5, -4		# $t5 = $t5 - 4
		sw $t5, 0($t4)			# $t4[0] = $t5
		add $t6, $t5, $t0		# $t6 = addr(default + $t5)
		sw $t1, 0($t6)			# $t4[0] = $t1 - grey
		
		
		
		
		# erase asteroid 2
		la $t4, asteroid_2	# $t4 = addr(asteroid_1)
		lw $t5, 0($t4)		# $t5 = $t4[0]
		add $t6, $t5, $t0	# $t6 = addr(default + $t5)
		li $v0, 32
		li $a0, 25
		syscall
		sw $t2, 0($t6)		# $t6[0] = $t2 - black
		addi $t5, $t5, -4	# $t5 = $t5 - 4
		sw $t5, 0($t4)		# $t4[0] = $t5
		add $t6, $t5, $t0	# $t6 = addr(default + $t5)
		sw $t1, 0($t6)		# $t4[0] = $t1 - grey
		
		# erase asteroid 3
		la $t4, asteroid_3	# $t4 = addr(asteroid_1)
		lw $t5, 0($t4)		# $t5 = $t4[0]
		add $t6, $t5, $t0	# $t6 = addr(default + $t5)
		li $v0, 32
		li $a0, 42
		syscall
		sw $t2, 0($t6)		# $t6[0] = $t2 - black
		addi $t5, $t5, -4	# $t5 = $t5 - 4
		sw $t5, 0($t4)		# $t4[0] = $t5
		add $t6, $t5, $t0	# $t6 = addr(default + $t5)
		sw $t1, 0($t6)		# $t4[0] = $t1 - grey
		
		addi $t3, $t3, 1	# i = i + 1
		
		j while_asteroids
		
		
last_asteroid:
	la $t3, asteroid_1	# $t3 = addr(asteroid_1)
	lw $t4, 0($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(default + $t4)
	sw $t2, 0($t5)		# $t5[0] = $t2
	
	la $t3, asteroid_2	# $t3 = addr(asteroid_1)
	lw $t4, 0($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(default + $t4)
	sw $t2, 0($t5)		# $t5[0] = $t2
	
	la $t3, asteroid_3	# $t3 = addr(asteroid_1)
	lw $t4, 0($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(default + $t4)
	sw $t2, 0($t5)		# $t5[0] = $t2
	
	j asteroids

	
	
	
	
	
end:
	li $v0, 10
	syscall

	
	

	

	




	


	
	
	
