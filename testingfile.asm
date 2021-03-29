.eqv BASE_ADDRESS 0x10008000


.data
	asteroid_1:	.word	0
	asteroid_2:	.word	0
	asteroid_3:	.word	0
	ship:		.word	0:2
	hearts:		.word	3928, 3936, 3944, 3952, 3960
.text

	li $t0, BASE_ADDRESS # $t0 stores the base address for display
	li $t1, 0xd3d3d3 # $t1 stores the grey colour code
	li $t2, 0x000000 # $t2 stores the black colour code
	li $t8, 255	# blue
	li $t9, 16776960	# yellow
	
	# set to 4100 once done
	
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