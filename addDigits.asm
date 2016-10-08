# Homework 1	add the last 4 digits of my phone number
.data
digit1:	.word	9			# varible digit1 = 9
digit2:	.word	8			# varible digit2 = 8
digit3:	.word	9			# varible digit3 = 9
digit4:	.word	0			# varible digit4 = 0
sum:	.word	255			# varible sum = 255
.text
main:	lw	$t1, digit1		# $t1 = 9
	lw	$t2, digit2		# $t2 = 8
	add	$t1, $t1, $t2		# $t1 = 9 + 8 = 17
	lw	$t2, digit3		# now $t2 = 9
	add	$t1, $t1, $t2		# now $t1 = (9 + 8) + 9 = 26
	lw	$t2, digit4		# now $t2 = 0
	add	$t1, $t1, $t2		# now $t1 = (9 + 8) + 9 + 0 = 26
	sw	$t1, sum		# store $t1 in sum
	
	# exit				# gracefully ends program
	li	$v0, 10
	syscall
