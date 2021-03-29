.data
	d_edge:	.word   124, 252, 380, 508, 636, 764, 892, 1020, 1148, 1276, 1404, 1532, 1660, 1788, 1916, 2044, 2172, 2300, 2428, 2556, 2684, 2812, 2940, 3068, 3196, 3324, 3452, 3580, 3708, 3836, 3964, 4092, -1
	ship: 	.word	0:2
	
.text

main:
	li $t4, 5000
	la $t3, ship
	lw $t6, 0($t3)
	la $t3, d_edge
	j test__edge_loop
	
	proceed:
		li $t9, 10
		
	
test__edge_loop:
	
	lw $t5, 0($t3)
	
	beq $t4, $t5, end
	blt $t4, $t5, proceed # 5000 < 4096  
	addi $t3, $t3, 4

	j test__edge_loop
	
end:
	li $v0, 10
	syscall
	
	
	