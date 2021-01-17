.data
	n: .word 47
	
.text
.globl main

main:	
	li x1, 1	# counter
	li x2,0		# Compare to 0
	li x3,1		# Compare to 1
	lw x4,n		# Input n
	li x6, 0	# 1st integer
	li x9, 1	# 2end integer
	li x8, 000000	# sum
	
	beq x4,x2 ZERO		# Prüfe ob n == 0 
	beq x4, x3 ONE		# Prüfe ob n == 1 
LOOP:	beq x4,x1 EXIT		# # Prüfe ob counter == 47
	beq x2, x8, NULL	# Prüfe auf x2 == x8 == 0, dann printe 0
BCA:	beq x3, x1, PRINT	# Für counter == 1 printe einmalig die Zahl 1
		
ABC:	li x17, 11		# Vorbereiten um ein ascii char zu printen 
	li x10, 0x0a		# ascii char für zeilenumbruch
	ecall			# syscall
	li x17, 36		# Prints an Integer unsigned
	add x10, x6,x9		# Summe aus x6, x9 in x10 für print
	ecall			# syscall
	add x8,x6,x9		# addiere Zahl und Zahl + 1 
	ori x6,x9,0		# Veroderung mit 0 und Nachfolger wird Vorgänger
	ori x9, x8,0		# Veroderung mit 0 und Summe wird Nachfolger von x6
	add x1, x1, x3		# Counter um 1 erhöhen
	
	j LOOP			# springe zum label LOOP

NULL:	li x17,1 		# Gebe als erste Zahl eine 0 aus
	li x10, 0
	ecall
	li x17, 11
	li x10, 0x0a		# Gebe Zeilenumbruch aus
	ecall
	j BCA
			
ZERO:	li x17, 1		# Für die eingabe n==0
	add x10, x10, x0	# x10 = 0
	ecall			# gebe 0 aus
	li x17,10		# vorbereitung zum beenden
	ecall			# beenden

ONE:	li x17, 1		# vorbereitung für print an integer
	li x10, 1		# lade die zu ausgebende zahl
	ecall			# zahl ausgeben 
	li x17, 10		# programm beenden
	ecall

EXIT:	#li x17, 36		# Teilaufgabe a: um die letzte Zahl auszugeben
	#add x10, x8,x0
	#ecall	
	li x17, 10		# nachdem counter == n bereite das beenden vor
	ecall			# beenden
	
PRINT:	li x17, 36		# 36 für unsigned, 1 würde auch gehen da nur 1 bit ausgegeben werden soll
	li x10, 1		# lade 1 in x10
	ecall			# syscall
	j ABC			# jump to ABC, einmaliger aufruf da danach counter = counter +1 und bedingung nicht mehr erfüllbar
