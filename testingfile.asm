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
	S2:		.word	3232, 3104, 2976, 2848, 2724, 2728, 2860, 2988, 3116, 3244, 3368, 3364
	S1:		.word	3256, 3128, 3000, 2872, 2748, 2752, 2884, 3012, 3140, 3268, 3392, 3388
	S0:		.word	3280, 3152, 3024, 2896, 2772, 2776, 2908, 3036, 3164, 3292, 3416, 3412
	number_zero:	.word	3232, 3104, 2976, 2848, 2724, 2728, 2860, 2988, 3116, 3244, 3368, 3364
.text

	# + 24 diff, s2 is the most left digit 

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

			j SCORE				# change
			
SCORE:
			
	la $t4, S2	# $t4 = addr(zero)
	li $t5, 0		# t5 = 0
	j CREATE_SCORE

CREATE_SCORE:
	sll $a0, $t5, 2		# a0 = t5 x 2
	add $t6, $t4, $a0	# t6 = addr(t4 + a0)
	lw $t7, 0($t6)		# a0 = t4[i]
	add $a0, $t7, $t0	# map + a0 
	sw $t8, 0($a0)

	add $t5, $t5, 1
	bne $t7, 3364, CREATE_SCORE
	la $t4, S1	# $t4 = addr(zero)
	li $t5, 0		# t5 = 0
	bne $t7, 3388, CREATE_SCORE
	la $t4, S0	# $t4 = addr(zero)
	li $t5, 0		# t5 = 0
	j CREATE_SCORE
	



	
			
		
			
			
		
			
			
			

		
		
			
			
				
