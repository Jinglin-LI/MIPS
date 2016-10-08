# Convert lowercase string to uppercase string
.data
lower: .asciiz ""	# lowercase string
upper: .asciiz "\n"

.text
main:
#taking input
li $v0,8	
li $a1,20
la $a0,lower
syscall

li $v0,4
li $s0,0

#if the char is not lowercase
li $t2, 97
li $t3, 122

addi $sp, $sp, -8
sw $s1, 4($sp)
sw $s0, 0($sp)

jal loop

#looping through the string
loop:		
	lb $t1,lower($t0)	# load byte instruction 
	blt $t1, $t2, skip	# the ASCII code of "a"
	bgt $t1, $t3, skip	# the ASCII code of "z"
	beq $t1,0,exit		# when the string end	
	sub $t1,$t1,32		# ASCII , 'a' + 32 = 'A'
	sb $t1,lower($t0)	# store byte in the lower string
	addi $t0,$t0,1		# "i++"
	jr $ra
	j loop
skip:	
	sb $t1, lower($t0)	# maintain non-lowercase in the lower
	addi $t0, $t0, 1	# "i++"
	bne $t1, 0, loop	# loop if not end

	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8

#print final string
exit:
li $v0,4
la $a0,lower
syscall

#end program
li $v0,10
syscall
