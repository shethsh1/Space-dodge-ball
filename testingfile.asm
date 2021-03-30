.eqv BASE_ADDRESS 0x10008000


.data
	asteroid_1:	.word	0
	asteroid_2:	.word	0
	asteroid_3:	.word	0
	ship:		.word	0:2
	hearts:		.word	3928, 3936, 3944, 3952, 3960
	Alphabet_G:	.word 	524, 652, 780, 908, 912, 916, 920, 924, 796, 668, 664, 412, 408, 404, 400
	Alphabet_A:	.word   936, 808, 680, 552, 428, 432, 436, 568, 696, 824, 952, 812, 816, 820
	Alphabet_M:	.word	964, 836, 708, 580, 456, 460, 588, 716, 844, 972, 464, 596, 724, 852, 980
	Alphabet_E_1:	.word	992, 996, 1000, 1004, 1008, 864, 736, 740, 744, 748, 608, 480, 484, 488, 492, 496
	Alphabet_O:	.word	1420, 1548, 1676, 1808,1812,1816, 1692, 1564, 1436, 1304, 1300, 1296
	Alphabet_V:	.word	1448, 1320, 1576, 1708, 1840, 1716, 1592, 1464, 1336
	Alphabet_E_2:	.word	1348, 1352, 1356,1360,1364, 1476, 1604, 1608, 1612,1616, 1732, 1860, 1864,1868,1872,1876
	Alphabet_R:	.word	1888, 1760, 1632, 1504, 1376, 1380, 1384, 1388, 1520, 1648, 1644,1772, 1904, 1640, 1636

	number_zero:	.word	3364, 3240, 3112, 2984, 2852, 2976, 3104, 3232, 3360, 3368, 2856, 2848
	number_one:	.word	3360, 3364, 3368, 3236, 3108, 2980, 2852, 2848
	number_two:	.word	3360, 3364, 3368, 3232,3104,3108,3112,2984, 2856, 2852, 2848
	number_three:	.word	3360, 3364, 3368,3240,3112, 2984, 2856, 2852, 2848, 3108
	number_four:	.word 	3368, 3240, 3112, 2984, 2856, 3108, 3104, 2976, 2848
	number_five:	.word	3360, 3364, 3368, 3240, 3112, 3108, 3104, 2976, 2848, 2852, 2856
	number_six:	.word	3360, 3364, 3368, 3240,3112,3108,3104,3232, 2976, 2848, 2852, 2856
	number_seven:	.word 	3368, 3240, 3112,2984, 2856, 2852, 2848
	number_eight:	.word	3360, 3364, 3368, 3240,3112,3108,3104,3232, 2976, 2848, 2852, 2856, 2984
	number_nine:	.word	3368, 3240,3112,3108,3104, 2976, 2848, 2852, 2856, 2984
	obstacles_thrown:	.word	980
	s2:		.word	0
	s1:		.word	0
	s0:		.word	0

.text

	# + 24 diff, s2 is the most left digit 
	# 6 units

	li $t0, BASE_ADDRESS # $t0 stores the base address for display
	li $t1, 0xd3d3d3 # $t1 stores the grey colour code
	li $t2, 0x000000 # $t2 stores the black colour code
	li $t8, 255	# blue
	li $t9, 16776960	# yellow
	
	# set background to black
	li $t3, 0
	li $t4, 32

		
	WHILE_ERASE_Y:

		add $t5, $t0, $t3
		sw $t9, 0($t5)
		add $t3, $t3, 4
		beq $t3, 4100, done
		j WHILE_ERASE_Y
		
	done:
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

			j SET_SCORE_BOARD # Change
			
SET_SCORE_BOARD:


	
	la $t3, obstacles_thrown
	lw $t3, 0($t3)
	li $a0, 0
	
	# 3rd least significant bit
	li $t4, 1000
	div $t3, $t4
	mfhi $t3
	li $t4, 100
	div $t3, $t4
	mflo $t3
	
	# function time
	
	la $t7, s2
	lw $t6, 0($t7)
	
	beq $t6, 0, SET_S	# t6 = 0
	# $t6 is 1
	li $a0, 24
	la $t3, obstacles_thrown
	lw $t3, 0($t3)
	
		
	# 2nd least significant bit
	li $t4, 100
	div $t3, $t4
	mfhi $t3
	li $t4, 10
	div $t3, $t4
	mflo $t3
	
	la $t7, s1
	lw $t6, 0($t7)
	
	beq $t6, 0, SET_S	# t6 = 0
	
	li $a0, 48
	la $t3, obstacles_thrown
	lw $t3, 0($t3)
	
	# least significant bit
	li $t4, 10
	div $t3, $t4
	mfhi $t3
	li $t4, 1
	div $t3, $t4
	mflo $t3
	
	la $t7, s0
	lw $t6, 0($t7)
	
	
	
	beq $t6, 0, SET_S	# t6 = 0
	
	
	
	j DONE_SCORE_BOARD
	
SET_S:
	li $t6, 1
	sw $t6, 0($t7)
	j SET_S2_NUMBER_ZERO
			
SET_S2_NUMBER_ZERO:
	#li $t3, 9 # like says it 100, the s2 is 1
	beq $t3, 1, SET_S2_NUMBER_ONE	# $t3 = 1 set 1
	beq $t3, 2, SET_S2_NUMBER_TWO	# $t3 = 2 set 2
	beq $t3, 3, SET_S2_NUMBER_THREE	# $t3 = 2 set 2
	beq $t3, 4, SET_S2_NUMBER_FOUR	# $t3 = 1 set 1
	beq $t3, 5, SET_S2_NUMBER_FIVE	# $t3 = 2 set 2
	beq $t3, 6, SET_S2_NUMBER_SIX	# $t3 = 2 set 2
	beq $t3, 7, SET_S2_NUMBER_SEVEN	# $t3 = 1 set 1
	beq $t3, 8, SET_S2_NUMBER_EIGHT	# $t3 = 2 set 2
	beq $t3, 9, SET_S2_NUMBER_NINE	# $t3 = 2 set 2
	la $t4, number_zero
	lw $t5, 0($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 4($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 8($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 12($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 16($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 20($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 24($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 28($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 32($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 36($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 40($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 44($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)



	
	j SET_SCORE_BOARD

	


SET_S2_NUMBER_ONE:
	
	la $t4, number_one
	lw $t5, 0($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 4($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 8($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 12($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 16($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 20($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 24($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 28($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)

	
	j SET_SCORE_BOARD
	
	
SET_S2_NUMBER_TWO:

	la $t4, number_two
	lw $t5, 0($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 4($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 8($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 12($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 16($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 20($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 24($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 28($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 32($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 36($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 40($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)


	
	j SET_SCORE_BOARD
	
	
SET_S2_NUMBER_THREE:

	la $t4, number_three
	lw $t5, 0($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 4($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 8($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 12($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 16($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 20($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 24($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 28($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 32($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 36($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)


	
	j SET_SCORE_BOARD
	
SET_S2_NUMBER_FOUR:

	la $t4, number_four	# - t change
	lw $t5, 0($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 4($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 8($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 12($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 16($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 20($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 24($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 28($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 32($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)



	
	j SET_SCORE_BOARD
	
SET_S2_NUMBER_FIVE:

	la $t4, number_five	# - t change
	lw $t5, 0($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 4($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 8($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 12($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 16($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 20($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 24($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 28($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 32($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 36($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 40($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)




	
	j SET_SCORE_BOARD
	
SET_S2_NUMBER_SIX:

	la $t4, number_six	# - t change
	lw $t5, 0($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 4($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 8($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 12($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 16($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 20($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 24($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 28($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 32($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 36($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 40($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 44($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)



	
	j SET_SCORE_BOARD
	
	
SET_S2_NUMBER_SEVEN:

	la $t4, number_seven	# - t change
	lw $t5, 0($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 4($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 8($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 12($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 16($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 20($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 24($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)




	
	j SET_SCORE_BOARD
	
	
SET_S2_NUMBER_EIGHT:

	la $t4, number_eight	# - t change
	lw $t5, 0($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 4($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 8($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 12($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 16($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 20($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 24($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 28($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 32($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	
	lw $t5, 36($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	
	lw $t5, 40($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	
	lw $t5, 44($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	
	lw $t5, 48($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	

	
	



	
	j SET_SCORE_BOARD
	
SET_S2_NUMBER_NINE:

	la $t4, number_nine	# - t change
	lw $t5, 0($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 4($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 8($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 12($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 16($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 20($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 24($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 28($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	lw $t5, 32($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	
	lw $t5, 36($t4)
	add $t5, $t5, $a0 	# change num to follow digit
	add $t5, $t5, $t0
	sw $t8, 0($t5)
	

	
	



	
	j SET_SCORE_BOARD
	

	
DONE_SCORE_BOARD:
	
	


			


	



	
			
		
			
			
		
			
			
			

		
		
			
			
				
