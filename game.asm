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
# - Milestone 3
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
# - yes, https://github.com/shethsh1/CSCB58-Space-asteroid-game (currently private)
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
.eqv obstacle_time 15


.data

	asteroid_1:		.word	0:5
	asteroid_1_counter:	.word   0
	asteroid_2:		.word	0:5
	asteroid_2_counter:	.word   0
	asteroid_3:		.word	0:5
	asteroid_3_counter:	.word   0
	ship:			.word	0:3
	d_edge:			.word   124, 252, 380, 508, 636, 764, 892, 1020, 1148, 1276, 1404, 1532, 1660, 1788, 1916, 2044, 2172, 2300, 2428, 2556, 2684, 2812, 2940, 3068, 3196, 3324, 3452, 3580, 3708, 3836, 3964, 4092, -1
	w_edge:			.word	0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92, 96, 100, 104, 108, 112, 116, 120, 124, -1
	s_edge:			.word	3968, 3972, 3976, 3980, 3984, 3988, 3992, 3996, 4000, 4004, 4008, 4012, 4016, 4020, 4024, 4028, 4032, 4036, 4040, 4044, 4048, 4052, 4056, 4060, 4064, 4068, 4072, 4076, 4080, 4084, 4088, 4092, -1
	a_edge:			.word	0, 128, 256, 384, 512, 640, 768, 896, 1024, 1152, 1280, 1408, 1536, 1664, 1792, 1920, 2048, 2176, 2304, 2432, 2560, 2688, 2816, 2944, 3072, 3200, 3328, 3456, 3584, 3712, 3840, 3968, -1
	total_collisions:	.word	0
	hearts:		.word	3928, 3936, 3944, 3952, 3960
	Alphabet_G:	.word 	524, 652, 780, 908, 912, 916, 920, 924, 796, 668, 664, 412, 408, 404, 400
	Alphabet_A:	.word   936, 808, 680, 552, 428, 432, 436, 568, 696, 824, 952, 812, 816, 820
	Alphabet_M:	.word	964, 836, 708, 580, 456, 460, 588, 716, 844, 972, 464, 596, 724, 852, 980
	Alphabet_E_1:	.word	992, 996, 1000, 1004, 1008, 864, 736, 740, 744, 748, 608, 480, 484, 488, 492, 496
	Alphabet_O:	.word	1420, 1548, 1676, 1808,1812,1816, 1692, 1564, 1436, 1304, 1300, 1296
	Alphabet_V:	.word	1448, 1320, 1576, 1708, 1840, 1716, 1592, 1464, 1336
	Alphabet_E_2:	.word	1348, 1352, 1356,1360,1364, 1476, 1604, 1608, 1612,1616, 1732, 1860, 1864,1868,1872,1876
	Alphabet_R:	.word	1888, 1760, 1632, 1504, 1376, 1380, 1384, 1388, 1520, 1648, 1644,1772, 1904, 1640, 1636





.text

	li $t0, BASE_ADDRESS 	# $t0 stores the base address for display
	li $t1, 0xd3d3d3 	# $t1 stores the grey colour code
	li $t2, 0x000000 	# $t2 stores the black colour code
	li $t8, 0x0000FF	# blue
	li $t9, 0xFFFF00	# yellow
	
	
GAME_START:



	la $t3, total_collisions
	sw $zero, 0($t3)
	
	la $t3, asteroid_1_counter
	sw $zero, 0($t3)
	
	la $t3, asteroid_2_counter
	sw $zero, 0($t3)
	
	la $t3, asteroid_3_counter
	sw $zero, 0($t3)
	
	
	la $t3, ship 		# $t3 = addr(ship)
	li $t4, 2700
	li $t5, 2568
	li $t6, 2824
	sw $t4, 0($t3)
	sw $t5, 4($t3)
	sw $t6, 8($t3)
	
	#sw $t9, 3968($t0) # - test pixel here
		
	
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
	
	# create hearts
	
	li $a0 0xFF0000
	la $t3, hearts
	
	lw $t4, 0($t3)
	add $t5, $t4, $t0
	sw $a0, 0($t5) 
	
	lw $t4, 4($t3)
	add $t5, $t4, $t0
	sw $a0, 0($t5) 
	
	lw $t4, 8($t3)
	add $t5, $t4, $t0
	sw $a0, 0($t5) 
	
	lw $t4, 12($t3)
	add $t5, $t4, $t0
	sw $a0, 0($t5) 
	
	lw $t4, 16($t3)
	add $t5, $t4, $t0
	sw $a0, 0($t5) 
	
	
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
		beq $t4, 0x70, respond_to_p
		j keyboard_input_done
		
	respond_to_p:
		# set background to black
		li $t3, 0
		WHILE_ERASE:


			add $t5, $t0, $t3
			sw $t2, 0($t5)
			add $t3, $t3, 4
			beq $t3, 4100, GAME_START
			j WHILE_ERASE

		
		
	respond_to_d:
		
		la $t4, ship
		lw $t5, 0($t4)
		la $t3, d_edge
		j TEST_D_EDGE
		
		not_d_edge:
		la $t3, ship		# $t3 = addr(ship)
		
		# erases
		lw $t4, 0($t3)		# $t5 = ship[0]
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		sw $t2, 0($t5)		# erases ship[0] with black
		
		lw $t4, 4($t3)		# $t5 = ship[0]
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		sw $t2, 0($t5)		# erases ship[1] with black
		
		lw $t4, 8($t3)		# $t5 = ship[0]
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		sw $t2, 0($t5)		# erases ship[1] with black
		
		# adds it again by 4 paces 
		lw $t4, 0($t3)		# $t4 = ship[0]
		add $t4, $t4, 4		# $t4 = $t4 + 4
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		
		lw $t7, 0($t5)
		move $a0, $t4
		beq $t7, $t1, D_MOVEMENT_COLLISION
		sw $t8, 0($t5)		# adds blue
		
		lw $t4, 4($t3)		# $t4 = ship[0]
		add $t4, $t4, 4		# $t4 = $t4 + 4
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		lw $t7, 0($t5)
		move $a0, $t4
		beq $t7, $t1, D_MOVEMENT_COLLISION
		sw $t9, 0($t5)		# adds yellow
		
		lw $t4, 8($t3)		# $t4 = ship[0]
		add $t4, $t4, 4		# $t4 = $t4 + 4
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		move $a0, $t4
		beq $t7, $t1, D_MOVEMENT_COLLISION
		sw $t9, 0($t5)		# adds yellow	
		
		
		# update ship
		
		lw $t4, 0($t3)		# $t4 = ship[0]
		add $t4, $t4, 4
		sw $t4, 0($t3)
		
		lw $t4, 4($t3)		# $t4 = ship[0]
		add $t4, $t4, 4
		sw $t4, 4($t3)
		
		lw $t4, 8($t3)		# $t4 = ship[0]
		add $t4, $t4, 4
		sw $t4, 8($t3)
	

		
		j keyboard_input_done
		
	respond_to_a:
	
		la $t4, ship
		lw $t5, 8($t4)
		la $t3, a_edge
		j TEST_A_EDGE
		
		not_a_edge:
	
		la $t3, ship		# $t3 = addr(ship)
		
		# erases
		lw $t4, 0($t3)		# $t5 = ship[0]
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		sw $t2, 0($t5)		# erases ship[0] with black
		
		lw $t4, 4($t3)		# $t5 = ship[0]
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		sw $t2, 0($t5)		# erases ship[1] with black
		
		lw $t4, 8($t3)		# $t5 = ship[0]
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		sw $t2, 0($t5)		# erases ship[1] with black
		
		
		
		# adds it again by 4 paces 
		lw $t4, 0($t3)		# $t4 = ship[0]
		add $t4, $t4, -4		# $t4 = $t4 + 4
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		
		lw $t7, 0($t5)
		move $a0, $t4
		beq $t7, $t1, D_MOVEMENT_COLLISION
		sw $t8, 0($t5)		# adds blue
		
		lw $t4, 4($t3)		# $t4 = ship[0]
		add $t4, $t4, -4		# $t4 = $t4 + 4
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		lw $t7, 0($t5)
		move $a0, $t4
		beq $t7, $t1, D_MOVEMENT_COLLISION
		sw $t9, 0($t5)		# adds yellow
		
		lw $t4, 8($t3)		# $t4 = ship[0]
		add $t4, $t4, -4		# $t4 = $t4 + 4
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		move $a0, $t4
		beq $t7, $t1, D_MOVEMENT_COLLISION
		sw $t9, 0($t5)		# adds yellow	
		
		
		# update ship
		
		lw $t4, 0($t3)		# $t4 = ship[0]
		add $t4, $t4, -4
		sw $t4, 0($t3)
		
		lw $t4, 4($t3)		# $t4 = ship[0]
		add $t4, $t4, -4
		sw $t4, 4($t3)
		
		lw $t4, 8($t3)		# $t4 = ship[0]
		add $t4, $t4, -4
		sw $t4, 8($t3)
		
		j keyboard_input_done
		
		
	respond_to_s:
		la $t4, ship
		lw $t5, 8($t4)
		la $t3, s_edge
		j TEST_S_EDGE
		
		not_s_edge:	
		la $t3, ship		# $t3 = addr(ship)
		
		# erases
		lw $t4, 0($t3)		# $t5 = ship[0]
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		sw $t2, 0($t5)		# erases ship[0] with black
		
		lw $t4, 4($t3)		# $t5 = ship[0]
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		sw $t2, 0($t5)		# erases ship[1] with black
		
		lw $t4, 8($t3)		# $t5 = ship[0]
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		sw $t2, 0($t5)		# erases ship[1] with black
		
		# adds it again by 4 paces 
		lw $t4, 0($t3)		# $t4 = ship[0]
		add $t4, $t4, 128	# $t4 = $t4 + 4
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		
		move $a0, $t4
		beq $t7, $t1, D_MOVEMENT_COLLISION
		sw $t8, 0($t5)		# adds blue
		
		lw $t4, 4($t3)		# $t4 = ship[0]
		add $t4, $t4, 128	# $t4 = $t4 + 4
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		lw $t7, 0($t5)
		move $a0, $t4
		beq $t7, $t1, D_MOVEMENT_COLLISION
		sw $t9, 0($t5)		# adds yellow
		
		lw $t4, 8($t3)		# $t4 = ship[0]
		add $t4, $t4, 128	# $t4 = $t4 + 4
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		move $a0, $t4
		beq $t7, $t1, D_MOVEMENT_COLLISION
		sw $t9, 0($t5)		# adds yellow	
		
		
		# update ship
		
		lw $t4, 0($t3)		# $t4 = ship[0]
		add $t4, $t4, 128
		sw $t4, 0($t3)
		
		lw $t4, 4($t3)		# $t4 = ship[0]
		add $t4, $t4, 128
		sw $t4, 4($t3)
		
		lw $t4, 8($t3)		# $t4 = ship[0]
		add $t4, $t4, 128
		sw $t4, 8($t3)
		
		j keyboard_input_done
		
	respond_to_w:
		la $t4, ship
		lw $t5, 4($t4)
		la $t3, w_edge
		j TEST_W_EDGE
		
		not_w_edge:
		la $t3, ship		# $t3 = addr(ship)
		
		# erases
		lw $t4, 0($t3)		# $t5 = ship[0]
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		sw $t2, 0($t5)		# erases ship[0] with black
		
		lw $t4, 4($t3)		# $t5 = ship[0]
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		sw $t2, 0($t5)		# erases ship[1] with black
		
		lw $t4, 8($t3)		# $t5 = ship[0]
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		sw $t2, 0($t5)		# erases ship[1] with black
		
		# adds it again by 4 paces 
		lw $t4, 0($t3)		# $t4 = ship[0]
		add $t4, $t4, -128	# $t4 = $t4 + 4
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		
		lw $t7, 0($t5)
		move $a0, $t4
		beq $t7, $t1, D_MOVEMENT_COLLISION
		sw $t8, 0($t5)		# adds blue
		
		lw $t4, 4($t3)		# $t4 = ship[0]
		add $t4, $t4, -128	# $t4 = $t4 + 4
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		lw $t7, 0($t5)
		move $a0, $t4
		beq $t7, $t1, D_MOVEMENT_COLLISION
		sw $t9, 0($t5)		# adds yellow
		
		lw $t4, 8($t3)		# $t4 = ship[0]
		add $t4, $t4, -128	# $t4 = $t4 + 4
		add $t5, $t4, $t0	# $t5 = addr(map + $t4)
		move $a0, $t4
		beq $t7, $t1, D_MOVEMENT_COLLISION
		sw $t9, 0($t5)		# adds yellow	
		
		
		# update ship
		
		lw $t4, 0($t3)		# $t4 = ship[0]
		add $t4, $t4, -128
		sw $t4, 0($t3)
		
		lw $t4, 4($t3)		# $t4 = ship[0]
		add $t4, $t4, -128
		sw $t4, 4($t3)
		
		lw $t4, 8($t3)		# $t4 = ship[0]
		add $t4, $t4, -128
		sw $t4, 8($t3)
		
		j keyboard_input_done
	
	
	keyboard_input_done:
	
		obstacles_falling:
			# asteroid 1
			la $t3, asteroid_1_counter	# $t3 = addr(counter)
			lw $t4, 0($t3)			# $t4 = $t3[0]
			beq $t4, 0, SET_ASTEROID_1
			
			# erase asteroid 1
			li $v0, 32
			li $a0, obstacle_time
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
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 4($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 4($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 8($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 8($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 12($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 12($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 16($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 16($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
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
			li $a0, obstacle_time
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
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 4($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 4($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 8($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 8($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 12($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 12($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 16($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 16($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			la $t3, asteroid_2_counter	# $t3 = addr(counter)
			lw $t4, 0($t3)			# $t4 = $t3[0]
			addi $t4, $t4, 1		# $t4 = $t4 + 1
			sw $t4, 0($t3)			# counter[0] = $t4
			
			
			# asteroid 3
			la $t3, asteroid_3_counter	# $t3 = addr(counter)
			lw $t4, 0($t3)			# $t4 = $t3[0]
			beq $t4, 0, SET_ASTEROID_3
			
			# erase asteroid 3
			li $v0, 32
			li $a0, obstacle_time
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
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 4($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 4($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 8($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 8($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 12($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 12($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			lw $t5, 16($t4)			# $t5 = asteroid[0]
			addi $t5, $t5, -4		# $t5 = $t5 - 4
			sw $t5, 16($t4)			# $t4[0] = $t5
			add $t6, $t5, $t0		# $t6 = addr(default + $t5)
			
			lw $t7, 0($t6)
			beq $t7, $t8, RESET_COUNTER_COLLISION
			beq $t7, $t9, RESET_COUNTER_COLLISION
			
			sw $t1, 0($t6)			# $t4[0] = $t1 - grey
			
			la $t3, asteroid_3_counter	# $t3 = addr(counter)
			lw $t4, 0($t3)			# $t4 = $t3[0]
			addi $t4, $t4, 1		# $t4 = $t4 + 1
			sw $t4, 0($t3)			# counter[0] = $t4			
			



		j WHILE_GAME
	
RESET_COUNTER_COLLISION:
	li $a0, 0
	sw $a0, 0($t3)
	
	
	# erase asteroid 1
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
	
	li $t6, 0xFF2D00	# red
	la $t3, ship
	lw $t4, 0($t3)
	add $t5, $t0, $t4
	sw $t6, 0($t5)
	lw $t4, 4($t3)
	add $t5, $t0, $t4
	sw $t6, 0($t5)
	lw $t4, 8($t3)
	add $t5, $t0, $t4
	sw $t6, 0($t5)
	
	
	li $v0, 32
	li $a0, 100
	syscall
	
	
	la $t3, ship
	lw $t4, 0($t3)
	add $t5, $t0, $t4
	sw $t8, 0($t5)
	lw $t4, 4($t3)
	add $t5, $t0, $t4
	sw $t9, 0($t5)
	lw $t4, 8($t3)
	add $t5, $t0, $t4
	sw $t9, 0($t5)
	
	
	la $t3, total_collisions
	lw $t4, 0($t3)
	addi $t4, $t4, 1
	sw $t4, 0($t3)
	beq $t4, 5, END
	
	
	# check if 5 is reached  
	
	la $t6, hearts
	addi $t4, $t4, -1
	sll $t4, $t4, 2
	add $t4, $t4, $t6
	lw $t7, 0($t4)
	
	add $t7, $t0, $t7

	sw $t2, 0($t7) 
			
	j WHILE_GAME

	
RESET_COUNTER:
	li $t4, 0
	sw $t4, 0($t3)
	j WHILE_GAME
	

SET_ASTEROID_1:
	# asteroid 1
	li $v0, 42
	li $a0, 0	# a0 contains the random number from 0 to 32
	li $a1, 13
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
	li $a1, 13
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
	li $a1, 13
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

	

TEST_D_EDGE:

	lw $t6, 0($t3)			# $t6 = $t3[0]
	
	beq $t5, $t6, keyboard_input_done
	blt $t5, $t6, not_d_edge  
	beq $t6, -1, not_d_edge
	addi $t3, $t3, 4
	j TEST_D_EDGE
	
	
TEST_W_EDGE:

	lw $t6, 0($t3)			# $t6 = $t3[0]
	
	beq $t5, $t6, keyboard_input_done
	blt $t5, $t6, not_w_edge  
	beq $t6, -1, not_w_edge
	addi $t3, $t3, 4
	j TEST_W_EDGE
	
	
TEST_S_EDGE:

	lw $t6, 0($t3)			# $t6 = $t3[0]
	
	beq $t5, $t6, keyboard_input_done
	blt $t5, $t6, not_s_edge  
	beq $t6, -1, not_s_edge
	addi $t3, $t3, 4
	j TEST_S_EDGE
	
TEST_A_EDGE:

	lw $t6, 0($t3)			# $t6 = $t3[0]
	
	beq $t5, $t6, keyboard_input_done
	blt $t5, $t6, not_a_edge  
	beq $t6, -1, not_a_edge
	addi $t3, $t3, 4
	j TEST_A_EDGE

		
D_MOVEMENT_COLLISION:


	# first check asteroid_1
	la $t3, asteroid_1		# $t3 = addr(asteroid_1)
	
	lw $t4, 0($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_1	# if its equal
	
	lw $t4, 4($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_1	# if its equal
	
	lw $t4, 8($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_1	# if its equal
	
	lw $t4, 12($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_1	# if its equal
	
	lw $t4, 16($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_1	# if its equal
	
	# first check asteroid_1
	la $t3, asteroid_2		# $t3 = addr(asteroid_1)
	
	lw $t4, 0($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_2	# if its equal
	
	lw $t4, 4($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_2	# if its equal
	
	lw $t4, 8($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_2	# if its equal
	
	lw $t4, 12($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_2	# if its equal
	
	lw $t4, 16($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_2	# if its equal
	
	# first check asteroid_3
	la $t3, asteroid_3		# $t3 = addr(asteroid_1)
	
	lw $t4, 0($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_3	# if its equal
	
	lw $t4, 4($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_3	# if its equal
	
	lw $t4, 8($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_3	# if its equal
	
	lw $t4, 12($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_3	# if its equal
	
	lw $t4, 16($t3)			# $t4 = $t3[0]
	beq $a0, $t4, ERASE_ASTEROID_3	# if its equal
	
	
	

	
	
	

			
ERASE_ASTEROID_1:

	# delete asteroid
	lw $t4, 0($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	lw $t4, 4($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	lw $t4, 8($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	lw $t4, 12($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	lw $t4, 16($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	la $t4, asteroid_1_counter
	li $t5, 0
	sw $t5, 0($t4)
	
	
	# make ship go red
	li $t6, 0xFF2D00	# red
	la $t3, ship
	lw $t4, 0($t3)
	add $t5, $t0, $t4
	sw $t6, 0($t5)
	lw $t4, 4($t3)
	add $t5, $t0, $t4
	sw $t6, 0($t5)
	lw $t4, 8($t3)
	add $t5, $t0, $t4
	sw $t6, 0($t5)
	
	
	li $v0, 32
	li $a0, 100
	syscall
	
	
	la $t3, ship
	lw $t4, 0($t3)
	add $t5, $t0, $t4
	sw $t8, 0($t5)
	lw $t4, 4($t3)
	add $t5, $t0, $t4
	sw $t9, 0($t5)
	lw $t4, 8($t3)
	add $t5, $t0, $t4
	sw $t9, 0($t5)
	
	la $t3, total_collisions
	lw $t4, 0($t3)
	addi $t4, $t4, 1
	sw $t4, 0($t3)
	
	beq $t4, 5, END
	
	# check if 5 is reached 
	la $t6, hearts
	addi $t4, $t4, -1
	sll $t4, $t4, 2
	add $t4, $t4, $t6
	lw $t7, 0($t4)
	
	add $t7, $t0, $t7

	sw $t2, 0($t7) 
	
	
	
	
	j WHILE_GAME
	
	
ERASE_ASTEROID_2:

	# delete asteroid
	lw $t4, 0($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	lw $t4, 4($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	lw $t4, 8($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	lw $t4, 12($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	lw $t4, 16($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	la $t4, asteroid_2_counter
	li $t5, 0
	sw $t5, 0($t4)
	
	
	# make ship go red
	li $t6, 0xFF2D00	# red
	la $t3, ship
	lw $t4, 0($t3)
	add $t5, $t0, $t4
	sw $t6, 0($t5)
	lw $t4, 4($t3)
	add $t5, $t0, $t4
	sw $t6, 0($t5)
	lw $t4, 8($t3)
	add $t5, $t0, $t4
	sw $t6, 0($t5)
	
	
	li $v0, 32
	li $a0, 100
	syscall
	
	
	la $t3, ship
	lw $t4, 0($t3)
	add $t5, $t0, $t4
	sw $t8, 0($t5)
	lw $t4, 4($t3)
	add $t5, $t0, $t4
	sw $t9, 0($t5)
	lw $t4, 8($t3)
	add $t5, $t0, $t4
	sw $t9, 0($t5)
	
	la $t3, total_collisions
	lw $t4, 0($t3)
	addi $t4, $t4, 1
	sw $t4, 0($t3)
	
	beq $t4, 5, END
	
	la $t6, hearts
	addi $t4, $t4, -1
	sll $t4, $t4, 2
	add $t4, $t4, $t6
	lw $t7, 0($t4)
	
	add $t7, $t0, $t7

	sw $t2, 0($t7) 
	
	
	j WHILE_GAME
	
	
ERASE_ASTEROID_3:

	# delete asteroid
	lw $t4, 0($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	lw $t4, 4($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	lw $t4, 8($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	lw $t4, 12($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	lw $t4, 16($t3)		# $t4 = $t3[0]
	add $t5, $t4, $t0	# $t5 = addr(base + t4)
	sw $t2, 0($t5)		# - erase to black
	
	la $t4, asteroid_3_counter
	li $t5, 0
	sw $t5, 0($t4)
	
	
	# make ship go red
	li $t6, 0xFF2D00	# red
	la $t3, ship
	lw $t4, 0($t3)
	add $t5, $t0, $t4
	sw $t6, 0($t5)
	lw $t4, 4($t3)
	add $t5, $t0, $t4
	sw $t6, 0($t5)
	lw $t4, 8($t3)
	add $t5, $t0, $t4
	sw $t6, 0($t5)
	
	
	li $v0, 32
	li $a0, 50
	syscall
	
	
	la $t3, ship
	lw $t4, 0($t3)
	add $t5, $t0, $t4
	sw $t8, 0($t5)
	lw $t4, 4($t3)
	add $t5, $t0, $t4
	sw $t9, 0($t5)
	lw $t4, 8($t3)
	add $t5, $t0, $t4
	sw $t9, 0($t5)
	
	la $t3, total_collisions
	lw $t4, 0($t3)
	addi $t4, $t4, 1
	sw $t4, 0($t3)
	
	beq $t4, 5, END
	
	la $t6, hearts			# $t6 = addr(hearts)
	addi $t4, $t4, -1		# $t4 = $t4 - 1
	sll $t4, $t4, 2			# $t4 = $t4 x 4
	add $t4, $t4, $t6		# $t4 = $t6(0) + 4 
	lw $t7, 0($t4)
	
	add $t7, $t0, $t7

	sw $t2, 0($t7) 

	
	
	
	
	
	
	j WHILE_GAME
		
	
	
END:
	
	# set background to black
	li $t3, 0
	WHILE_GAME_OVER:


		add $t5, $t0, $t3
		sw $t9, 0($t5)
		add $t3, $t3, 4
		beq $t3, 4100, DRAW_LETTERS
		j WHILE_GAME_OVER
		
DRAW_LETTERS:
    la $t4, Alphabet_G
    li $a0, 0
    create_G:
        sll $a1, $a0, 2
        add $a1, $a1, $t4
        lw $t5, 0($a1)
        add $t6, $t5, $t0
        li $t7, 0xFF0000	# red
        sw $t7, 0($t6)
        addi $a0, $a0, 1
        bne $t5, 400, create_G
        li $a0, 0
        la $t4, Alphabet_A
        j create_A
    
    
    create_A:
        sll $a1, $a0, 2
        add $a1, $a1, $t4
        lw $t5, 0($a1)
        add $t6, $t5, $t0
        li $t7, 0xFF0000	# red
        sw $t7, 0($t6)
        addi $a0, $a0, 1
        bne $t5, 820, create_A
        li $a0, 0
        la $t4, Alphabet_M
        j create_M
    
    create_M:
        sll $a1, $a0, 2
        add $a1, $a1, $t4
        lw $t5, 0($a1)
        add $t6, $t5, $t0
        li $t7, 0xFF0000	# red
        sw $t7, 0($t6)
        addi $a0, $a0, 1
        bne $t5, 980, create_M
        li $a0, 0
        la $t4, Alphabet_E_1
        j create_E_1
    
    create_E_1:
        sll $a1, $a0, 2
        add $a1, $a1, $t4
        lw $t5, 0($a1)
        add $t6, $t5, $t0
        li $t7, 0xFF0000	# red
        sw $t7, 0($t6)
        addi $a0, $a0, 1
        bne $t5, 496, create_E_1
        li $a0, 0
        la $t4, Alphabet_O
        j create_O
    
    create_O:
        sll $a1, $a0, 2
        add $a1, $a1, $t4
        lw $t5, 0($a1)
        add $t6, $t5, $t0
        li $t7, 0xFF0000	# red
        sw $t7, 0($t6)
        addi $a0, $a0, 1
        bne $t5, 1296, create_O	# change, + number
        li $a0, 0
        la $t4, Alphabet_V	# change
        j create_V		# change
    
    create_V:
        sll $a1, $a0, 2
        add $a1, $a1, $t4
        lw $t5, 0($a1)
        add $t6, $t5, $t0
        li $t7, 0xFF0000	# red
        sw $t7, 0($t6)
        addi $a0, $a0, 1
        bne $t5, 1336, create_V	# change, + number
        li $a0, 0
        la $t4, Alphabet_E_2		# change
        j create_E_2			# change
    
    create_E_2:
    
        sll $a1, $a0, 2
        add $a1, $a1, $t4
        lw $t5, 0($a1)
        add $t6, $t5, $t0
        li $t7, 0xFF0000	# red
        sw $t7, 0($t6)
        addi $a0, $a0, 1
        bne $t5, 1876, create_E_2		# change, + number
        li $a0, 0
        la $t4, Alphabet_R		# change
        j create_R			# change
    
    create_R:
        sll $a1, $a0, 2
        add $a1, $a1, $t4
        lw $t5, 0($a1)
        add $t6, $t5, $t0
        li $t7, 0xFF0000	# red
        sw $t7, 0($t6)
        addi $a0, $a0, 1
        bne $t5, 1636, create_R		# change, + number
    
        j DRAWING_DONE				# change
		
DRAWING_DONE:
	lw $t3, 0xffff0000
	beq $t3, 1, pressed_p
	j DRAWING_DONE
	
	
	
pressed_p:
	lw $t4, 0xffff0004
	beq $t4, 0x70, respond_to_p
	j DRAWING_DONE


	
	



	




	


	
	
	
