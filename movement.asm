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
	asteroid_1:	.word	0
	asteroid_2:	.word	0
	asteroid_3:	.word	0
	ship:		.word	0:2
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
		j WHILE_GAME
	
	
	
	


	


	
	
	
	
	
end:
	li $v0, 10
	syscall

	
	

	

	




	


	
	
	
