TITLE ALL_examsA_x1617_D_FIRSTex
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA, SS:SOROS
    MAIN PROC    
        MOV AX,DEDOMENA	
	    MOV DS,AX	
        
        
        CALL YP1  
        
        LEA DX,PRAKSI
	    MOV AH,09H	    ; Zitaw praksi
	    INT 21H
        
        MOV AH, 01H     ; Diavasma
        INT 21H
        
        MOV BH,N1
        MOV BL,N2
        MOV CH,AL
        CALL YP2
        
        
        
        
        MOV AH,4CH
        INT 21H

    MAIN ENDP

        
        
        
;PRWTH UPOLEITOURGIA
    YP1 PROC
	    
	    MOV SI,0
	    JMP READ
WRONG:        
        LEA DX,LATHOS
	    MOV AH,09H	    ; Typwnoume to mhnyma lathous
	    INT 21H 
	   
READ:   	   
	    LEA DX,PROTROPI
	    MOV AH,09H	    ; Typwnoume to mhnyma prootropis
	    INT 21H
        
        MOV AH, 08H     ; Diavasma
        INT 21H
        
        CMP AL, '0'
        JB WRONG
        
        CMP AL, '9'
        JA WRONG
        
        MOV DL,AL
        MOV AH,02H      ;Emfanisi arithmou
        INT 21H
                
        INC SI
        
        CMP SI,2
        JE SECOND
        
        MOV N1,AL
	    JMP READ
	    
SECOND:	    
	    MOV N2,AL
               
        
    RET
    YP1 ENDP	


;DEYTERI YPOLEITOURGIA
    YP2 PROC
        
        SUB BH,30H
        SUB BL,30H
        MOV AH,0
        MOV AL,BH
        
        CMP CH,'+'
        JE PROS
        
        MUL BL
        JMP RES                         
PROS:        
        ADD AL,BL
        
RES:    
        MOV BX,AX
        
        LEA DX,RESULT
	    MOV AH,09H	    ; Typwnoume to mhnyma prootropis
	    INT 21H
        
        PSIFIA2:                
        MOV AX,BX   ; METEFERE TIN TIMI TOY BH STON AL
;        MOV AH,0    ; MIDENIZO TON AH
    
        MOV CL,10	; METAFERO TO 10 STO CL
	    DIV CL		; DIERO TON AX ME TO CL

	    MOV DEKADA,AL ; METAFERO STI THESI MNIMIS DEKADA TO PILIKO TIS DIERESIS
	    MOV MONADA,AH ; METAFERO STI THESI MNIMIS MONADA TO YPOLIPO TIS DIERESIS
        
        CMP DEKADA,0
        JE NODEK
	    MOV DL,DEKADA ; METAFERO STO DL TO PERIEXOMENO TIS THESIS MNIMIS DEKADA
	    ADD DL,30H 	; PROSTHETO TIN ascii TIMI TOY 0                                                    30H = 48
	    MOV AH,02H 	; METAFEROYME STON AH TO 2 GIA NA EMFANISOYME TO PERIEXOMENO TOY DL
	    INT 21H		; KALOYME TO LEITOYRGIKO SYSTIMA NA EMFANISI STIN OTHONI TO PERIEXOMENO TOY DL
NODEK:	
	    MOV DL,MONADA ; METAFERO STO DL TO PERIEXOMENO TIS THESIS MNIMIS MONADA
	    ADD DL,30H	; PROSTHETO TIN ascii TIMI TOY 0
	    MOV AH,02H	; METAFEROYME STON AH TO 2 GIA NA EMFANISOYME TO PERIEXOMENO TOY DL
	    INT 21H		; KALOYME TO LEITOYRGIKO SYSTIMA NA EMFANISI STIN OTHONI TO PERIEXOMENO TOY DL 
         
    RET     
    YP2 ENDP


	
KODIKAS ENDS

DEDOMENA SEGMENT  
    
    N1 DB 0
    N2 DB 0
    DEKADA DB 0
    MONADA DB 0
    PROTROPI DB 10,13,'Eisagete ena 10adiko arithmo : $'
    LATHOS DB 10,13,'WRONG INPUT$'
    PRAKSI DB 10,13,'Doste ena symbolo praksis : $'
    RESULT DB 10,13,'To athroisma tous einai : $'

DEDOMENA ENDS 

    END MAIN 