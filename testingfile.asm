.eqv BASE_ADDRESS 0x10008000


.data
	asteroid_1:	.word	0
	asteroid_2:	.word	0
	asteroid_3:	.word	0
	ship:		.word	0:2
.text

	li $t0, BASE_ADDRESS # $t0 stores the base address for display
	li $t1, 0xd3d3d3 # $t1 stores the grey colour code
	li $t2, 0x000000 # $t2 stores the black colour code
	li $t8, 255	# blue
	li $t9, 16776960	# yellow
	
	sw $t9, 0($t0)
	lw $t3, 0($t0)