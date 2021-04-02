#####################################################################
#
# CSCB58 Winter 2021 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Shaahid Sheth, 1002546060, shethsh1
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8 
# - Unit height in pixels: 8 
# - Display width in pixels: 256 
# - Display height in pixels: 256 
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestones have been reached in this submission?
# - Milestone 4
#
# Which approved features have been implemented for milestone 4?
# 1. Scoreboard. Scoreboard is shown at the gameover screen. 
# Score is based on number of flying obstacles launched (e.g., 16 obstacles = 16 points)
#
# 2. health and coins pickup. Health is red pixel granting you one health
# Coin pickup is a golden pixel granting 20 points per pick up. They appear per 
# twenty obstacles and health only appears if you are under five health bar.
#
# 3. Enemy ships. Every twenty or so obstacles a verticle obstacle appears (looks like the ship but in red)
#
# Link to video demonstration for final submission:
# - (insert YouTube / MyMedia / other URL here). Make sure we can view it!
#
# Are you OK with us sharing the video with people outside course staff?
# - yes
# - https://github.com/shethsh1/Space-dodge-ball (public after we are allowed)
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
.eqv gold 0xFFD700
.eqv red 0xFF0000
.eqv tomato 0xff6347

.data

    asteroid_1:			.word	0:5
    asteroid_1_counter:		.word   0
    asteroid_2:			.word	0:5
    asteroid_2_counter:		.word   0
    asteroid_3:			.word	0:5
    asteroid_3_counter:		.word   0
    enemy_ship:			.word	0:3
    enemy_ship_counter:		.word   0
    ship:			.word	0:3
    d_edge:			.word   116, 244, 372, 500, 628, 756, 884, 1012, 1140, 1268, 1396, 1524, 1652, 1780, 1908, 2036, 2164, 2292, 2420, 2548, 2676, 2804, 2932, 3060, 3188, 3316, 3444, 3572, 3700, 3828, 3956, 4084, -1
    w_edge:			.word	128, 132, 136, 140, 144, 148, 152, 156, 160, 164, 168, 172, 176, 180, 184, 188, 192, 196, 200, 204, 208, 212, 216, 220, 224, 228, 232, 236, 240, 244, 248, 252, -1
    s_edge:			.word	3584, 3588, 3592, 3596, 3600, 3604, 3608, 3612, 3616, 3620, 3624, 3628, 3632, 3636, 3640, 3644, 3648, 3652, 3656, 3660, 3664, 3668, 3672, 3676, 3680, 3684, 3688, 3692, 3696, 3700, 3704, 3708, -1
    a_edge:			.word	4, 132, 260, 388, 516, 644, 772, 900, 1028, 1156, 1284, 1412, 1540, 1668, 1796, 1924, 2052, 2180, 2308, 2436, 2564, 2692, 2820, 2948, 3076, 3204, 3332, 3460, 3588, 3716, 3844, 3972, -1
    total_collisions:		.word	0
    hearts:			.word	3928, 3936, 3944, 3952, 3960
    Alphabet_G:			.word 	524, 652, 780, 908, 912, 916, 920, 924, 796, 668, 664, 412, 408, 404, 400
    Alphabet_A:			.word   936, 808, 680, 552, 428, 432, 436, 568, 696, 824, 952, 812, 816, 820
    Alphabet_M:			.word	964, 836, 708, 580, 456, 460, 588, 716, 844, 972, 464, 596, 724, 852, 980
    Alphabet_E_1:		.word	992, 996, 1000, 1004, 1008, 864, 736, 740, 744, 748, 608, 480, 484, 488, 492, 496
    Alphabet_O:			.word	1420, 1548, 1676, 1808,1812,1816, 1692, 1564, 1436, 1304, 1300, 1296
    Alphabet_V:			.word	1448, 1320, 1576, 1708, 1840, 1716, 1592, 1464, 1336
    Alphabet_E_2:		.word	1348, 1352, 1356,1360,1364, 1476, 1604, 1608, 1612,1616, 1732, 1860, 1864,1868,1872,1876
    Alphabet_R:			.word	1888, 1760, 1632, 1504, 1376, 1380, 1384, 1388, 1520, 1648, 1644,1772, 1904, 1640, 1636
    obstacles_thrown:		.word	0
    number_zero:		.word	3364, 3240, 3112, 2984, 2852, 2976, 3104, 3232, 3360, 3368, 2856, 2848
    number_one:			.word	3360, 3364, 3368, 3236, 3108, 2980, 2852, 2848
    number_two:			.word	3360, 3364, 3368, 3232,3104,3108,3112,2984, 2856, 2852, 2848
    number_three:		.word	3360, 3364, 3368,3240,3112, 2984, 2856, 2852, 2848, 3108
    number_four:		.word 	3368, 3240, 3112, 2984, 2856, 3108, 3104, 2976, 2848
    number_five:		.word	3360, 3364, 3368, 3240, 3112, 3108, 3104, 2976, 2848, 2852, 2856
    number_six:			.word	3360, 3364, 3368, 3240,3112,3108,3104,3232, 2976, 2848, 2852, 2856
    number_seven:		.word 	3368, 3240, 3112,2984, 2856, 2852, 2848
    number_eight:		.word	3360, 3364, 3368, 3240,3112,3108,3104,3232, 2976, 2848, 2852, 2856, 2984
    number_nine:		.word	3368, 3240,3112,3108,3104, 2976, 2848, 2852, 2856, 2984
    s2:				.word	0
    s1:				.word	0
    s0:				.word	0
    coin_item:			.word	0
    coin_location:		.word	1168,3232, 24
    coin_spawn_counter:		.word	0
    heart_item:			.word	0
    heart_spawn_counter:	.word	0
    heart_location:		.word	3136, 3000, 1228
    
    intro_prompt:		.asciiz "To play the game use controls w, a, s, d to move and p to restart\n"
    border:			.asciiz  "-------------------------------------------------------------------\n"
    
.text

    li $t0, BASE_ADDRESS 	# $t0 stores the base address for display
    li $t1, 0xd3d3d3 		# $t1 stores the grey colour code
    li $t2, 0x000000 		# $t2 stores the black colour code
    li $t8, 0x0000FF		# $t8 stores the blue colour code
    li $t9, 0xFFFF00		# $t9 stores the yellow colour code
    
    li $v0, 4
    la $a0, border	# prints border
    syscall
    
    li $v0, 4
    la $a0, intro_prompt	# prints intro message
    syscall
    
    li $v0, 4
    la $a0, border	# prints border
    syscall

GAME_START:

    li $s5, 0			# resets enemy ship
    la $t3, heart_item		# resets heart item to 0
    sw $zero, 0($t3)
    la $t3, heart_spawn_counter	# reset heart spwan counter to 0
    sw $zero, 0($t3)
    la $t3, coin_spawn_counter	# resets coin spawn to 0
    sw $zero, 0($t3)
    la $t3, coin_item		# resets coin item value to 0
    sw $zero, 0($t3)
    la $t3, obstacles_thrown	# resets obstacle thrown to 0
    sw $zero, 0($t3)
    la $t3, s2			# resets s2 to 0 (MSD)
    sw $zero, 0($t3)
    la $t3, s1			# reset s1 to 0 
    sw $zero, 0($t3)
    la $t3, s0			# reset s0 to 0
    sw $zero, 0($t3)
    la $t3, total_collisions	# resets total collisions to 0
    sw $zero, 0($t3)
    la $t3, asteroid_1_counter	# resets asteroid 1 counter to 0
    sw $zero, 0($t3)
    la $t3, asteroid_2_counter	# resets asteroid 2 counter to 0
    sw $zero, 0($t3)
    la $t3, asteroid_3_counter	# resets asteroid 3 counter to 0
    sw $zero, 0($t3)
    la $t3, enemy_ship_counter	# resets enemy_ship counter to 0
    sw $zero, 0($t3)

    la $t3, ship 		# t3 = addr(ship) - resets ship to default location
    li $t4, 2700		# t4 = 2700 
    li $t5, 2568		# t5 = 2568
    li $t6, 2824		# t6 = 2824
    sw $t4, 0($t3)		# t3[0] = t4
    sw $t5, 4($t3)		# t3[1] = t5 
    sw $t6, 8($t3)		# t3[2]	= t6
    la $t3, ship		# $t3 = addr(ship)
    lw $t4, 0($t3)		# $t4 = $t3[0] 
    add $t5, $t0, $t4		# $t5 = addr($t0 + $t4)
    sw $t8, 0($t5)		# $t5[0] = $t8
    lw $t4, 4($t3)		# $t4 = $t3[1]
    add $t5, $t0, $t4		# $t5 = addr($t0 + $t4)
    sw $t9, 0($t5)		# $t9[0] = $t8
    lw $t4, 8($t3)		# $t4 = $t3[1]
    add $t5, $t0, $t4		# $t5 = addr($t0 + $t4)
    sw $t9, 0($t5)		# $t9[0] = $t8	

    li $a0 0xFF0000		# resets health bar back to 5
    la $t3, hearts		# t3 = addr(hearts)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t4, $t0		# t5 = addr(t4 + t0)
    sw $a0, 0($t5) 		# t5[0] = a0
    lw $t4, 4($t3)		# t4 = t3[1]
    add $t5, $t4, $t0		# t5 = t4 + t0
    sw $a0, 0($t5) 		# t5[0] = a0
    lw $t4, 8($t3)		# t4 = t3[2]
    add $t5, $t4, $t0		# t5 = t4 + t0
    sw $a0, 0($t5) 		# t5[0] = a0
    lw $t4, 12($t3)		# t4 = t3[2]
    add $t5, $t4, $t0		# t5 = t4 + t0
    sw $a0, 0($t5) 		# t5[0] = a0
    lw $t4, 16($t3)		# t4 = t3[4]
    add $t5, $t4, $t0		# t5 = t4 + t0
    sw $a0, 0($t5) 		# t5[0] = a0

WHILE_GAME:
    lw $t3, 0xffff0000			# record keystroke event
    beq $t3, 1, keypress_happened	# branch if $t3 = 1
    j keypress_finished			# since no key pres event branch

    keypress_happened:
        lw $t4, 0xffff0004		
        beq $t4, 0x61, respond_to_a	# responds to keypress a
        beq $t4, 0x73, respond_to_s	# responds to keypress s
        beq $t4, 0x64, respond_to_d	# responds to keypress d
        beq $t4, 0x77, respond_to_w	# responds to keypress w
        beq $t4, 0x70, respond_to_p	# responds to keypress p
        j keypress_finished		# once all key presses are finished

    respond_to_p:
        # set background to black
        li $t3, 0	# t3 = 0
        WHILE_ERASE:
            add $t5, $t0, $t3		# t5 = t0 + t3
            sw $t2, 0($t5)		# t5[0] = t2
            add $t3, $t3, 4		# t3 = t3 + 4
            beq $t3, 4100, GAME_START	# if t3 = 4100 jump to GAME_START
            j WHILE_ERASE		# jump back to WHILE_ERASE

    respond_to_d:

        la $t4, ship		# t4 = addr(ship)
        lw $t5, 0($t4)		# t5 = t4[0]
        la $t3, d_edge		# t3 = addr(d_edge)
        j TEST_D_EDGE		# jump to TEST_D_EDGE

        not_d_edge:
        la $t3, ship		# $t3 = addr(ship)

        # erases
        lw $t4, 0($t3)		# $t5 = ship[0]
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        sw $t2, 0($t5)		# erases ship[0] with black

        lw $t4, 4($t3)		# $t5 = ship[4]
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        sw $t2, 0($t5)		# erases ship[1] with black

        lw $t4, 8($t3)		# $t5 = ship[8]
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        sw $t2, 0($t5)		# erases ship[1] with black

        # adds it again by 4 paces 
        lw $t4, 0($t3)		# $t4 = ship[0]
        add $t4, $t4, 4		# $t4 = $t4 + 4
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)

        lw $t7, 0($t5)		# t7 = t5[0]
        sw $t4, 0($t3)		# t3[0] = t4
        move $a0, $t7		# a0 = t7
        sw $t8, 0($t5)		# t5[0] = blue

        lw $t4, 4($t3)		# $t4 = ship[0]
        add $t4, $t4, 4		# $t4 = $t4 + 4
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        lw $t7, 0($t5)		# t7 = t5[0]
        sw $t4, 4($t3)		# t3[4] = t4
        move $a1, $t7		# a1 = t7
        sw $t9, 0($t5)		# t5[0] = yellow

        lw $t4, 8($t3)		# t4 = t3[8]
        add $t4, $t4, 4		# $t4 = $t4 + 4
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        lw $t7, 0($t5)		# t7 = t5[0]
        sw $t4, 8($t3)		# t3[8] = t4
        move $a2, $t7		# a2 = t7
        sw $t9, 0($t5)		# adds yellow	

        beq $a0, $t1, D_MOVEMENT_COLLISION		# $a0 = grey, branch to obstacle collision
        beq $a1, $t1, D_MOVEMENT_COLLISION		# $a1 = grey, branch to obstacle collision
        beq $a2, $t1, D_MOVEMENT_COLLISION		# $a2 = grey, branch to obstacle collision
        li $t7, tomato					# t7 = tomato colour
        beq $a0, $t7, D_MOVEMENT_COLLISION_ENEMY_SHIP	# $a0 = tomato, branch to enemy ship collision
        beq $a1, $t7, D_MOVEMENT_COLLISION_ENEMY_SHIP   # $a1 = tomato, branch to enemy ship collision
        beq $a2, $t7, D_MOVEMENT_COLLISION_ENEMY_SHIP   # $a2 = tomato, branch to enemy ship collision
        li $t7, gold					# t7 = gold colour
        beq $a0, $t7, PICK_UP_COIN			# $a0 = gold, branch to coin pick up
        beq $a1, $t7, PICK_UP_COIN			# $a1 = gold, branch to coin pick up
        beq $a2, $t7, PICK_UP_COIN			# $a2 = gold, branch to coin pick up
        li $t7, red					# t7 = red colour
        beq $a0, $t7, PICK_UP_HEART			# $a0 = red, branch to heart pick up
        beq $a1, $t7, PICK_UP_HEART			# $a1 = red, branch to heart pick up
        beq $a2, $t7, PICK_UP_HEART			# $a2 = red, branch to heart pick up

        j keypress_finished				# jump to key press finished

    respond_to_a:

        la $t4, ship		# $t4 = addr(ship)						
        lw $t5, 8($t4)		# t5 = t4[8]
        la $t3, a_edge		# t3 = addr(a_edge)
        j TEST_A_EDGE		# jump to test a edge

        not_a_edge:		
        la $t3, ship		# $t3 = addr(ship)

        # erases
        lw $t4, 0($t3)		# $t5 = ship[0]
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        sw $t2, 0($t5)		# erases ship[0] with black

        lw $t4, 4($t3)		# $t5 = ship[4]
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        sw $t2, 0($t5)		# erases ship[1] with black

        lw $t4, 8($t3)		# $t5 = ship[8]
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        sw $t2, 0($t5)		# erases ship[1] with black

        # adds it again by 4 paces 
        lw $t4, 0($t3)		# $t4 = ship[0]
        add $t4, $t4, -4	# $t4 = $t4 - 4
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)

        lw $t7, 0($t5)		# t7 = t5[0]
        sw $t4, 0($t3)		# t3[0] = t4
        move $a0, $t7		# a0 = t7
        sw $t8, 0($t5)		# t5[0] = blue

        lw $t4, 4($t3)		# $t4 = ship[0]
        add $t4, $t4, -4	# $t4 = $t4 - 4
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        lw $t7, 0($t5)		# t7 = t5[0]
        sw $t4, 4($t3)		# t3[4] = t4
        move $a1, $t7		# a1 = t7
        sw $t9, 0($t5)		# t5[0] = yellow

        lw $t4, 8($t3)		# $t4 = ship[0]
        add $t4, $t4, -4	# $t4 = $t4 - 4
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        lw $t7, 0($t5)		# t7 = t5[0]
        sw $t4, 8($t3)		# t3[8] = t4
        move $a2, $t7		# a2 = t7
        sw $t9, 0($t5)		# t5[0] = yellow

        beq $a0, $t1, D_MOVEMENT_COLLISION		# if a0 = black, jump to obstacle collision 
        beq $a1, $t1, D_MOVEMENT_COLLISION		# if a1 = black, jump to obstacle collision 
        beq $a2, $t1, D_MOVEMENT_COLLISION		# if a2 = black, jump to obstacle collision 
        li $t7, tomato					# t7 = tomato colour
        beq $a0, $t7, D_MOVEMENT_COLLISION_ENEMY_SHIP	# if a0 = tomato, jump to enemy ship collision 
        beq $a1, $t7, D_MOVEMENT_COLLISION_ENEMY_SHIP	# if a1 = tomato, jump to enemy ship collision 
        beq $a2, $t7, D_MOVEMENT_COLLISION_ENEMY_SHIP	# if a2 = tomato, jump to enemy ship collision 
        li $t7, gold					# t7 = gold colour
        beq $a0, $t7, PICK_UP_COIN			# if a0 = gold, jump to pick up coin
        beq $a1, $t7, PICK_UP_COIN			# if a1 = gold, jump to pick up coin
        beq $a2, $t7, PICK_UP_COIN			# if a2 = gold, jump to pick up coin
        li $t7, red					# t7 = red colour
        beq $a0, $t7, PICK_UP_HEART			# if a0 = red, jump to pick up heart
        beq $a1, $t7, PICK_UP_HEART			# if a1 = red, jump to pick up heart
        beq $a2, $t7, PICK_UP_HEART			# if a2 = red, jump to pick up heart

        j keypress_finished				# jump to key press finished

    respond_to_s:
        la $t4, ship		# t4 = addr(ship)
        lw $t5, 8($t4)		# t5 = t4[8] 
        la $t3, s_edge		# t3 = addr(s_edge)
        j TEST_S_EDGE		# jump to test_s_edge

        not_s_edge:		
        
        la $t3, ship		# $t3 = addr(ship)

        # erases
        lw $t4, 0($t3)		# $t5 = ship[0]
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        sw $t2, 0($t5)		# t5[0] = black

        lw $t4, 4($t3)		# $t5 = ship[4]
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        sw $t2, 0($t5)		# t5[0] = black

        lw $t4, 8($t3)		# $t5 = ship[8]
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        sw $t2, 0($t5)		# t5[0] = black

        # adds it again by 4 paces 
        lw $t4, 0($t3)		# $t4 = ship[0]
        add $t4, $t4, 128	# $t4 = $t4 + 128
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        lw $t7, 0($t5)		# t7 = t5[0]
        sw $t4, 0($t3)		# t3[0] = t4
        move $a0, $t7		# a0 = t7
        sw $t8, 0($t5)		# t5[0] = blue

        lw $t4, 4($t3)		# $t4 = ship[4]
        add $t4, $t4, 128	# $t4 = $t4 + 128
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        lw $t7, 0($t5)		# t7 = t5[0]
        sw $t4, 4($t3)		# t3[4] = t4
        move $a1, $t7		# a1 = t7
        sw $t9, 0($t5)		# t5[0] = yellow

        lw $t4, 8($t3)		# $t4 = ship[8]
        add $t4, $t4, 128	# $t4 = $t4 + 128
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        lw $t7, 0($t5)		# t7 = t5[0]
        sw $t4, 8($t3)		# t3[8] = t4
        move $a2, $t7		# a2 = t7
        sw $t9, 0($t5)		# t5[0] = yellow

        beq $a0, $t1, D_MOVEMENT_COLLISION		# a0 = grey, jump to obstacle collision
        beq $a1, $t1, D_MOVEMENT_COLLISION		# a1 = grey, jump to obstacle collision
        beq $a2, $t1, D_MOVEMENT_COLLISION		# a2 = grey, jump to obstacle collision
        li $t7, tomato					# t7 = tomato colour
        beq $a0, $t7, D_MOVEMENT_COLLISION_ENEMY_SHIP	# a0 = tomato, jump to ship collision collision
        beq $a1, $t7, D_MOVEMENT_COLLISION_ENEMY_SHIP	# a1 = tomato, jump to ship collision collision
        beq $a2, $t7, D_MOVEMENT_COLLISION_ENEMY_SHIP	# a2 = tomato, jump to ship collision collision
        li $t7, gold					# t7 = gold
        beq $a0, $t7, PICK_UP_COIN			# a0 = gold, jump to pick up coin
        beq $a1, $t7, PICK_UP_COIN			# a1 = gold, jump to pick up coin
        beq $a2, $t7, PICK_UP_COIN			# a2 = gold, jump to pick up coin
        li $t7, red					# t7 = red
        beq $a0, $t7, PICK_UP_HEART			# a0 = red, jump to pick up heart
        beq $a1, $t7, PICK_UP_HEART			# a1 = red, jump to pick up heart
        beq $a2, $t7, PICK_UP_HEART			# a2 = red, jump to pick up heart

        j keypress_finished				# jump to keypress finished

    respond_to_w:
        la $t4, ship		# t4 = addr(ship)
        lw $t5, 4($t4)		# t5 = t4[4]
        la $t3, w_edge		# t3 = addr(w_edge)
        j TEST_W_EDGE		# jump to test w edge

        not_w_edge:
        la $t3, ship		# $t3 = addr(ship)

        # erases
        lw $t4, 0($t3)		# $t5 = ship[0]
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        sw $t2, 0($t5)		# erases ship[0] with black

        lw $t4, 4($t3)		# $t5 = ship[4]
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        sw $t2, 0($t5)		# erases ship[1] with black

        lw $t4, 8($t3)		# $t5 = ship[8]
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        sw $t2, 0($t5)		# erases ship[1] with black

        # adds it again by 4 paces 
        lw $t4, 0($t3)		# $t4 = ship[0]
        add $t4, $t4, -128	# $t4 = $t4 - 128
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        lw $t7, 0($t5)		# t7 = t5[0]
        sw $t4, 0($t3)		# t3[0] = t4
        move $a0, $t7		# a0 = t7
        sw $t8, 0($t5)		# t5[0] = t8

        lw $t4, 4($t3)		# $t4 = ship[4]
        add $t4, $t4, -128	# $t4 = $t4 - 128
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        lw $t7, 0($t5)		# t7 = t5[0]
        sw $t4, 4($t3)		# t3[4] = t4
        move $a1, $t7		# a1 = t7
        sw $t9, 0($t5)		# t5[0] = yellow

        lw $t4, 8($t3)		# $t4 = ship[8]
        add $t4, $t4, -128	# $t4 = $t4 - 128
        add $t5, $t4, $t0	# $t5 = addr(map + $t4)
        lw $t7, 0($t5)		# t7 = t5[0]
        sw $t4, 8($t3)		# t3[8] = t4
        move $a2, $t7		# a2 = t7
        sw $t9, 0($t5)		# t5[0] = yellow	

        beq $a0, $t1, D_MOVEMENT_COLLISION		# a0 = grey, jump to obstacle collision
        beq $a1, $t1, D_MOVEMENT_COLLISION		# a1 = grey, jump to obstacle collision
        beq $a2, $t1, D_MOVEMENT_COLLISION		# a2 = grey, jump to obstacle collision
        li $t7, tomato					# t7 = tomato
        beq $a0, $t7, D_MOVEMENT_COLLISION_ENEMY_SHIP	# a0 = tomato, jump to enemy ship collision
        beq $a1, $t7, D_MOVEMENT_COLLISION_ENEMY_SHIP	# a2 = tomato, jump to enemy ship collision
        beq $a2, $t7, D_MOVEMENT_COLLISION_ENEMY_SHIP	# a3 = tomato, jump to enemy ship collision
        li $t7, gold					# t7 = gold
        beq $a0, $t7, PICK_UP_COIN			# a0 = gold, jump to pick up coin
        beq $a1, $t7, PICK_UP_COIN			# a1 = gold, jump to pick up coin
        beq $a2, $t7, PICK_UP_COIN			# a2 = gold, jump to pick up coin
        li $t7, red					# t7 = red
        beq $a0, $t7, PICK_UP_HEART			# a0 = red, jump to pick up heart
        beq $a1, $t7, PICK_UP_HEART			# a1 = red, jump to pick up heart
        beq $a2, $t7, PICK_UP_HEART			# a2 = red, jump to pick up heart

        j keypress_finished				# jump to key press finished 

    keypress_finished:

        obstacles_falling:
            # asteroid 1
            la $t3, asteroid_1_counter	# $t3 = addr(counter)
            lw $t4, 0($t3)		# $t4 = $t3[0]
            beq $t4, 0, SET_ASTEROID_1	# t4 == 0, jump to set_asteroid_1

            # erase asteroid 1
            li $v0, 32			# sleep for 32 ms
            li $a0, obstacle_time
            syscall
            la $t4, asteroid_1		# $t4 = addr(asteroid_1)
            lw $t5, 0($t4)		# $t5 = $t4[0]
            add $t6, $t5, $t0		# $t6 = addr(default + $t5)
            sw $t2, 0($t6)		# $t6[0] = $t2 - black
            
            lw $t5, 4($t4)		# $t5 = $t4[1]
            add $t6, $t5, $t0		# $t6 = addr(default + $t5)
            sw $t2, 0($t6)		# $t6[0] = $t2 - black

            lw $t5, 8($t4)		# $t5 = $t4[2]
            add $t6, $t5, $t0		# $t6 = addr(default + $t5)
            sw $t2, 0($t6)		# $t6[0] = $t2 - black

            lw $t5, 12($t4)		# $t5 = $t4[2]
            add $t6, $t5, $t0		# $t6 = addr(default + $t5)
            sw $t2, 0($t6)		# $t6[0] = $t2 - black

            lw $t5, 16($t4)		# $t5 = $t4[1]
            add $t6, $t5, $t0		# $t6 = addr(default + $t5)
            sw $t2, 0($t6)		# $t6[0] = $t2 - black

            lw $t7, 0($t3)		# $t7 = addr(counter)
            beq $t7, 30, RESET_COUNTER	# if $t7 == 33, reset

            lw $t5, 0($t4)		# $t5 = asteroid[0]
            addi $t5, $t5, -4		# $t5 = $t5 - 4
            sw $t5, 0($t4)		# $t4[0] = $t5
            add $t6, $t5, $t0		# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# t7 = blue, jump to reset obstacle
            beq $t7, $t9, RESET_COUNTER_COLLISION	# t7 = yellow, jump to reset obstacle
            sw $t1, 0($t6)				# $t4[0] = $t1 - grey
            lw $t5, 4($t4)				# $t5 = asteroid[4]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 4($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# if t7 = t8, jump to reset counter collision
            beq $t7, $t9, RESET_COUNTER_COLLISION	# if t7 = t9, jump to reset counter collision
            sw $t1, 0($t6)				# $t6[0] = $t1 - grey
            lw $t5, 8($t4)				# $t5 = asteroid[8]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 8($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# if t7 = t8, jump to reset counter collision 
            beq $t7, $t9, RESET_COUNTER_COLLISION	# if t7 = t9, jump to reset counter collision 
            sw $t1, 0($t6)				# $t6[0] = $t1 - grey
            lw $t5, 12($t4)				# $t5 = asteroid[12]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 12($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# if t7 = t8, jump to reset counter collision
            beq $t7, $t9, RESET_COUNTER_COLLISION	# if t7 = t9, jump to reset counter collision
            sw $t1, 0($t6)				# $t6[0] = $t1 - grey
            lw $t5, 16($t4)				# $t5 = asteroid[16]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 16($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# if t7 = t8, jump to reset counter collision
            beq $t7, $t9, RESET_COUNTER_COLLISION	# if t7 = t9, jump to reset counter collision
            sw $t1, 0($t6)				# $t4[0] = $t1 - grey
            
            la $t3, asteroid_1_counter			# $t3 = addr(counter)
            lw $t4, 0($t3)				# $t4 = $t3[0]
            addi $t4, $t4, 1				# $t4 = $t4 + 1
            sw $t4, 0($t3)				# counter[0] = $t4

            # asteroid 2
            la $t3, asteroid_2_counter			# $t3 = addr(counter)
            lw $t4, 0($t3)				# $t4 = $t3[0]
            beq $t4, 0, SET_ASTEROID_2			# if t4 == 0, jump to set asteroid 2

            # erase asteroid 2
            li $v0, 32					# sleep for obstacle time
            li $a0, obstacle_time
            syscall
            la $t4, asteroid_2				# $t4 = addr(asteroid_1)
            lw $t5, 0($t4)				# $t5 = $t4[0]
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)
            sw $t2, 0($t6)				# $t6[0] = $t2 - black
            lw $t5, 4($t4)				# $t5 = $t4[1]
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)
            sw $t2, 0($t6)				# $t6[0] = $t2 - black

            lw $t5, 8($t4)				# $t5 = $t4[2]
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)
            sw $t2, 0($t6)				# $t6[0] = $t2 - black

            lw $t5, 12($t4)				# $t5 = $t4[2]
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)
            sw $t2, 0($t6)				# $t6[0] = $t2 - black

            lw $t5, 16($t4)				# $t5 = $t4[1]
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)
            sw $t2, 0($t6)				# $t6[0] = $t2 - black

            lw $t7, 0($t3)				# $t7 = addr(counter)
            beq $t7, 30, RESET_COUNTER			# if $t7 == 33, reset


            lw $t5, 0($t4)				# $t5 = asteroid[0]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 0($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# t7 = t8, jump to reset counter collision
            beq $t7, $t9, RESET_COUNTER_COLLISION	# t7 = t9, jump to reset counter collision
            sw $t1, 0($t6)				# $t4[0] = $t1 - grey

            lw $t5, 4($t4)				# $t5 = asteroid[4]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 4($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# t7 = t8, jump to reset counter collision
            beq $t7, $t9, RESET_COUNTER_COLLISION	# t7 = t9, jump to reset counter collision
            sw $t1, 0($t6)				# $t6[0] = $t1 - grey

            lw $t5, 8($t4)				# $t5 = asteroid[8]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 8($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# t7 = t8, jump to reset counter collision
            beq $t7, $t9, RESET_COUNTER_COLLISION	# t7 = t9, jump to reset counter collision
            sw $t1, 0($t6)				# $t6[0] = $t1 - grey

            lw $t5, 12($t4)				# $t5 = asteroid[12]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 12($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# t7 = t8, jump to reset counter collision
            beq $t7, $t9, RESET_COUNTER_COLLISION	# t7 = t9, jump to reset counter collision
            sw $t1, 0($t6)				# $t6[0] = $t1 - grey

            lw $t5, 16($t4)				# $t5 = asteroid[16]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 16($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# t7 = t8, jump to reset counter collision
            beq $t7, $t9, RESET_COUNTER_COLLISION	# t7 = t9, jump to reset counter collision
            sw $t1, 0($t6)				# $t6[0] = $t1 - grey

            la $t3, asteroid_2_counter			# $t3 = addr(counter)
            lw $t4, 0($t3)				# $t4 = $t3[0]
            addi $t4, $t4, 1				# $t4 = $t4 + 1
            sw $t4, 0($t3)				# counter[0] = $t4

            # asteroid 3
            la $t3, asteroid_3_counter			# $t3 = addr(counter)
            lw $t4, 0($t3)				# $t4 = $t3[0]
            beq $t4, 0, SET_ASTEROID_3			# if t4 == 0, jump to set asteroid 3

            # erase asteroid 3
            li $v0, 32					# sleep for obstacle time
            li $a0, obstacle_time
            syscall
            
            la $t4, asteroid_3				# $t4 = addr(asteroid_1)
            lw $t5, 0($t4)				# $t5 = $t4[0]
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            sw $t2, 0($t6)				# $t6[0] = $t2 - black
            lw $t5, 4($t4)				# $t5 = $t4[1]
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)
            sw $t2, 0($t6)				# $t6[0] = $t2 - black

            lw $t5, 8($t4)				# $t5 = $t4[2]
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)
            sw $t2, 0($t6)				# $t6[0] = $t2 - black

            lw $t5, 12($t4)				# $t5 = $t4[3]
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)
            sw $t2, 0($t6)				# $t6[0] = $t2 - black

            lw $t5, 16($t4)				# $t5 = $t4[1]
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)
            sw $t2, 0($t6)				# $t6[0] = $t2 - black

            lw $t7, 0($t3)				# $t7 = addr(counter)
            beq $t7, 30, RESET_COUNTER			# if $t7 == 33, reset

            lw $t5, 0($t4)				# $t5 = asteroid[0]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 0($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# t7 = t8, jump to reset counter collision
            beq $t7, $t9, RESET_COUNTER_COLLISION	# t7 = t9, jump to reset counter collision
            sw $t1, 0($t6)				# $t6[0] = $t1 - grey

            lw $t5, 4($t4)				# $t5 = asteroid[4]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 4($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# t7 = t8, jump to reset counter collision
            beq $t7, $t9, RESET_COUNTER_COLLISION	# t7 = t9, jump to reset counter collision
            sw $t1, 0($t6)				# $t60] = $t1 - grey

            lw $t5, 8($t4)				# $t5 = asteroid[8]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 8($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# t7 = t8, jump to reset counter collision
            beq $t7, $t9, RESET_COUNTER_COLLISION	# t7 = t9, jump to reset counter collision
            sw $t1, 0($t6)				# $t60] = $t1 - grey

            lw $t5, 12($t4)				# $t5 = asteroid[12]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 12($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# t7 = t8, jump to reset counter collision
            beq $t7, $t9, RESET_COUNTER_COLLISION	# t7 = t9, jump to reset counter collision
            sw $t1, 0($t6)				# $t6[0] = $t1 - grey

            lw $t5, 16($t4)				# $t5 = asteroid[16]
            addi $t5, $t5, -4				# $t5 = $t5 - 4
            sw $t5, 16($t4)				# $t4[0] = $t5
            add $t6, $t5, $t0				# $t6 = addr(default + $t5)

            lw $t7, 0($t6)				# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION	# t7 = t8, jump to reset counter collision
            beq $t7, $t9, RESET_COUNTER_COLLISION	# t7 = t8, jump to reset counter collision
            sw $t1, 0($t6)				# $t6[0] = $t1 - grey

            la $t3, asteroid_3_counter			# $t3 = addr(counter)
            lw $t4, 0($t3)				# $t4 = $t3[0]
            addi $t4, $t4, 1				# $t4 = $t4 + 1
            sw $t4, 0($t3)				# counter[0] = $t4	

            # enemy_ship
            blt $s5, 15, DROPS				# if s5 < 15, jump to drops
            la $t3, enemy_ship_counter			# t3 = addr(enemy_ship_counter)
            lw $t4, 0($t3)				# t4 = t3[0]
            beq $t4, 0 SET_ENEMY_SHIP			# if t4 == 0, set enemy ship 

            li $v0, 32					# sleep for obstacle time
            li $a0, obstacle_time
            syscall	

            # erase
            li $s0, tomato
            la $t4, enemy_ship					# $t4 = addr(enemyship)
            lw $t5, 0($t4)					# $t5 = $t4[0]
            add $t6, $t5, $t0					# $t6 = addr(default + $t5)
            sw $t2, 0($t6)					# $t6[0] = $t2 - black

            lw $t5, 4($t4)					# $t5 = $t4[1]
            add $t6, $t5, $t0					# $t6 = addr(default + $t5)
            sw $t2, 0($t6)					# $t6[0] = $t2 - black
            
            lw $t5, 8($t4)					# $t5 = $t4[2]
            add $t6, $t5, $t0					# $t6 = addr(default + $t5)
            sw $t2, 0($t6)					# $t6[0] = $t2 - black

            lw $t7, 0($t3)					# $t7 = addr(counter)
            beq $t7, 30, RESET_COUNTER_ENEMY_SHIP		# if $t7 == 30, reset

            lw $t5, 0($t4)					# $t5 = asteroid[0]
            addi $t5, $t5, -128					# $t5 = $t5 - 128
            sw $t5, 0($t4)					# $t4[0] = $t5
            add $t6, $t5, $t0					# $t6 = addr(default + $t5)

            lw $t7, 0($t6)					# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION_ENEMY_SHIP	# if t7 = t8, jump to reset collision counter
            beq $t7, $t9, RESET_COUNTER_COLLISION_ENEMY_SHIP	# if t7 = t9, jump to reset collision counter
            sw $s0, 0($t6)					# $t6[0] = $t1 - grey

            lw $t5, 4($t4)					# $t5 = ship[4]
            addi $t5, $t5, -128					# $t5 = $t5 - 128
            sw $t5, 4($t4)					# $t4[0] = $t5
            add $t6, $t5, $t0					# $t6 = addr(default + $t5)

            lw $t7, 0($t6)					# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION_ENEMY_SHIP	# if t7 = t8, jump to reset collision counter
            beq $t7, $t9, RESET_COUNTER_COLLISION_ENEMY_SHIP	# if t7 = t9, jump to reset collision counter
            sw $s0, 0($t6)					# $t6[0] = $t1 - grey

            lw $t5, 8($t4)					# $t5 = ship[8]
            addi $t5, $t5, -128					# $t5 = $t5 - 128
            sw $t5, 8($t4)					# $t4[0] = $t5
            add $t6, $t5, $t0					# $t6 = addr(default + $t5)

            lw $t7, 0($t6)					# t7 = t6[0]
            beq $t7, $t8, RESET_COUNTER_COLLISION_ENEMY_SHIP	# if t7 = t8, jump to reset collision counter
            beq $t7, $t9, RESET_COUNTER_COLLISION_ENEMY_SHIP	# if t7 = t9, jump to reset collision counter
            sw $s0, 0($t6)					# $t6[0] = $t1 - grey

            la $t3, enemy_ship_counter				# $t3 = addr(counter)
            lw $t4, 0($t3)					# $t4 = $t3[0]
            addi $t4, $t4, 1					# $t4 = $t4 + 1
            sw $t4, 0($t3)					# counter[0] = $t4		

        DROPS:
       		la $t3, heart_item		# t3 = addr(heart_item)
       	 	lw $t4, 0($t3)			# t4 = t3[0]
        	beq $t4, 0, COIN_RESPAWN	# if t4 = 0, respawn coin
        	li $t7, red			# t7 = red
        	add $t4, $t4, $t0		# t4 = t4 + t0
        	sw $t7, 0($t4)			# t4[0] = t7

        COIN_RESPAWN:
        	la $t3, coin_item		# t3 = addr(coin_item)
       	 	lw $t4, 0($t3)			# t4 = t3[0]
        	beq $t4, 0, WHILE_GAME		# if t4 = 0, jump to while_game
        	li $t7, 0xFFD700		# t7 = gold
        	add $t4, $t4, $t0		# t4 = t4 + t0
       	 	sw $t7, 0($t4)			# t4[0] = t7

        j WHILE_GAME				# start main loop again

RESET_COUNTER_COLLISION_ENEMY_SHIP:
    li $a0, 0			# a0 = 0
    sw $a0, 0($t3)		# t3[0] = a0

    # erase enemy_ship
    lw $t5, 0($t4)		# $t5 = $t4[0]
    add $t6, $t5, $t0		# $t6 = addr(default + $t5)
    sw $t2, 0($t6)		# $t6[0] = $t2 - black
    lw $t5, 4($t4)		# $t5 = $t4[1]
    add $t6, $t5, $t0		# $t6 = addr(default + $t5)
    sw $t2, 0($t6)		# $t6[0] = $t2 - black
    lw $t5, 8($t4)		# $t5 = $t4[2]
    add $t6, $t5, $t0		# $t6 = addr(default + $t5)
    sw $t2, 0($t6)		# $t6[0] = $t2 - black
    li $s5, 0			# resets enemy ship

    li $t6, 0xFF2D00		# t6 = red
    la $t3, ship		# t3 = addr(ship)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6
    lw $t4, 4($t3)		# t4 = t3[4]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6
    lw $t4, 8($t3)		# t4 = t3[8]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6

    li $v0, 32			# sleep for 100 ms
    li $a0, 100
    syscall

    la $t3, ship		# t3 = addr(ship)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t8, 0($t5)		# t5[0] = t8
    lw $t4, 4($t3)		# t4 = t3[4]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t9, 0($t5)		# t5[0] = t9
    lw $t4, 8($t3)		# t4 = t3[8]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t9, 0($t5)		# t9 = t5[0]

    la $t3, total_collisions	# t3 = addr(total_collisions)
    lw $t4, 0($t3)		# t4 = t3[0]
    addi $t4, $t4, 1		# t4 = t4 + 1
    sw $t4, 0($t3)		# t3[0] = t4
    beq $t4, 5, END		# if t4 == 5, jump to end

    # check if 5 is reached  
    la $t6, hearts		# t6 = addr(hearts)
    addi $t4, $t4, -1		# t4 = t4 - 1
    sll $t4, $t4, 2		# t4 = t4 x 4
    add $t4, $t4, $t6		# t4 = t4 + t6
    lw $t7, 0($t4)		# t7 = t4[0]
    add $t7, $t0, $t7		# t7 = t0 + t7
    sw $t2, 0($t7)		# t7[0] = t2

    j WHILE_GAME		# jump back to main loop

SET_ENEMY_SHIP:
    li $v0, 42			# syscall for random number generation
    li $a0, 0			# a0 contains the random number from 0 to 14
    li $a1, 14
    syscall
    
    li $t3,  3744		# t3 = 3744
    li $t5, tomato		# t5 = tomato colour
    sll $a0, $a0, 2		# a0 = a0 x 4
    add $a0, $a0, $t3		# a0 = a0 + t3

    la $t3, enemy_ship		# $t3 = addr(enemy_ship)
    sw $a0, 0($t3)		# t3[0] = a0
    add $t4, $a0, $t0		# t4 = a0 + t0
    sw $t5, 0($t4)		# t4[0] = t5

    add $a0, $a0, 8		# a0 = a0 + 8
    sw $a0, 4($t3)		# t3[4] = a0 
    add $t4, $a0, $t0		# t4 = a0 + t0
    sw $t5, 0($t4)		# t4[0] = t5

    add $a0, $a0, -132		# a0 = a0 - 132
    sw $a0, 8($t3)		# t3[8] = a0
    add $t4, $a0, $t0		# t4 = a0 + t0
    sw $t5, 0($t4)		# t4[0] = t5

    la $t3, enemy_ship_counter	# $t3 = addr(counter)
    li $t4, 1			# $t4 = 1
    sw $t4, 0($t3)		# $t3[0] = 1 

    j WHILE_GAME		# jump back to main loop

D_MOVEMENT_COLLISION_ENEMY_SHIP:
    # first check asteroid_1
    la $t3, enemy_ship			# $t3 = addr(enemy_ship)
    la $s0, ship			# s0 = addr(ship)
    
    # first
    lw $s1, 0($s0)
    lw $t4, 0($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ENEMY_SHIP	# if its equal

    lw $t4, 4($t3)			# $t4 = $t3[4]
    beq $s1, $t4, ERASE_ENEMY_SHIP	# if its equal

    lw $t4, 8($t3)			# $t4 = $t3[8]
    beq $s1, $t4, ERASE_ENEMY_SHIP	# if its equal
    
    # second
    lw $s1, 4($s0)
    lw $t4, 0($t3)			# $t4 = $t3[4]
    beq $s1, $t4, ERASE_ENEMY_SHIP	# if its equal

    lw $t4, 4($t3)			# $t4 = $t3[4]
    beq $s1, $t4, ERASE_ENEMY_SHIP	# if its equal

    lw $t4, 8($t3)			# $t4 = $t3[8]
    beq $s1, $t4, ERASE_ENEMY_SHIP	# if its equal

    # third
    lw $s1, 8($s0)
    lw $t4, 0($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ENEMY_SHIP	# if its equal

    lw $t4, 4($t3)			# $t4 = $t3[4]
    beq $s1, $t4, ERASE_ENEMY_SHIP	# if its equal

    lw $t4, 8($t3)			# $t4 = $t3[8]
    beq $s1, $t4, ERASE_ENEMY_SHIP	# if its equal

ERASE_ENEMY_SHIP:
    li $s5, 0			# resets enemy ship
    lw $t4, 0($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 4($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 8($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    la $t4, enemy_ship_counter	# t4 = addr(enemy_ship_counter)
    li $t5, 0			# t5 = 0
    sw $t5, 0($t4)		# t4[0] = t5

    # make ship go red
    li $t6, 0xFF2D00		# t6 = red
    la $t3, ship		# t3 = addr(ship)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6
    lw $t4, 4($t3)		# t4 = t3[4]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6
    lw $t4, 8($t3)		# t4 = t3[8]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6

    li $v0, 32			# sleep for 100 ms
    li $a0, 100
    syscall

    la $t3, ship		# t3 = addr(ship)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t8, 0($t5)		# t5[0] = t8
    lw $t4, 4($t3)		# t4 = t3[4]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t9, 0($t5)		# t5[0] = t9
    lw $t4, 8($t3)		# t4 = t3[8]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t9, 0($t5)		# t5[0] = t9

    la $t3, total_collisions	# t3 = addr(total_collisions)
    lw $t4, 0($t3)		# t4 = t3[0]
    addi $t4, $t4, 1		# t4 = t4 + 1
    sw $t4, 0($t3)		# t3[0] = t4
    beq $t4, 5, END		# if t4 == 5, jump to END

    # check if 5 is reached  
    la $t6, hearts		# t6 = addr(hearts)
    addi $t4, $t4, -1		# t4 = t4 - 1
    sll $t4, $t4, 2		# t4 = t4 x 4
    add $t4, $t4, $t6		# t4 = t4 + t6
    lw $t7, 0($t4)		# t7 = t4[0]
    add $t7, $t0, $t7		# t7 = t0 + t7
    sw $t2, 0($t7)		# t7[0] = t2

    j WHILE_GAME		# jump back to main loop

RESET_COUNTER_COLLISION:
    li $a0, 0			# a0 = 0
    sw $a0, 0($t3)		# t3[0] = a0

    # erase asteroid 1
    lw $t5, 0($t4)		# $t5 = $t4[0]
    add $t6, $t5, $t0		# $t6 = addr(default + $t5)
    sw $t2, 0($t6)		# $t6[0] = $t2 - black

    lw $t5, 4($t4)		# $t5 = $t4[1]
    add $t6, $t5, $t0		# $t6 = addr(default + $t5)
    sw $t2, 0($t6)		# $t6[0] = $t2 - black

    lw $t5, 8($t4)		# $t5 = $t4[2]
    add $t6, $t5, $t0		# $t6 = addr(default + $t5)
    sw $t2, 0($t6)		# $t6[0] = $t2 - black

    lw $t5, 12($t4)		# $t5 = $t4[2]
    add $t6, $t5, $t0		# $t6 = addr(default + $t5)
    sw $t2, 0($t6)		# $t6[0] = $t2 - black

    lw $t5, 16($t4)		# $t5 = $t4[1]
    add $t6, $t5, $t0		# $t6 = addr(default + $t5)
    sw $t2, 0($t6)		# $t6[0] = $t2 - black

    li $t6, 0xFF2D00		# t6 = red
    la $t3, ship		# t3 = addr(ship)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6
    lw $t4, 4($t3)		# t4 = t3[4]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6
    lw $t4, 8($t3)		# t4 = t3[8]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6

    li $v0, 32			# sleep for 100 ms
    li $a0, 100
    syscall

    la $t3, ship		# t3 = addr(ship)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t8, 0($t5)		# t5[0] = t8
    lw $t4, 4($t3)		# t4 = t3[4]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t9, 0($t5)		# t5[0] = t9
    lw $t4, 8($t3)		# t4 = t3[8]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t9, 0($t5)		# t5[0] = t9

    la $t3, total_collisions	# t3 = addr(total_collisions)
    lw $t4, 0($t3)		# t4 = t3[0]
    addi $t4, $t4, 1		# t4 = t4 + 1
    sw $t4, 0($t3)		# t3[0] = t4
    beq $t4, 5, END		# if t4 == 5, jump to end

    # check if 5 is reached  
    la $t6, hearts		# t6 = addr(hearts)
    addi $t4, $t4, -1		# t4 = t4 - 1
    sll $t4, $t4, 2		# t4 = t4 x 4
    add $t4, $t4, $t6		# t4 = t4 + t6
    lw $t7, 0($t4)		# t7 = t4[0]
    add $t7, $t0, $t7		# t7 = t0 + t7
    sw $t2, 0($t7) 		# t7[0] = t2

    j WHILE_GAME		# rerun the main loop

RESET_COUNTER_ENEMY_SHIP:
    li $t4, 0				# t4 = 0
    sw $t4, 0($t3)			# t3[0] = t4
    li $s5, 0				# s5 = 0
    j WHILE_GAME			# rerun the main loop

RESET_COUNTER:
    li $t4, 0				# t4 = 0
    sw $t4, 0($t3)			# t3[0] = t4
    j WHILE_GAME			# rerun the main loop

REMOVE_COIN:
    sw $t2, 0($t5)			# t5[0] = t2
    j SPAWN_COIN			# rerun the main loop

SPAWN_COIN:
    la $t3, coin_spawn_counter		# t3 = addr(coin_spawn_counter)
    sw $zero, 0($t3)			# t3[0] = 0
    la $t3, coin_item			# t3 = addr(coin_item)
    lw $t4, 0($t3)			# t4 = t3[0]
    add $t5, $t0, $t4			# t5 = t0 + t4
    lw $t6, 0($t5)			# t6 = t5[0]
    li $t7, 0xFFD700			# t7 = gold
    beq $t7, $t6, REMOVE_COIN		# if t7 = t6, jump to remove coin

    li $v0, 42				# random number generator from 0 to 2
    li $a0, 0				# a0 contains the random number from 0 to 32
    li $a1, 2
    syscall

    sll $a0, $a0, 2			# a0 = a0 x 4
    la $t4, coin_location		# t4 = addr(coin_location)
    add $t5, $t4, $a0			# t5 = t4 + a0
    lw $t4, 0($t5)			# t4 = t5[0]
    la $t3, coin_item			# t3 = addr(coin_item)
    sw $t4, 0($t3)			# t3[0] = t4

    j WHILE_GAME			# rerun the main loop

SET_ASTEROID_1:
    addi $s5, $s5, 1			# s5 = s5 + 1
    # asteroid 1
    li $v0, 42				# random number generator
    li $a0, 0				# a0 contains the random number from 0 to 13
    li $a1, 13
    syscall
    addi $a0, $a0, 1			# a0 = a0 + 1
    li $t3, 2				# t3 = 2
    mult $a0, $t3			# a0 = a0 x 2
    mflo $a0				
    li $t3, 128
    mult $a0, $t3			# a0 = $a0 x 128
    mflo $a0
    addi $a0, $a0, 124			# a0 = a0 + 124

    la $t3, asteroid_1			# $t3 = addr(asteroid_1)
    sw $a0, 0($t3)			# $t3[0] = $a0
    add $t4, $t0, $a0 			# $t4 = addr($t0+$a0) - right wing
    addi $t7, $a0, -4			# t7 = a0 - 4
    sw $t7, 4($t3)			# t3[4] = t7
    addi $t7, $a0, -132			# t7 = a0 - 132
    sw $t7, 8($t3)			# t3[8] = t7
    addi $t7, $a0, 124			# t7 = a0 + 124
    sw $t7, 12($t3)			# t3[12] = t7
    addi $t7, $a0, -8			# t7 = a0 - 8
    
    sw $t7, 16($t3)			# t3[16] = t7
    sw $t1, 0($t4)			# $t4[0] = $t1 - grey
    addi $t5, $t4, -4			# $t5 = addr($t4-4) - center

    sw $t1, 0($t5)			# $t5[0] = $t1 - grey
    addi $t5, $t4, -132			# $t4 = addr($t0-4) - top

    sw $t1, 0($t5)			# $t4[0] = $t1 - grey
    addi $t5, $t4, 124			# $t4 = addr($t0-4) - bottom

    sw $t1, 0($t5)			# $t4[0] = $t1 - grey
    addi $t5, $t4, -8			# $t4 = addr($t0-4) - left

    sw $t1, 0($t5)			# $t4[0] = $t1 - grey

    la $t3, asteroid_1_counter		# $t3 = addr(counter)
    li $t4, 1				# $t4 = 1
    sw $t4, 0($t3)			# $t3[0] = 1 

    la $t3, obstacles_thrown		# t3 = addr(obstacles_thrown)
    lw $t4, 0($t3)			# t4 = t3[0]
    beq $t4, 999, WHILE_GAME 		# if $t4 = 999 jump back to main loop
    addi $t4, $t4, 1			# t4 = t4 + 1
    sw $t4, 0($t3)			# t3[0] = t4

    la $t3, total_collisions		# t3 = addr(total_collisions)
    lw $t4, 0($t3)			# t4 = t3[0]

    bne $t4, 0, HEART_DROP_CHECK	# if $t4 != 0, jump to heart_drop_check

    COIN_DROP_CHECK:

        la $t3, coin_spawn_counter	# t3 = addr(coin_spawn_counter)
        lw $t4, 0($t3)			# t4 = t3[0]
        beq $t4, 20, SPAWN_COIN		# if t4 == 20, jump to spawn coin
        addi $t4, $t4, 1		# t4 = t4 + 1
        sw $t4, 0($t3)			# t3[0] = t4

        j WHILE_GAME			# jump back to main loop

HEART_DROP_CHECK:
    la $t3, heart_spawn_counter		# $t3 = addr(counter)
    lw $t4, 0($t3)			# $t4 = counter[0]
    beq $t4, 20, HEART_SPAWN		# if $t4 == 5, jump to spawn heart
    addi $t4, $t4, 1			# else, increment t4 by 1
    sw $t4, 0($t3)			# $t3[0] = $t4

    j COIN_DROP_CHECK			# jump to coin drop check

REMOVE_HEART:
    sw $t2, 0($t5)			# t5[0] = t2
    j HEART_SPAWN			# jump to heart spawn
    
HEART_SPAWN:
    la $t3, heart_spawn_counter		# t3 = addr(heart_spawn_counter)
    sw $zero, 0($t3)			# t3[0] = zero
    la $t3, heart_item			# $t3 = addr(heart_item)
    lw $t4, 0($t3)			# $t4 = $t3[0]
    add $t5, $t0, $t4			# $t5 = $t0 + $t4
    lw $t6, 0($t5)			# $t6 = $t0[i]
    li $t7, red				# t7 = red
    beq $t7, $t6, REMOVE_HEART		# if t7 == t6, jump to remove heart

    li $v0, 42				# random number syscall
    li $a0, 0				# a0 contains the random number from 0 to 32
    li $a1, 3
    syscall

    sll $a0, $a0, 2			# a0 = a0 x 4
    la $t4, heart_location		# t4 = addr(heart_location)
    add $t5, $t4, $a0			# t5 = t4 + a0
    lw $t4, 0($t5)			# t4 = t5[0]

    la $t3, heart_item			# t3 = addr(heart_item)
    sw $t4, 0($t3)			# t3[0] = t4

    j COIN_DROP_CHECK			# jump to coin drop check

SET_ASTEROID_2:

    addi $s5, $s5, 1			# s5 = s5 + 1
    # asteroid 2
    li $v0, 42				# random number generator syscall
    li $a0, 0				# a0 contains the random number from 0 to 32
    li $a1, 13
    syscall
    
    addi $a0, $a0, 1			# a0 = a0 + 1
    li $t3, 2				# t3 = 2
    mult $a0, $t3			# a0 = a0 x 2
    mflo $a0				
    li $t3, 128				# t3 = 128
    mult $a0, $t3			# a0 = $a0 x 128
    mflo $a0
    addi $a0, $a0, 124			# a0 = a0 + 124

    la $t3, asteroid_2			# $t3 = addr(asteroid_1)
    sw $a0, 0($t3)			# $t3[0] = $a0
    add $t4, $t0, $a0 			# $t4 = addr($t0+$a0) - right wing
    addi $t7, $a0, -4			# t7 = a0 - 4
    sw $t7, 4($t3)			# t3[4] = t7
    addi $t7, $a0, -132			# t7 = a0 - 132
    sw $t7, 8($t3)			# t3[8] = t7
    addi $t7, $a0, 124			# t7 = a0 + 124
    sw $t7, 12($t3)			# t3[12] = t7
    addi $t7, $a0, -8			# t7 = a0 - 8
    sw $t7, 16($t3)			# t3[16] = t7
    sw $t1, 0($t4)			# $t4[0] = $t1 - grey

    addi $t5, $t4, -4			# $t5 = addr($t4-4) - center
    sw $t1, 0($t5)			# $t5[0] = $t1 - grey
    addi $t5, $t4, -132			# $t4 = addr($t0-4) - top

    sw $t1, 0($t5)			# $t4[0] = $t1 - grey
    addi $t5, $t4, 124			# $t4 = addr($t0-4) - bottom

    sw $t1, 0($t5)			# $t4[0] = $t1 - grey
    addi $t5, $t4, -8			# $t4 = addr($t0-4) - left
    sw $t1, 0($t5)			# $t4[0] = $t1 - grey

    la $t3, asteroid_2_counter		# $t3 = addr(counter)
    li $t4, 1				# $t4 = 1
    sw $t4, 0($t3)			# $t3[0] = 1 

    la $t3, obstacles_thrown		# t3 = addr(obstacles_thrown)
    lw $t4, 0($t3)			# t4 = t3[0]
    beq $t4, 999, WHILE_GAME 		# if $t4 = 999, jump to main loop
    addi $t4, $t4, 1			# t4 = t4 + 1
    sw $t4, 0($t3)			# t3[0] = t4

    la $t3, total_collisions		# t3 = addr(total_collisions)
    lw $t4, 0($t3)			# t4 = t3[0]

    bne $t4, 0, HEART_DROP_CHECK	# $t4 != 0
    j COIN_DROP_CHECK			# jump to coin drop check

SET_ASTEROID_3:
    addi $s5, $s5, 1			# s5 = s5 + 1

    # asteroid 3
    li $v0, 42				# random number generator syscall
    li $a0, 0				# a0 contains the random number from 0 to 32
    li $a1, 13
    syscall
    addi $a0, $a0, 1			# a0 = a0 + 1
    li $t3, 2				# t3 = 2
    mult $a0, $t3			# a0 = a0 x 2
    mflo $a0
    li $t3, 128				# t3 = 128
    mult $a0, $t3			# $a0 x 128 + 124
    mflo $a0
    addi $a0, $a0, 124			# a0 = a0 + 124	

    la $t3, asteroid_3			# $t3 = addr(asteroid_1)
    sw $a0, 0($t3)			# $t3[0] = $a0
    add $t4, $t0, $a0 			# $t4 = addr($t0+$a0) - right wing
    addi $t7, $a0, -4			# t7 = a0 - 4
    sw $t7, 4($t3)			# t3[4] = t7
    addi $t7, $a0, -132			# t7 = a0 - 132
    sw $t7, 8($t3)			# t3[8] = t7
    addi $t7, $a0, 124			# t7 = a0 + 124
    sw $t7, 12($t3)			# t3[12] = t7
    addi $t7, $a0, -8			# t7 = a0 - 8
    sw $t7, 16($t3)			# t3[16] = t7
    sw $t1, 0($t4)			# $t4[0] = $t1 - grey
    addi $t5, $t4, -4			# $t5 = addr($t4-4) - center
    sw $t1, 0($t5)			# $t5[0] = $t1 - grey
    addi $t5, $t4, -132			# $t4 = addr($t0-4) - top
    sw $t1, 0($t5)			# $t4[0] = $t1 - grey
    addi $t5, $t4, 124			# $t4 = addr($t0-4) - bottom
    sw $t1, 0($t5)			# $t4[0] = $t1 - grey
    addi $t5, $t4, -8			# $t4 = addr($t0-4) - left
    sw $t1, 0($t5)			# $t4[0] = $t1 - grey
    
    la $t3, asteroid_3_counter		# $t3 = addr(counter)
    li $t4, 1				# $t4 = 1
    sw $t4, 0($t3)			# $t3[0] = 1 

    la $t3, obstacles_thrown		# t3 = addr(obstacles_thrown)
    lw $t4, 0($t3)			# t3[0] = t4
    beq $t4, 999, WHILE_GAME 		# $t4 = 999
    addi $t4, $t4, 1			# t4 = t4 + 1
    sw $t4, 0($t3)			# t3[0] = t4

    la $t3, total_collisions		# t3 = addr(total_collision)
    lw $t4, 0($t3)			# t4 = t3[0] 

    bne $t4, 0, HEART_DROP_CHECK	# if $t4 != 0 jump to heart drop check
    j COIN_DROP_CHECK			# jump to coin drop check

TEST_D_EDGE:
    lw $t6, 0($t3)			# $t6 = $t3[0]
    beq $t5, $t6, keypress_finished	# if t5 = t6, jump to keypress finished
    blt $t5, $t6, not_d_edge  		# if t5 < t6, jump to not d edge
    beq $t6, -1, not_d_edge		# if t5 = -1, jump to not d edge
    addi $t3, $t3, 4			# t3 = t3 + 4
    j TEST_D_EDGE			# jump to test d edge

TEST_W_EDGE:
    lw $t6, 0($t3)			# $t6 = $t3[0]
    beq $t5, $t6, keypress_finished	# if t5 = t6, jump to keypress finished
    blt $t5, $t6, not_w_edge  		# if t5 < t6, jump to not w edge
    beq $t6, -1, not_w_edge		# if t5 = -1, jump to not w edge
    addi $t3, $t3, 4			# t3 = t3 + 4
    j TEST_W_EDGE			# jump to test W edge

TEST_S_EDGE:
    lw $t6, 0($t3)			# $t6 = $t3[0]
    beq $t5, $t6, keypress_finished	# if t5 = t6, jump to keypress finished
    blt $t5, $t6, not_s_edge  		# if t5 < t6, jump to not s edge
    beq $t6, -1, not_s_edge		# if t5 = -1, jump to not s edge
    addi $t3, $t3, 4			# t3 = t3 + 4
    j TEST_S_EDGE			# jump to test W edge

TEST_A_EDGE:
    lw $t6, 0($t3)			# $t6 = $t3[0]
    beq $t5, $t6, keypress_finished	# if t5 = t6, jump to keypress finished
    blt $t5, $t6, not_a_edge  		# if t5 < t6, jump to not a edge
    beq $t6, -1, not_a_edge		# if t5 = -1, jump to not a edge
    addi $t3, $t3, 4			# t3 = t3 + 4
    j TEST_A_EDGE			# jump to test A edge

D_MOVEMENT_COLLISION:
    # first check asteroid_1
    la $t3, asteroid_1			# $t3 = addr(asteroid_1)
    la $s0, ship			# s0 = addr(ship)
    # first
    lw $s1, 0($s0)
    lw $t4, 0($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    lw $t4, 4($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    lw $t4, 8($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    lw $t4, 12($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    lw $t4, 16($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    # second
    lw $s1, 4($s0)
    lw $t4, 0($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    lw $t4, 4($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    lw $t4, 8($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    lw $t4, 12($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    lw $t4, 16($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    # third
    lw $s1, 8($s0)
    lw $t4, 0($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    lw $t4, 4($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    lw $t4, 8($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    lw $t4, 12($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal
    lw $t4, 16($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_1	# if its equal

    # check asteroid_2
    la $t3, asteroid_2			# $t3 = addr(asteroid_2)
    la $s0, ship
    # first
    lw $s1, 0($s0)
    lw $t4, 0($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    lw $t4, 4($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    lw $t4, 8($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    lw $t4, 12($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    lw $t4, 16($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    # second
    lw $s1, 4($s0)
    lw $t4, 0($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    lw $t4, 4($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    lw $t4, 8($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    lw $t4, 12($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    lw $t4, 16($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    # third
    lw $s1, 8($s0)
    lw $t4, 0($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    lw $t4, 4($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    lw $t4, 8($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    lw $t4, 12($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal
    lw $t4, 16($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_2	# if its equal

    # check asteroid_3
    la $t3, asteroid_3		# $t3 = addr(asteroid_3)
    la $s0, ship
    # first
    lw $s1, 0($s0)
    lw $t4, 0($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    lw $t4, 4($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    lw $t4, 8($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    lw $t4, 12($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    lw $t4, 16($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    # second
    lw $s1, 4($s0)
    lw $t4, 0($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    lw $t4, 4($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    lw $t4, 8($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    lw $t4, 12($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    lw $t4, 16($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    # third
    lw $s1, 8($s0)
    lw $t4, 0($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    lw $t4, 4($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    lw $t4, 8($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    lw $t4, 12($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal
    lw $t4, 16($t3)			# $t4 = $t3[0]
    beq $s1, $t4, ERASE_ASTEROID_3	# if its equal

ERASE_ASTEROID_1:

    # delete asteroid
    lw $t4, 0($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 4($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 8($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 12($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 16($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    la $t4, asteroid_1_counter	# t4 = addr(counter)
    li $t5, 0			# t5 = 0
    sw $t5, 0($t4)		# t4[0] = t5

    # make ship go red
    li $t6, 0xFF2D00		# t6 = red
    la $t3, ship		# t3 = addr(ship)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6
    lw $t4, 4($t3)		# t4 = t3[4]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6
    lw $t4, 8($t3)		# t4 = t3[8]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6

    li $v0, 32			# sleep for 100 ms
    li $a0, 100
    syscall

    la $t3, ship		# t3 = addr(ship)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t8, 0($t5)		# t5[0] = t8
    lw $t4, 4($t3)		# t4 = t3[4]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t9, 0($t5)		# t5[0] = t9
    lw $t4, 8($t3)		# t4 = t3[8]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t9, 0($t5)		# t5[0] = t9

    la $t3, total_collisions	# t3 = addr(total_collisions)
    lw $t4, 0($t3)		# t4 = t3[0]
    addi $t4, $t4, 1		# t4 = t4 + 1
    sw $t4, 0($t3)		# t3[0] = t4
    beq $t4, 5, END		# if t4 == 5, jump to end

    # check if 5 is reached 
    la $t6, hearts		# t6 = addr(hearts)
    addi $t4, $t4, -1		# t4 = t4 - 1
    sll $t4, $t4, 2		# t4 = t4 x 4
    add $t4, $t4, $t6		# t4 = t4 + 6
    lw $t7, 0($t4)		# t7 = t4[0]
    add $t7, $t0, $t7		# t7 = t0 + t7
    sw $t2, 0($t7) 		# t7[0] = t2

    j WHILE_GAME		# jump back to main loop

ERASE_ASTEROID_2:
    # delete asteroid
    lw $t4, 0($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 4($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 8($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 12($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 16($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    la $t4, asteroid_2_counter	# t4 = addr(counter)
    li $t5, 0			# t5 = 0
    sw $t5, 0($t4)		# t4[0] = t5
    
    # make ship go red
    li $t6, 0xFF2D00		# t6 = red
    la $t3, ship		# t3 = addr(ship)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6
    lw $t4, 4($t3)		# t4 = t3[4]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6
    lw $t4, 8($t3)		# t3[8] = t4
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6

    li $v0, 32			# sleep for 100 ms
    li $a0, 100
    syscall

    la $t3, ship		# t3 = addr(ship)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t8, 0($t5)		# t5[0] = t8
    lw $t4, 4($t3)		# t4 = t3[4]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t9, 0($t5)		# t5[0] = t9
    lw $t4, 8($t3)		# t4 = t3[8] 
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t9, 0($t5)		# t5[0] = t9

    la $t3, total_collisions	# t3 = addr(total_collisions)
    lw $t4, 0($t3)		# t4 = t3[0]
    addi $t4, $t4, 1		# t4 = t4 + 1
    sw $t4, 0($t3)		# t3[0] = t4
    beq $t4, 5, END		# t4 == 5, jump to end

    la $t6, hearts		# t6 = addr(hearts)
    addi $t4, $t4, -1		# t4 = t4 - 1
    sll $t4, $t4, 2		# t4 = t4 x 4
    add $t4, $t4, $t6		# t4 = t4 + t6
    lw $t7, 0($t4)		# t7 = t4[0]
    add $t7, $t0, $t7		# t7 = t0 + t7
    sw $t2, 0($t7) 		# t7[0] = t2

    j WHILE_GAME		# jump to main loop

ERASE_ASTEROID_3:
    # delete asteroid
    lw $t4, 0($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 4($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 8($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 12($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    lw $t4, 16($t3)		# $t4 = $t3[0]
    add $t5, $t4, $t0		# $t5 = addr(base + t4)
    sw $t2, 0($t5)		# - erase to black

    la $t4, asteroid_3_counter	# t4 = addr(counter)
    li $t5, 0			# t5 = 0
    sw $t5, 0($t4)		# t4[0] = t5

    # make ship go red
    li $t6, 0xFF2D00		# t6 = red
    la $t3, ship		# t3 = addr(ship)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6
    lw $t4, 4($t3)		# t4 = t3[4]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6
    lw $t4, 8($t3)		# t4 = t3[8]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t6, 0($t5)		# t5[0] = t6

    li $v0, 32			# sleep for 100 ms
    li $a0, 50
    syscall

    la $t3, ship		# t3 = addr(ship)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t8, 0($t5)		# t5[0] = t8
    lw $t4, 4($t3)		# t4 = t3[4]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t9, 0($t5)		# t5[0] = t9
    lw $t4, 8($t3)		# t4 = t3[8]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $t9, 0($t5)		# t5[0] = t9
		
    la $t3, total_collisions	# t3 = addr(total_collisions)
    lw $t4, 0($t3)		# t4 = t3[0]
    addi $t4, $t4, 1		# t4 = t4 + 1
    sw $t4, 0($t3)		# t3[0] = t4
    beq $t4, 5, END		# t4 == 5, jump to end

    la $t6, hearts		# $t6 = addr(hearts)
    addi $t4, $t4, -1		# $t4 = $t4 - 1
    sll $t4, $t4, 2		# $t4 = $t4 x 4
    add $t4, $t4, $t6		# $t4 = $t6(0) + 4 
    lw $t7, 0($t4)		# t7 = t4[0]
    add $t7, $t0, $t7		# t7 = t0 + t7
    sw $t2, 0($t7) 		# t7[0] = t2

    j WHILE_GAME		# jump back to main loop

END:
    # set background to black
    li $t3, 0	# t3 = 0
    WHILE_GAME_OVER:
        add $t5, $t0, $t3		# t5 = t0  + t3
        sw $t9, 0($t5)			# t5[0] = t9
        add $t3, $t3, 4			# t3 = t3 + 4
        beq $t3, 4100, DRAW_LETTERS	# t3 != 4100, draw letters
        j WHILE_GAME_OVER		# jump to while game over

DRAW_LETTERS:
    la $t4, Alphabet_G			# t4 = addr(alphabet_G)
    li $a0, 0				# a0 = 0
    create_G:
        sll $a1, $a0, 2			# a1 = a0 x 4
        add $a1, $a1, $t4		# a1 = a1 + t4
        lw $t5, 0($a1)			# t5 = a1[0]
        add $t6, $t5, $t0		# t6 = t5 + t0
        li $t7, 0xFF0000		# t7 = red
        sw $t7, 0($t6)			# t6[0] = t7
        addi $a0, $a0, 1		# a0 = a0 + 1
        bne $t5, 400, create_G		# t5 != 400, jump to create g
        li $a0, 0			# a0 = 0
        la $t4, Alphabet_A		# t4 = addr(A)
        j create_A			# jump to create A

    create_A:
        sll $a1, $a0, 2			# a1 = a0 x 4
        add $a1, $a1, $t4		# a1 = a1 + t4
        lw $t5, 0($a1)			# t5 = a1[0]
        add $t6, $t5, $t0		# t6 = t5 + t0
        li $t7, 0xFF0000		# t7 = red
        sw $t7, 0($t6)			# t6[0] = t7
        addi $a0, $a0, 1		# a0 = a0 + 1
        bne $t5, 820, create_A		# t5 != 820, jump to A
        li $a0, 0			# a0 = 0
        la $t4, Alphabet_M		# t4 = addr(M)
        j create_M			# jump to create M

    create_M:
        sll $a1, $a0, 2			# a1 = a0 x 4
        add $a1, $a1, $t4		# a1 = a1 + 4
        lw $t5, 0($a1)			# t5 = a1[0]
        add $t6, $t5, $t0		# t6 = t5 + t0
        li $t7, 0xFF0000		# t7 = red
        sw $t7, 0($t6)			# t6[0] = t7
        addi $a0, $a0, 1		# a0 = a0 + 1
        bne $t5, 980, create_M		# t5 != 980, jump to M
        li $a0, 0			# a0 = 0
        la $t4, Alphabet_E_1		# t4 = addr(E)
        j create_E_1			# jump to create E 1

    create_E_1:
        sll $a1, $a0, 2			# a1 = a0 x 4
        add $a1, $a1, $t4		# a1 = a1 + t4
        lw $t5, 0($a1)			# t5 = a1[0]
        add $t6, $t5, $t0		# t6 = t5 + t0
        li $t7, 0xFF0000		# t7 = red
        sw $t7, 0($t6)			# t6[0] = t7
        addi $a0, $a0, 1		# a0 = a0 + 1
        bne $t5, 496, create_E_1	# t5 != 496, jump to create_E1
        li $a0, 0			# a0 = 0
        la $t4, Alphabet_O		# t4 = addr(O)
        j create_O			# jump to create O

    create_O:
        sll $a1, $a0, 2			# a0 = a0 x 4
        add $a1, $a1, $t4		# a1 = a1 + t4
        lw $t5, 0($a1)			# t5 = a1[0]
        add $t6, $t5, $t0		# t6 = t5 + t0
        li $t7, 0xFF0000		# t7 = red
        sw $t7, 0($t6)			# t6[0] = t7
        addi $a0, $a0, 1		# a0 = a0 + 1
        bne $t5, 1296, create_O		# t5 != 1296, jump to O
        li $a0, 0			# a0 = 0
        la $t4, Alphabet_V		# t4 = addr(V)
        j create_V			# jump to V

    create_V:
        sll $a1, $a0, 2			# a0 = a0 x 4
        add $a1, $a1, $t4		# a1 = a1 + t4
        lw $t5, 0($a1)			# t5 = a1[0]
        add $t6, $t5, $t0		# t6 = t5 + t0
        li $t7, 0xFF0000		# t7 = red
        sw $t7, 0($t6)			# t6[0] = t7
        addi $a0, $a0, 1		# a0 = a0 + 1
        bne $t5, 1336, create_V		# t5 != 1336, jump to V
        li $a0, 0			# a0 = 0
        la $t4, Alphabet_E_2		# t4 = addr(E 2)
        j create_E_2			# jump to create E 2

    create_E_2:
        sll $a1, $a0, 2			# a1 = a0 x 4
        add $a1, $a1, $t4		# a1 = a1 + t4
        lw $t5, 0($a1)			# t5 = a1[0]
        add $t6, $t5, $t0		# t6 = t5 + t0
        li $t7, 0xFF0000		# t7 = red
        sw $t7, 0($t6)			# t6[0] = t7
        addi $a0, $a0, 1		# a0 = a0 + 1
        bne $t5, 1876, create_E_2	# t5 != 1876, jump to E 2
        li $a0, 0			# a0 = 0
        la $t4, Alphabet_R		# t4 = addr(R)
        j create_R			# jump to R

    create_R:
        sll $a1, $a0, 2			# a1 = a0 x 4
        add $a1, $a1, $t4		# a1 = a1 + t4
        lw $t5, 0($a1)			# t5 = a1[0]
        add $t6, $t5, $t0		# t6 = t5 + 0
        li $t7, 0xFF0000		# t7 = red
        sw $t7, 0($t6)			# t6[0] = t7
        addi $a0, $a0, 1		# a0 = a0 + 1
        bne $t5, 1636, create_R		# t5 != 1636, jump to R
        j SET_SCORE_BOARD		# jump to set scoreboard

SET_SCORE_BOARD:

    la $t3, obstacles_thrown		# t3 = addr(obstacles_thrown)
    lw $t3, 0($t3)			# t3 = t3[0]
    li $a0, 0				# a0 = 0
    
    # 3rd least significant bit
    li $t4, 1000			# t4 = 1000
    div $t3, $t4			# t3 = t3 % t4
    mfhi $t3				
    li $t4, 100				# t4 = 100
    div $t3, $t4			# t3 = t3 / t4
    mflo $t3

    # function time
    la $t7, s2				# t7 = addr(s2)
    lw $t6, 0($t7)			# t6 = t7[0]
    beq $t6, 0, SET_S			# t6 = 0, jump to set S
    # $t6 is 1
    li $a0, 24				# a0 = 24
    la $t3, obstacles_thrown		# t3 = addr(obstacles_thrown)
    lw $t3, 0($t3)			# t3 = t3[0]

    # 2nd least significant bit
    li $t4, 100				# t4 = 100
    div $t3, $t4			# t3 = t3 mod t4
    mfhi $t3			
    li $t4, 10				# t4 = 10
    div $t3, $t4			# t3 = t3 / t4
    mflo $t3			
    
    la $t7, s1				# t7 = addr(s1)
    lw $t6, 0($t7)			# t6 = t7[0]
    beq $t6, 0, SET_S			# t6 = 0, set S

    li $a0, 48				# a0 = 48
    la $t3, obstacles_thrown		# t3 = obstacles_thrown
    lw $t3, 0($t3)			# t3 = t3[0]

    # least significant bit
    li $t4, 10				# t4 = 10
    div $t3, $t4			# t3 = t3 % t4
    mfhi $t3
    li $t4, 1				# t4 = 1
    div $t3, $t4			# t3 = t3 / t4
    mflo $t3

    la $t7, s0				# t7 = addr(s0)
    lw $t6, 0($t7)			# t6 = t7[0]
    beq $t6, 0, SET_S			# t6 = 0, jump to set S

    j DRAWING_DONE			# jump to drawing done

SET_S:
    li $t6, 1				# t6 = 1
    sw $t6, 0($t7)			# t7[0] = t6
    j SET_NUMBER_ZERO

SET_NUMBER_ZERO:
    beq $t3, 1, SET_NUMBER_ONE		# $t3 = 1, jump to set 1
    beq $t3, 2, SET_NUMBER_TWO		# $t3 = 2, jump to set 2
    beq $t3, 3, SET_NUMBER_THREE	# $t3 = 3, jump to set 3
    beq $t3, 4, SET_NUMBER_FOUR		# $t3 = 4, jump to set 4
    beq $t3, 5, SET_NUMBER_FIVE		# $t3 = 5, jump to set 5
    beq $t3, 6, SET_NUMBER_SIX		# $t3 = 6, jump to set 6
    beq $t3, 7, SET_NUMBER_SEVEN	# $t3 = 7, jump to set 7
    beq $t3, 8, SET_NUMBER_EIGHT	# $t3 = 8, jump to set 8
    beq $t3, 9, SET_NUMBER_NINE		# $t3 = 9, jump to set 9
    
    la $t4, number_zero			# t4 = addr(number_zero)
    lw $t5, 0($t4)			# t5 = t4[0]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 4($t4)			# t5 = t4[4]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 8($t4)			# t5 = t4[8]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 12($t4)			# t5 = t4[12]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 16($t4)			# t5 = t4[16]
    add $t5, $t5, $a0 			# ct5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 20($t4)			# t5 = t4[20]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 24($t4)			# t5 = t4[24]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 28($t4)			# t5 = t4[28]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 32($t4)			# t5 = t4[32]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 36($t4)			# t5 = t4[36]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 40($t4)			# t5 = t4[40]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 44($t4)			# t5 = t4[44]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8

    j SET_SCORE_BOARD			# jump to set score board

SET_NUMBER_ONE:

    la $t4, number_one			# t4 = addr(number_one)
    lw $t5, 0($t4)			# t5 = t4[0]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 4($t4)			# t5 = t4[4]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 8($t4)			# t5 = t4[8]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 12($t4)			# t5 = t4[12]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 16($t4)			# t5 = t4[16]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 20($t4)			# t5 = t4[20]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 24($t4)			# t5 = t4[24]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 28($t4)			# t5 = t4[28]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8

    j SET_SCORE_BOARD			# jump back to set scoreboard

SET_NUMBER_TWO:

    la $t4, number_two			# t4 = addr(two)
    lw $t5, 0($t4)			# t5 = t4[0]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 4($t4)			# t5 = t4[4]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 8($t4)			# t5 = t4[8]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 12($t4)			# t5 = t4[12]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 16($t4)			# t5 = t4[16]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 20($t4)			# t5 = t4[20]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 24($t4)			# t5 = t4[24]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 28($t4)			# t5 = t4[28]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 32($t4)			# t5 = t4[32]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 36($t4)			# t5 = t4[36]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 40($t4)			# t5 = t4[40]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8

    j SET_SCORE_BOARD			# jump back to set scoreboard


SET_NUMBER_THREE:

    la $t4, number_three		# t4 = addr(3)
    lw $t5, 0($t4)			# t5 = t4[0]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = 8
    lw $t5, 4($t4)			# t5 = t4[4]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 8($t4)			# t5 = t4[8]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 12($t4)			# t5 = t4[12]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 16($t4)			# t5 = t4[16]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + a0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 20($t4)			# t5 = t4[20]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 24($t4)			# t5 = t4[24]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 28($t4)			# t5 = t4[28]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 32($t4)			# t5 = t4[32]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 36($t4)			# t5 = t4[36]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8

    j SET_SCORE_BOARD			# jump back to set scoreboard

SET_NUMBER_FOUR:

    la $t4, number_four			# t4 = addr(4) 		
    lw $t5, 0($t4)			# t5 = t4[0]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 4($t4)			# t5 = t4[4]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 8($t4)			# t5 = t4[8]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 12($t4)			# t5 = t4[12]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 16($t4)			# t5 = t4[16]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + a0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 20($t4)			# t5 = t4[20]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 24($t4)			# t5 = t4[24]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 28($t4)			# t5 = t4[28]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 32($t4)			# t5 = t4[32]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8

    j SET_SCORE_BOARD			# jump back to scoreboard

SET_NUMBER_FIVE:

    la $t4, number_five			# t4 = addr(five)
    lw $t5, 0($t4)			# t5 = t4[0]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 4($t4)			# t5 = t4[4]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 8($t4)			# t5 = t4[8]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 12($t4)			# t5 = t4[12]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 16($t4)			# t5 = t4[16]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 20($t4)			# t5 = t4[20]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 24($t4)			# t5 = t4[24]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 28($t4)			# t5 = t4[28]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 32($t4)			# t5 = t4[32]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 36($t4)			# t5 = t4[36]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 40($t4)			# t5 = t4[40]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8

    j SET_SCORE_BOARD			# jump back to set score board

SET_NUMBER_SIX:

    la $t4, number_six			# t4 = addr(6)
    lw $t5, 0($t4)			# t5 = t4[0]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 4($t4)			# t5 = t4[4]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 8($t4)			# t5 = t4[8]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 12($t4)			# t5 = t4[12]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 16($t4)			# t5 = t4[16]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 20($t4)			# t5 = t4[20]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 24($t4)			# t5 = t4[24]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 28($t4)			# t5 = t4[28]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 32($t4)			# t5 = t4[32]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 36($t4)			# t5 = t4[36]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 40($t4)			# t5 = t4[20]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 44($t4)			# t5 = t4[44]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8

    j SET_SCORE_BOARD			# jump to set score board

SET_NUMBER_SEVEN:

    la $t4, number_seven 		# t4 = addr(seven)
    lw $t5, 0($t4)			# t5 = t4[0]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 4($t4)			# t5 = t4[4]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 8($t4)			# t5 = t4[8]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 12($t4)			# t5 = t4[12]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 16($t4)			# t5 = t4[16]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 20($t4)			# t5 = t4[20]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 24($t4)			# t5 = t4[24]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8

    j SET_SCORE_BOARD			# jump back to set score board

SET_NUMBER_EIGHT:

    la $t4, number_eight		# t4 = addr(eight)
    lw $t5, 0($t4)			# t5 = t4[0]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 4($t4)			# t5 = t4[4]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 8($t4)			# t5 = t4[8]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 12($t4)			# t5 = t4[12]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 16($t4)			# t5 = t4[16]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 20($t4)			# t5 = t4[20]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 24($t4)			# t5 = t4[24]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 28($t4)			# t5 = t4[28]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 32($t4)			# t5 = t4[32]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 36($t4)			# t5 = t4[36]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 40($t4)			# t5 = t4[40]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 44($t4)			# t5 = t4[44]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 48($t4)			# t5 = t4[48]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8

    j SET_SCORE_BOARD			# jump back to set score board

SET_NUMBER_NINE:

    la $t4, number_nine			# t4 = addr(nine)
    lw $t5, 0($t4)			# t5 = t4[0]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 4($t4)			# t5 = t4[4]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 8($t4)			# t5 = t4[8]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 12($t4)			# t5 = t4[12]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 16($t4)			# t5 = t4[16]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 20($t4)			# t5 = t4[20]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 24($t4)			# t5 = t4[24]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 28($t4)			# t5 = t4[28]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 32($t4)			# t5 = t4[32] 
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8
    lw $t5, 36($t4)			# t5 = t4[36]
    add $t5, $t5, $a0 			# t5 = t5 + a0
    add $t5, $t5, $t0			# t5 = t5 + t0
    sw $t8, 0($t5)			# t5[0] = t8

    j SET_SCORE_BOARD    		# jump back to set score board

PICK_UP_COIN:

    la $t3, coin_spawn_counter	# t3 = addr(coin_spawn counter)
    sw $zero, 0($t3)		# t3[0] = zero

    la $t3, coin_item		# t3 = addr(coin_item)
    lw $t4, 0($t3)		# t4 = t3[0]
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $zero, 0($t3)		# t3[0] = zero

    la $t3, obstacles_thrown	# t3 = addr(obstacles_thrown)
    lw $t4, obstacles_thrown	# t4 = t3[0]
    add $t4, $t4, 20		# t4 = t4 + 20
    beq $t4, 999, WHILE_GAME	# t4 = 999, jump back to main loop
    sw $t4, 0($t3)		# t3[0] = t4
    
    J WHILE_GAME		# jump back to main loop

PICK_UP_HEART:
    la $t3, heart_spawn_counter	# t3 = addr(heart_spawn_counter)
    sw $zero, 0($t3)		# t3[0] = zero

    la $t3, heart_item		# t3 = addr(heart_item)
    lw $t4, 0($t3)		# t4 = t3[0] 
    add $t5, $t0, $t4		# t5 = t0 + t4
    sw $zero, 0($t3)		# t3[0] = zero

    la $t3, total_collisions	# t3 = addr(total_collisions)
    lw $t4, 0($t3)		# t4 = t3[0]
    addi $t4, $t4, -1		# t4 = t4 - 1
    sw $t4, 0($t3)		# t3[0] = t4

    la $t3, hearts		# t3 = addr(hearts)
    sll $t4, $t4, 2		# t4 = t4 x 4
    add $t4, $t4, $t3		# t4 = t4 + t3
    lw $t5, 0($t4)		# t5 = t4[0]
    add $t6, $t5, $t0		# t6 = t5 + t0
    li $t7, red			# t7 = red
    sw $t7, 0($t6) 		# t6[0] = t7

    J WHILE_GAME		# jump back to main loop

DRAWING_DONE:
    lw $t3, 0xffff0000		# key press input
    beq $t3, 1, PRESSED_P	# if key was pressed
    j DRAWING_DONE		# jump back to drawing done

PRESSED_P:
    lw $t4, 0xffff0004		# looks at the input
    beq $t4, 0x70, respond_to_p	# if input is p go back to main loop
    j DRAWING_DONE		# jump back to drwaing done
