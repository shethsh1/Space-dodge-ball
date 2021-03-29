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
.eqv A_KEY 0x61


.data
	asteroid_1:		.word	0:5
	asteroid_1_counter:	.word   0
	asteroid_2:		.word	0:5
	asteroid_2_counter:	.word   0
	asteroid_3:		.word	0:5
	asteroid_3_counter:	.word   0
	ship:			.word	0:2
.text

	li $t0, BASE_ADDRESS 	# $t0 stores the base address for display
	li $t1, 0xd3d3d3 	# $t1 stores the grey colour code
	li $t2, 0x000000 	# $t2 stores the black colour code
	li $t8, 0x0000FF	# blue
	li $t9, 0xFFFF00	# yellow
	
	
GAME_START:



	
	la $t3, ship 		# $t3 = addr(ship)
	li $t4, 2700
	li $t5, 2568
	li $t6, 2824
	sw $t4, 0($t3)
	sw $t5, 4($t3)
	sw $t6, 8($t3)
		
	
	# create ship
	la $t3, ship		# $t3 = addr(ship)
	lw $t4, 0($t3)		# $t4 = $t3[0] 
	add $t5, $t0, $t4	# $t5 = addr($t0 + $t4)
	sw $t8, 0($t5)		# $t5[0] = $t8
	
	lw $t4, 4($t3)		# $t4 = $t3[1]
	add $t5, $t0, $t4	# $t5 = addr($t0 + $t4)
	sw $t9, 0($t5)		# $t9[0] = $t8
		
	lw $t4, 8($t3)		# $t4 = $t3[1]
	add $t5, $t0, $t4	# $t5 = addr($t0 + $t4)
	sw $t9, 0($t5)		# $t9[0] = $t8
	
	
WHILE_GAME:
	lw $t3, 0xffff0000
	beq $t3, 1, keypress_happened
	j keyboard_input_done
	
	keypress_happened:
		lw $t4, 0xffff0004
		beq $t4, 0x61, respond_to_a
		beq $t4, 0x73, respond_to_s
		beq $t4, 0x64, respond_to_d
		beq $t4, 0x77, respond_to_w
		j keyboard_input_done
		
	respond_to_d:
		la $t3, ship		# $t3 = addr(ship)
		
		lw $t5, 0($t3)		# $t5 = ship[0]
		addi $t6, $t5, 4	# $t6 = $t5 + 4  - change this for others
		add $t5, $t0, $t5	# $t5 = addr(default + t5)
		sw $t2, 0($t5)		# map[i] = $t2 - erase to black
		sw $t6, 0($t3)		# ship[0] = $t6
		add $t5, $t0, $t6	# $t5 = addr(default + t6)
		sw $t8, 0($t5)		# map[i] = $t8 - change to blue
		
		lw $t5, 4($t3)		# $t5 = ship[1]
		addi $t6, $t5, 4	# $t6 = $t5 + 4  - change this for others
		add $t5, $t0, $t5	# $t5 = addr(default + t5)
		sw $t2, 0($t5)		# map[i] = $t2 - erase to black
		sw $t6, 4($t3)		# ship[1] = $t6
		add $t5, $t0, $t6	# $t5 = addr(default + t6)
		sw $t9, 0($t5)		# map[i] = $t8 - change to blue
		
		lw $t5, 8($t3)		# $t5 = ship[1]
		addi $t6, $t5, 4	# $t6 = $t5 + 4  - change this for others
		add $t5, $t0, $t5	# $t5 = addr(default + t5)
		sw $t2, 0($t5)		# map[i] = $t2 - erase to black
		sw $t6, 8($t3)		# ship[2] = $t6
		add $t5, $t0, $t6	# $t5 = addr(default + t6)
		sw $t9, 0($t5)		# map[i] = $t8 - change to blue
		
		j keyboard_input_done
		
	respond_to_a:
		la $t3, ship		# $t3 = addr(ship)
		
		lw $t5, 0($t3)		# $t5 = ship[0]
		addi $t6, $t5, -4	# $t6 = $t5 + 4  - change this for others
		add $t5, $t0, $t5	# $t5 = addr(default + t5)
		sw $t2, 0($t5)		# map[i] = $t2 - erase to black
		sw $t6, 0($t3)		# ship[0] = $t6
		add $t5, $t0, $t6	# $t5 = addr(default + t6)
		sw $t8, 0($t5)		# map[i] = $t8 - change to blue
		
		lw $t5, 4($t3)		# $t5 = ship[1]
		addi $t6, $t5, -4	# $t6 = $t5 + 4  - change this for others
		add $t5, $t0, $t5	# $t5 = addr(default + t5)
		sw $t2, 0($t5)		# map[i] = $t2 - erase to black
		sw $t6, 4($t3)		# ship[1] = $t6
		add $t5, $t0, $t6	# $t5 = addr(default + t6)
		sw $t9, 0($t5)		# map[i] = $t8 - change to blue
		
		lw $t5, 8($t3)		# $t5 = ship[1]
		addi $t6, $t5, -4	# $t6 = $t5 + 4  - change this for others
		add $t5, $t0, $t5	# $t5 = addr(default + t5)
		sw $t2, 0($t5)		# map[i] = $t2 - erase to black
		sw $t6, 8($t3)		# ship[2] = $t6
		add $t5, $t0, $t6	# $t5 = addr(default + t6)
		sw $t9, 0($t5)		# map[i] = $t8 - change to blue
		
		j keyboard_input_done
		
		
	respond_to_s:
		la $t3, ship		# $t3 = addr(ship)
		
		lw $t5, 0($t3)		# $t5 = ship[0]
		addi $t6, $t5, 128	# $t6 = $t5 + 4  - change this for others
		add $t5, $t0, $t5	# $t5 = addr(default + t5)
		sw $t2, 0($t5)		# map[i] = $t2 - erase to black
		sw $t6, 0($t3)		# ship[0] = $t6
		add $t5, $t0, $t6	# $t5 = addr(default + t6)
		sw $t8, 0($t5)		# map[i] = $t8 - change to blue
		
		lw $t5, 4($t3)		# $t5 = ship[1]
		addi $t6, $t5, 128	# $t6 = $t5 + 4  - change this for others
		add $t5, $t0, $t5	# $t5 = addr(default + t5)
		sw $t2, 0($t5)		# map[i] = $t2 - erase to black
		sw $t6, 4($t3)		# ship[1] = $t6
		add $t5, $t0, $t6	# $t5 = addr(default + t6)
		sw $t9, 0($t5)		# map[i] = $t8 - change to blue
		
		lw $t5, 8($t3)		# $t5 = ship[1]
		addi $t6, $t5, 128	# $t6 = $t5 + 4  - change this for others
		add $t5, $t0, $t5	# $t5 = addr(default + t5)
		sw $t2, 0($t5)		# map[i] = $t2 - erase to black
		sw $t6, 8($t3)		# ship[2] = $t6
		add $t5, $t0, $t6	# $t5 = addr(default + t6)
		sw $t9, 0($t5)		# map[i] = $t8 - change to blue
		
		j keyboard_input_done
		
	respond_to_w:
		la $t3, ship		# $t3 = addr(ship)
		
		lw $t5, 0($t3)		# $t5 = ship[0]
		addi $t6, $t5, -128	# $t6 = $t5 + 4  - change this for others
		add $t5, $t0, $t5	# $t5 = addr(default + t5)
		sw $t2, 0($t5)		# map[i] = $t2 - erase to black
		sw $t6, 0($t3)		# ship[0] = $t6
		add $t5, $t0, $t6	# $t5 = addr(default + t6)
		sw $t8, 0($t5)		# map[i] = $t8 - change to blue
		
		lw $t5, 4($t3)		# $t5 = ship[1]
		addi $t6, $t5, -128	# $t6 = $t5 + 4  - change this for others
		add $t5, $t0, $t5	# $t5 = addr(default + t5)
		sw $t2, 0($t5)		# map[i] = $t2 - erase to black
		sw $t6, 4($t3)		# ship[1] = $t6
		add $t5, $t0, $t6	# $t5 = addr(default + t6)
		sw $t9, 0($t5)		# map[i] = $t8 - change to blue
		
		lw $t5, 8($t3)		# $t5 = ship[1]
		addi $t6, $t5, -128	# $t6 = $t5 + 4  - change this for others
		add $t5, $t0, $t5	# $t5 = addr(default + t5)
		sw $t2, 0($t5)		# map[i] = $t2 - erase to black
		sw $t6, 8($t3)		# ship[2] = $t6
		add $t5, $t0, $t6	# $t5 = addr(default + t6)
		sw $t9, 0($t5)		# map[i] = $t8 - change to blue
		
		j keyboard_input_done
	
	
	keyboard_input_done:
	
		obstacles_falling:
			# asteroid 1
			la $t3, asteroid_1_counter	# $t3 = addr(counter)
			lw $t4, 0($t3)			# $t4 = $t3[0]
			beq $t4, 0, SET_ASTEROID_1
			
			# erase asteroid 1
			li $v0, 32
			li $a0, 150
			syscall
			la $t4, asteroid_1	# $t4 = addr(asteroid_1)
			lw $t5, 0($t4)		# $t5 = $t4[0]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)

			
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			lw $t5, 4($t4)		# $t5 = $t4[1]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			
			lw $t5, 8($t4)		# $t5 = $t4[2]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			lw $t5, 12($t4)		# $t5 = $t4[2]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			lw $t5, 16($t4)		# $t5 = $t4[1]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			lw $t7, 0($t3)			# $t7 = addr(counter)
			beq $t7, 30, RESET_COUNTER	# if $t7 == 33, reset
			

			lw $t5, 0($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 0($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 4($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 4($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 8($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 8($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 12($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 12($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 16($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 16($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			la $t3, asteroid_1_counter	# $t3 = addr(counter)
			lw $t4, 0($t3)			# $t4 = $t3[0]
			addi $t4, $t4, 1		# $t4 = $t4 + 1
			sw $t4, 0($t3)			# counter[0] = $t4
			
			
			
			# asteroid 2
			la $t3, asteroid_2_counter	# $t3 = addr(counter)
			lw $t4, 0($t3)			# $t4 = $t3[0]
			beq $t4, 0, SET_ASTEROID_2
			
			# erase asteroid 2
			li $v0, 32
			li $a0, 150
			syscall
			la $t4, asteroid_2	# $t4 = addr(asteroid_1)
			lw $t5, 0($t4)		# $t5 = $t4[0]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)

			
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			lw $t5, 4($t4)		# $t5 = $t4[1]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			
			lw $t5, 8($t4)		# $t5 = $t4[2]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			lw $t5, 12($t4)		# $t5 = $t4[2]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			lw $t5, 16($t4)		# $t5 = $t4[1]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			lw $t7, 0($t3)			# $t7 = addr(counter)
			beq $t7, 30, RESET_COUNTER	# if $t7 == 33, reset
			

			lw $t5, 0($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 0($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 4($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 4($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 8($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 8($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 12($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 12($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 16($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 16($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			la $t3, asteroid_2_counter	# $t3 = addr(counter)
			lw $t4, 0($t3)			# $t4 = $t3[0]
			addi $t4, $t4, 1		# $t4 = $t4 + 1
			sw $t4, 0($t3)			# counter[0] = $t4
			
			
			# asteroid 3
			la $t3, asteroid_3_counter	# $t3 = addr(counter)
			lw $t4, 0($t3)			# $t4 = $t3[0]
			beq $t4, 0, SET_ASTEROID_3
			
			# erase asteroid 1
			li $v0, 32
			li $a0, 150
			syscall
			la $t4, asteroid_3	# $t4 = addr(asteroid_1)
			lw $t5, 0($t4)		# $t5 = $t4[0]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)

			
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			lw $t5, 4($t4)		# $t5 = $t4[1]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			
			lw $t5, 8($t4)		# $t5 = $t4[2]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			lw $t5, 12($t4)		# $t5 = $t4[2]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			lw $t5, 16($t4)		# $t5 = $t4[1]
			add $t6, $t5, $t0	# $t6 = addr(default + $t5)
			sw $t2, 0($t6)		# $t6[0] = $t2 - black
			
			lw $t7, 0($t3)			# $t7 = addr(counter)
			beq $t7, 30, RESET_COUNTER	# if $t7 == 33, reset
			

			lw $t5, 0($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 0($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 4($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 4($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 8($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 8($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 12($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 12($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 16($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 16($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			la $t3, asteroid_3_counter	# $t3 = addr(counter)
			lw $t4, 0($t3)			# $t4 = $t3[0]
			addi $t4, $t4, 1		# $t4 = $t4 + 1
			sw $t4, 0($t3)			# counter[0] = $t4
			

			
	
	

	
		j WHILE_GAME
	
	
	
RESET_COUNTER:
	li $t4, 0
	sw $t4, 0($t3)
	j WHILE_GAME
	

SET_ASTEROID_1:
	# asteroid 1
	li $v0, 42
	li $a0, 0	# a0 contains the random number from 0 to 32
	li $a1, 14
	syscall
	addi $a0, $a0, 1
	li $t3, 2
	mult $a0, $t3	# a0 = a0 x 2
	mflo $a0
	li $t3, 128
	mult $a0, $t3	# $a0 x 128 + 124
	mflo $a0
	addi $a0, $a0, 124
	
	la $t3, asteroid_1	# $t3 = addr(asteroid_1)
	sw $a0, 0($t3)		# $t3[0] = $a0
	add $t4, $t0, $a0 	# $t4 = addr($t0+$a0) - right wing
	addi $t7, $a0, -4
	sw $t7, 4($t3)
	addi $t7, $a0, -132
	sw $t7, 8($t3)
	addi $t7, $a0, 124
	sw $t7, 12($t3)
	addi $t7, $a0, -8
	sw $t7, 16($t3)
	sw $t1, 0($t4)		# $t4[0] = $t1 - grey
	
	addi $t5, $t4, -4	# $t5 = addr($t4-4) - center

	sw $t1, 0($t5)		# $t5[0] = $t1 - grey
	addi $t5, $t4, -132	# $t4 = addr($t0-4) - top

	sw $t1, 0($t5)		# $t4[0] = $t1 - grey
	addi $t5, $t4, 124	# $t4 = addr($t0-4) - bottom

	sw $t1, 0($t5)		# $t4[0] = $t1 - grey
	addi $t5, $t4, -8	# $t4 = addr($t0-4) - left

	sw $t1, 0($t5)		# $t4[0] = $t1 - grey
	
	la $t3, asteroid_1_counter	# $t3 = addr(counter)
	li $t4, 1			# $t4 = 1
	sw $t4, 0($t3)			# $t3[0] = 1 
	
	j WHILE_GAME
	
	
SET_ASTEROID_2:
	# asteroid 2
	li $v0, 42
	li $a0, 0	# a0 contains the random number from 0 to 32
	li $a1, 14
	syscall
	addi $a0, $a0, 1
	li $t3, 2
	mult $a0, $t3	# a0 = a0 x 2
	mflo $a0
	li $t3, 128
	mult $a0, $t3	# $a0 x 128 + 124
	mflo $a0
	addi $a0, $a0, 124
	
	la $t3, asteroid_2	# $t3 = addr(asteroid_1)
	sw $a0, 0($t3)		# $t3[0] = $a0
	add $t4, $t0, $a0 	# $t4 = addr($t0+$a0) - right wing
	addi $t7, $a0, -4
	sw $t7, 4($t3)
	addi $t7, $a0, -132
	sw $t7, 8($t3)
	addi $t7, $a0, 124
	sw $t7, 12($t3)
	addi $t7, $a0, -8
	sw $t7, 16($t3)
	sw $t1, 0($t4)		# $t4[0] = $t1 - grey
	
	addi $t5, $t4, -4	# $t5 = addr($t4-4) - center

	sw $t1, 0($t5)		# $t5[0] = $t1 - grey
	addi $t5, $t4, -132	# $t4 = addr($t0-4) - top

	sw $t1, 0($t5)		# $t4[0] = $t1 - grey
	addi $t5, $t4, 124	# $t4 = addr($t0-4) - bottom

	sw $t1, 0($t5)		# $t4[0] = $t1 - grey
	addi $t5, $t4, -8	# $t4 = addr($t0-4) - left

	sw $t1, 0($t5)		# $t4[0] = $t1 - grey
	
	la $t3, asteroid_2_counter	# $t3 = addr(counter)
	li $t4, 1			# $t4 = 1
	sw $t4, 0($t3)			# $t3[0] = 1 
	
	j WHILE_GAME
	
SET_ASTEROID_3:
	# asteroid 3
	li $v0, 42
	li $a0, 0	# a0 contains the random number from 0 to 32
	li $a1, 14
	syscall
	addi $a0, $a0, 1
	li $t3, 2
	mult $a0, $t3	# a0 = a0 x 2
	mflo $a0
	li $t3, 128
	mult $a0, $t3	# $a0 x 128 + 124
	mflo $a0
	addi $a0, $a0, 124
	
	la $t3, asteroid_3	# $t3 = addr(asteroid_1)
	sw $a0, 0($t3)		# $t3[0] = $a0
	add $t4, $t0, $a0 	# $t4 = addr($t0+$a0) - right wing
	addi $t7, $a0, -4
	sw $t7, 4($t3)
	addi $t7, $a0, -132
	sw $t7, 8($t3)
	addi $t7, $a0, 124
	sw $t7, 12($t3)
	addi $t7, $a0, -8
	sw $t7, 16($t3)
	sw $t1, 0($t4)		# $t4[0] = $t1 - grey
	
	addi $t5, $t4, -4	# $t5 = addr($t4-4) - center

	sw $t1, 0($t5)		# $t5[0] = $t1 - grey
	addi $t5, $t4, -132	# $t4 = addr($t0-4) - top

	sw $t1, 0($t5)		# $t4[0] = $t1 - grey
	addi $t5, $t4, 124	# $t4 = addr($t0-4) - bottom

	sw $t1, 0($t5)		# $t4[0] = $t1 - grey
	addi $t5, $t4, -8	# $t4 = addr($t0-4) - left

	sw $t1, 0($t5)		# $t4[0] = $t1 - grey
	
	la $t3, asteroid_3_counter	# $t3 = addr(counter)
	li $t4, 1			# $t4 = 1
	sw $t4, 0($t3)			# $t3[0] = 1 
	
	j WHILE_GAME
	
	

	
	
	
	
	
END:
	li $v0, 10
	syscall

	
	

	

	




	


	
	
	
