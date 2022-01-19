org 00H
ljmp START


org 100H
	START:
	// Take the input from R0(LSB) and R1(MSB)
	MOV R1,#0C3H
	MOV R0,#50H
	
	ACALL COMPLEMENT_2
	CLR P1.4
	CLR P1.5
	CLR P1.6
	CLR P1.7
BEGIN: MOV R3,#40d	
HERE: ACALL DELAY
TOGGLE:DJNZ R3, HERE
	CPL P1.4
	CPL P1.5
	CPL P1.6
	CPL P1.7
	LJMP BEGIN 	
	
	
org 200H
	COMPLEMENT_2:
	MOV A, R1
	CPL A
	MOV R1, A	
	MOV A, R0
	CPL A
	ADD A, #01H
	MOV R0, A
	MOV A, R1
	ADDC A,#00H
	MOV R1, A
	// 2's complement is stored in R0 and R1
	RET
	
org 300H
	DELAY:
	MOV TMOD, #01b
	MOV TL0, R0
	MOV TH0, R1
	SETB TR0
Loop:JNB TF0, Loop
	CLR TR0
	CLR TF0
	RET

	
END