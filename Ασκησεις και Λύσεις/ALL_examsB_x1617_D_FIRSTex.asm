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

        CMP AL, 'A'
        JB WRONG        ;Enas elenxos
        
        CMP AL, 'Z'
        JA WRONG
        
        MOV DL,AL
        MOV AH,02H      ;Emfanisi eisagwgis
        INT 21H
        
        
        MOV BL,AL
        CALL YP  
        
        MOV DL,AL
        CALL SPLITHEX   ;Gia na xoriso ton deytero hex arithmo
        CALL PRINTHEX   ;Gia na ektiposo ton deytero hex arithmo
        
        
        ;Omali eksodos sto DOS
        MOV AH,4CH
        INT 21H
    MAIN ENDP




    YP PROC
	;Dexetai ton BL
	MOV AL,BL
	MUL BL
	
	SHR AX,5	
  
    RET
    YP ENDP	


    SPLITHEX PROC
;Parameter: DL    
        MOV DH, DL
        AND DH, 0FH
    
        AND DL, 0F0H  
        SHR DL, 4
        RET
ENDP SPLITHEX    
 
 
 
    
PRINTHEX PROC
;Parameter: DX
;4 MSB of HEX number: DL
;4 LSB of HEX number: DH
    
        CMP DL, 10
        JAE letDL
        
numDL:                     
        ADD DL, '0'
        JMP doDH
    
letDL:
        ADD DL, 'A'-10
                   
doDH:
        CMP DH, 10
        JAE letDH
        
numDH:
        ADD DH, '0'
        JMP print
    
letDH:    
        ADD DH, 'A'-10
     
print: 
        MOV AH, 2
        INT 21h
            
        MOV DL, DH
        MOV AH, 2
        INT 21h
        
        RET    
PRINTHEX ENDP    
	
KODIKAS ENDS

DEDOMENA SEGMENT  
    BUFFER DB 8 DUP(0)
    PROTROPI DB 'thelw ena kefalaio $'
    LATHOS db 7,10,13,"WRONG!"

DEDOMENA ENDS   

    END MAIN 