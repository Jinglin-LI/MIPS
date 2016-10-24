# Homework 5 – BMI Calculator

.data
	askname: .asciiz "What is your name? "
	askheight: .asciiz "\nPlease enter your height in inches: "
	askweight: .asciiz "Now enter your weight in pounds (round to a whole number): "
	outputresult: .asciiz ", your bmi is: "
	underweight: .asciiz ". This is considered underweight.\n"
	normal: .asciiz ". This is a normal weight. \n"
	overweight: .asciiz ". This is considered overweight. \n"
	obese: .asciiz ". This is considered obeses. \n"
	
	height: .word 0
	weight: .word 0
	bmi: .double 0.0
	myname: .space 20
	zero: .double 0.0
	consoneeight: .double 18.5
	constwofive: .double 25.0
	consthreezero: .double 30.0

.text
main:	# prompt the user to enter name
	la $a0, askname
	li $v0, 4
	syscall
	
	# take in the input and save the string into myname
	li $v0, 8	
	la $a0, myname
	li $a1, 8
	
	# move the address of myname into $t0
	move $t0, $a0
	syscall
	
	# prompt the user to enter height
    	la $a0, askheight
    	li $v0, 4
    	syscall
    	
    	# take in input of height
    	li $v0,5
    	syscall
    	sw $v0, height
    	move $t1, $v0
    	
    	# prompt the user to enter weight
    	la $a0, askweight
    	li $v0, 4
    	syscall
    	
    	# take in input of weight
    	li $v0,5
    	syscall
    	sw $v0, weight
    	move $t2, $v0
    	
    	# calculate the bmi
    	mul $t2 $t2, 703
	mul $t1, $t1, $t1
	
	# save height and weight
	sw $t1, height
	sw $t2, weight
	
	# convert the type of weight
	lwc1 $f2,weight
	cvt.d.w $f4, $f2
	
	# convert the type of height
	lwc1 $f6,height
	cvt.d.w $f8, $f6
	
	# print the name the user just inputed
	la $a0, myname
	li $v0, 4
	syscall
	
	# print"your bmi is "
	la $a0, outputresult
	li $v0, 4
	syscall
	
	# print the bmi
	div.d $f10, $f4, $f8
	add.d $f12, $f10, $f0
	li $v0, 3
	syscall
	
	# branch1 < 18
	ldc1 $f2, consoneeight
	c.lt.d $f10, $f2
	bc1f branch2
	j printone
	
	# branch2 else if (bmi < 25)
branch2:
	ldc1 $f4, constwofive
	c.lt.d $f10, $f4
	bc1f branch3
	j printtwo
	
	# branch3: else if (bmi < 30)
branch3: 
	ldc1 $f2, consthreezero
	c.lt.d $f10, $f2
	bc1f branch4
	j printthree
	
	# branch4: else
branch4: 
	j printfour
	
	# print "this is underweight"
printone:
	la $a0, underweight
	li $v0, 4
	syscall
	j exit
	
	# print "normal"
printtwo:
	la $a0, normal
	li $v0, 4
	syscall
	j exit
	
	# print "overweight"
printthree: 
	la $a0, overweight
	li $v0, 4
	syscall
	j exit
	
	# print "obese"
printfour:
	la $a0, obese
	li $v0, 4
	syscall
	j exit
	
exit: 	li $v0, 10
	syscall
