TITLE ASKISI5
KODIKAS SEGMENT PUBLIC
ASSUME CS:KODIKAS, DS:DEDOMENA, SS:SOROS

MAIN PROC NEAR
	MOV AX,DEDOMENA ; Apokatastash tou DS
	MOV DS,AX	; Apokatastash tou DS

	MOV AL, NUM1	; Metaferoume tin timi tis metablitis Num1 ston AL
	ADD AL, NUM2	; Prosthetoume ston AL kai tin timi tis metablitis Num2

	MOV DL, AL	; Metaferoume to athroisma apo ton AL ston DL gia na ginei to perasma meso kataxoriti
	CALL DISPLAY_HEX; Kaloume tin Display_hex 

	MOV AH,4CH	; Eksodos sto leitoyrgiko systhma
	INT 21H
MAIN ENDP

DISPLAY_HEX PROC NEAR
	MOV BL,DL	; Metafero to periexomeno tou DL se allo kataxoriti giati ton xriazomai kai pali

	MOV BH,0	; Mizenizo ton BH kai etsi ksero oti o BX exei ayto pou eixe o BL
	MOV CL,4	; Bazo ston CL 4 gia na exo toses epanalipseis

	SHL BX,CL	; Metatopizo aristera ton BX tosa bit osa exei o CL
	MOV DL,BH	; Metaferoume ton proto hex arithmo apo ton BH ston DL gia na ginei to perasma 

	CALL ONE_DIGIT	; Kaloume tin One_digit 

	MOV CL,4	; Bazo ston CL 4 gia na exo toses epanalipseis

	SHR BL,CL	; Metatopizo Deksia ton BL tosa bit osa exei o CL
	MOV DL,BL	; Metaferoume ton deftero hex arithmo apo ton BL ston DL gia na ginei to perasma 

	CALL ONE_DIGIT	; Kaloume tin One_digit

	RET		; Epistrefo stin thesi apo opou klithike h yporoutina

DISPLAY_HEX ENDP


ONE_DIGIT PROC NEAR
	
	CMP DL,9	; Sygkrinoume to DL me to 9 gia na ksexoriso an o DL exei arithmo 0-9 H metaksi 10-15
	JA GRAMMA	; An o DL einai metaksi 10-15 phgaine stin etiketa "Gramma" gia na emfanistei apo A-F

	ADD DL,48	; Metatrepoume ton arithmo poy exei o DL se xaraktira poy einai antistoixos se ASCII
	JMP NEXT	; Phgainoyme stin etiketa "Next" giati i epomeni grammi anaferetai gia arithmoys 10-15

GRAMMA:	ADD DL, 'A'-10	; Metatrepoume ton aritho pou einai 10-15 sto antistoixo gramma A-F prosthetontas 55

NEXT:	MOV AH,02H	; Emfanizoyme stin othoni to periexomeno tou DL
	INT 21H 

TELOS:	RET		; Epistrefo stin thesi apo opou klithike h yporoutina

ONE_DIGIT ENDP

KODIKAS ENDS

DEDOMENA SEGMENT
	NUM1 DB 1Fh    ;= 31
	NUM2 DB 0B3h   ;=179     ; 31+179=210 dld D2
					
DEDOMENA ENDS

SOROS SEGMENT STACK
	DB 256 DUP(0)
SOROS ENDS
	END MAIN
