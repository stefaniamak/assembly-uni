TITLE ALL_examsA_x1617
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    ARXI:   
        MOV AX,DEDOMENA	
	    MOV DS,AX	
         
         
        LEA DX,PROTROPI
	    MOV AH,09H	    ; Typwnoume to mhnyma prootropis
	    INT 21H                
        
        MOV SI, 7H
        
        
V1:     MOV AH, 08H     ;Diavasma
        INT 21H
        
        CMP AL, '0'
        JE SAVE
        
        CMP AL, '1'
        JE SAVE
        
        LEA DX,BEEP
	    MOV AH,09H	    ; Typwnoume to mhnyma lathous
	    INT 21H 
        JMP V1
               
SAVE:   MOV BUFFER[SI], AL                              
        
        MOV DL,BUFFER[SI]
	    MOV AH,02H	    ; Typwnoume to periexomeno tou Buffer
	    INT 21H
        
        DEC SI 
        CMP SI,7
       JB V1
       
        LEA DX,NEXTLINE
	    MOV AH,09H	    ; Afhnw mia seira keno
	    INT 21H
        INC SI
        
        MOV BX,0
        MOV DL, BUFFER[SI]
        SUB DL,30H
        INC SI
        MOV BL,2
                 
V2:        
        MOV AL, BUFFER[SI]
        SUB AL,30H
        MUL BL

        ADD DX, AX

        SHL BX,1

        INC SI


        
CMP SI,8
JB V2        
        
;        ADD DL,30H	; Prosthetoyme ston DL tin timi 48 gia na metatrepsoyme ton aritmo stin ASCII timi toy
;        MOV AH,02H	; Metaferoyme ston AH to 2 gia na mporoyme na emfanisoyme to periexomeno toy DL
;        INT 21H
        
        
            PSIFIA2:                
        MOV AL,DL   ; METEFERE TIN TIMI TOY BH STON AL 
        MOV AH,0
    
        MOV CL,10	; METAFERO TO 10 STO CL
	    DIV CL		; DIERO TON AX ME TO CL

	    MOV MONADA,AH ; METAFERO STI THESI MNIMIS MONADA TO YPOLIPO TIS DIERESIS
         
        MOV AH,0
    
        MOV CL,10	; METAFERO TO 10 STO CL
	    DIV CL
        
        MOV EKATONTADA,AL ; METAFERO STI THESI MNIMIS DEKADA TO PILIKO TIS DIERESIS
	    MOV DEKADA,AH ; METAFERO STI THESI MNIMIS MONADA TO YPOLIPO TIS DIERESIS
        
        MOV DL,EKATONTADA ; METAFERO STO DL TO PERIEXOMENO TIS THESIS MNIMIS DEKADA
	    ADD DL,30H 	; PROSTHETO TIN ascii TIMI TOY 0                                                    30H = 48
	    MOV AH,02H 	; METAFEROYME STON AH TO 2 GIA NA EMFANISOYME TO PERIEXOMENO TOY DL
	    INT 21H
        
	    MOV DL,DEKADA ; METAFERO STO DL TO PERIEXOMENO TIS THESIS MNIMIS DEKADA
	    ADD DL,30H 	; PROSTHETO TIN ascii TIMI TOY 0                                                    30H = 48
	    MOV AH,02H 	; METAFEROYME STON AH TO 2 GIA NA EMFANISOYME TO PERIEXOMENO TOY DL
	    INT 21H		; KALOYME TO LEITOYRGIKO SYSTIMA NA EMFANISI STIN OTHONI TO PERIEXOMENO TOY DL
	
	    MOV DL,MONADA ; METAFERO STO DL TO PERIEXOMENO TIS THESIS MNIMIS MONADA
	    ADD DL,30H	; PROSTHETO TIN ascii TIMI TOY 0
	    MOV AH,02H	; METAFEROYME STON AH TO 2 GIA NA EMFANISOYME TO PERIEXOMENO TOY DL
	    INT 21H		; KALOYME TO LEITOYRGIKO SYSTIMA NA EMFANISI STIN OTHONI TO PERIEXOMENO TOY DL
	    
	    
    
FINISH: MOV AH,4CH
        INT 21H
	
KODIKAS ENDS

DEDOMENA SEGMENT  

    BUFFER   DB 8 DUP(0)
    PROTROPI DB 'Dwse enan 8psifio diadiko arithmo: $'
    BEEP     DB 7,7,7, '$'
    NEXTLINE DB 10,13, '$'
    EKATONTADA DB 0
    DEKADA DB 0
    MONADA DB 0


DEDOMENA ENDS


    END ARXI 