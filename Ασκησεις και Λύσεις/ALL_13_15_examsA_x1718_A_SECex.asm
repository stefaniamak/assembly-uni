TITLE mymaskwithYP10diko
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    MAIN PROC    
        MOV AX,DEDOMENA	
	    MOV DS,AX	

        LEA DX,PROTROPI
	    MOV AH,09H	    ; Typwnoume to mhnyma prootropis
	    INT 21H
        
        JMP READ
WRONG:        
        LEA DX,LATHOS
	    MOV AH,09H	    ; Typwnoume to mhnyma lathous
	    INT 21H 
	   
READ:   	   
        
        MOV AH, 08H     ; Diavasma kai 01h gia paralhlh emfanish
        INT 21H

        CMP AL, '2'
        JB WRONG        ;Enas elenxos
        
        CMP AL, '6'
        JA WRONG
        
        MOV BH,AL
        MOV DL,AL
        MOV AH,02H      ;Emfanisi eisagwgis
        INT 21H
        
        MOV SI,0
        DEC SI

L1:        
        INC SI
        MOV BL,SYMV[SI]
        CMP BL,'$'
        JNE L1

L2:        
        DEC SI 
        MOV CH,0
        MOV CL,BH
L3:        
        CMP BH,1
        JE N1
     
        MOV DL,SYMV[SI]
        MOV AH,02H      ;Emfanisi eisagwgis
        INT 21H
        JMP EX
N1:
        MOV DL,'$'
        MOV AH,02H      ;Emfanisi eisagwgis
        INT 21H

EX:        
        LOOP L3
        
        LEA DX,NL
	    MOV AH,09H	    ; Typwnoume to mhnyma prootropis
	    INT 21H
        
        CMP BH,1
        JMP N2
        DEC BH
N2:
        DEC SI
        CMP SI,0
        JAE L2 
        
        ;Omali eksodos sto DOS
        MOV AH,4CH
        INT 21H
    MAIN ENDP

	
KODIKAS ENDS

DEDOMENA SEGMENT  
    BUFFER DB 8 DUP(0)
    SYMV DB 'Xaxaxu$'
    PROTROPI DB 'give 2 to 6: $'
    LATHOS db 7,10,13,"WRONG!$"
    NL DB 10,13,'$'

DEDOMENA ENDS   

    END MAIN 