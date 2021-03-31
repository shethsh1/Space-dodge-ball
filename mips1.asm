.text

.eqv a 4

main:
	li $t0, a
	li $s0, a
	li $t2, 105
	sw $t2, 0($sp)
	
	lw $t3 0($sp)
	
	
	syscall


	