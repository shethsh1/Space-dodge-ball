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
	ship:		.word	0:2
		asteroid:	.word	3232
.text

	li $t0, BASE_ADDRESS # $t0 stores the base address for display
	li $t1, 0xd3d3d3 # $t1 stores the grey colour code
	li $t2, 0x000000 # $t2 stores the black colour code
	li $t8, 0x0000FF	# blue
	li $t9, 0xFFFF00	# yellow

	
	
game_start:

	la $t3, asteroid
	lw $t4, 0($t3)		# $t4 = ship[0]
	add $t4, $t4, 128		# $t4 = $t4 + 4
	add $t5, $t0, $t4	# $t5 = addr(map + $t4)
	lw $t7, 0($t5)
	beq $t7, $t2, hey
	sw $t4, 0($t3)




hey:
	li $t8, 11
	
	
	
end:
	li $v0, 10
	syscall

	
	

	

	




	


	
	
	
