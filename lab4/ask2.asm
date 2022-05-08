TITLE ask2
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    ARXI:   
        MOV AX,DEDOMENA	
	    MOV DS,AX	
        
        
        ;prwto meros
        
NOTVALID:        
        
        LEA DX,MINIMA     ;zhtaei n dwsei arithmo
        MOV AH,9
        INT 21H

        MOV AH,08H        ;diabzei to arithmo kai ton apothikeuei sto AL
        INT 21H
                
        CMP AL, '0'       ;elenxei an 0<=ah<=9
        JB NOTVALID
        CMP AL, '9'
        JA NOTVALID
                        
        
        MOV DL, AL        ;emfanizei ton arithmo AL
        MOV AH,02H
        INT 21H
        
        ;deutero meros
        
        CMP AL, '0'
        JNE OXIMUDEN 
           
           LEA DX,MINIMA2     ;leei oti einai 0
           MOV AH,9
           INT 21H
        
        JMP NEXT
        
OXIMUDEN:        
        MOV CL, AL
        
        MOV AH, 0
        MOV BL, 2
        DIV BL
        
        CMP AH, 0
        JE ZUGOS 
            LEA DX,MINIMA5     ;"O "
            MOV AH,9
            INT 21H
            
            MOV DL, CL        ;emfanizei ton arithmo AL
            MOV AH,02H
            INT 21H
            
            LEA DX,MINIMA3     ;Leei oti einai monos
            MOV AH,9
            INT 21H
        JMP NEXT
        ZUGOS: 
            LEA DX,MINIMA5     ;"O "
            MOV AH,9
            INT 21H
            
            MOV DL, CL        ;emfanizei ton arithmo AL
            MOV AH,02H
            INT 21H
            
            LEA DX,MINIMA4     ;Leei oti einai zugos
            MOV AH,9
            INT 21H
        
NEXT:
        MOV AH,4CH
        INT 21H
	
KODIKAS ENDS

DEDOMENA SEGMENT
    MINIMA DB 'Grapse enan monopsifio dekadiko arithmo: ', 10, 13, '$'
    MINIMALATH DB 'Lathos eisagogi, zhthtai monopsifio dekadiko arithmo: ', 10, 13, '$' 
    MINIMA2 DB 10, 13,"Einai to 0 $"  
    MINIMA3 DB " einai monos $"   
    MINIMA4 DB " einai zugos $"  
    MINIMA5 DB 10, 13,'O $'

DEDOMENA ENDS


    END ARXI