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

        CMP AL, '0'
        JB WRONG        ;Enas elenxos
        
        CMP AL, '9'
        JA WRONG
        
        MOV DL,AL
        MOV AH,02H      ;Emfanisi eisagwgis
        INT 21H
        
        
        
        CALL YP  
        
        ;Omali eksodos sto DOS
        MOV AH,4CH
        INT 21H
    MAIN ENDP




    YP PROC
	
  
    RET
    YP ENDP	



	
KODIKAS ENDS

DEDOMENA SEGMENT  
    BUFFER DB 8 DUP(0)
    PROTROPI DB 'SOMETHING SOMETHING $'
    LATHOS db 7,10,13,"WRONG!$"

DEDOMENA ENDS   

    END MAIN 