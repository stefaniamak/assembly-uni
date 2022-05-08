TITLE mymaskwithYP10diko
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    MAIN PROC    
        MOV AX,DEDOMENA	
	    MOV DS,AX	

        LEA DX,PROTROPI
	    MOV AH,09H	    ; Typwnoume to mhnyma prootropis
	    INT 21H
	    
	    MOV BX,0
START:	    
	    MOV SI,0
	    MOV CX,6
	       	   
READ:        
        MOV AH, 08H     ; Diavasma kai 01h gia paralhlh emfanish
        INT 21H

        CMP AL, 'a'
        JB NOSAVE        ;Enas elenxos
        
        CMP AL, 'z'
        JA NOSAVE
        
            MOV BUFFER[SI], AL
            INC SI
NOSAVE:            
        LOOP READ
        
        MOV DI,SI
        MOV SI,0
        MOV CX,0
        
PRINT:  
            
        MOV DL,BUFFER[SI]
        MOV AH,02H      ;Emfanisi eisagwgis
        INT 21H 
        
        MOV DL,BUFFER[SI]
        ADD CX,DX
        
        INC SI
        CMP SI,DI
        JB PRINT
        
        CMP BX,0
        JNE NEXTN
        
        MOV BX,CX
        
        MOV CX,SI
        MOV AL,0
        MOV SI,0
        L:
        MOV AL,BUFFER[SI]
        MOV BUFFER2[SI],AL
        MOV BUFFER[SI],0
        INC SI
        LOOP L
        
        JMP START
        
NEXTN:  
        MOV SI,0
        
        LEA DX,MEG
	    MOV AH,09H	    ; Typwnoume to mhnyma MEG
	    INT 21H

        CMP BX,CX
        JE EQ
        
        CMP BX,CX
        JB BEL      
        
        L2:
        MOV DL,BUFFER2[SI]
        MOV AH,02H      ;Emfanisi eisagwgis
        INT 21H
        
        INC SI
        cmp SI,6
        JB l2
        
        jmp exit
        
EQ:     
        LEA DX,ISOI
	    MOV AH,09H	    ; ISOI
	    INT 21H
	    jmp exit        
        
BEL:
        L3:
        MOV DL,BUFFER[SI]
        MOV AH,02H      ;Emfanisi eisagwgis
        INT 21H
        
        INC SI
        CMP SI,6
        JB L3
        
        
        
        
                 
exit:        
        ;Omali eksodos sto DOS
        MOV AH,4CH
        INT 21H
    MAIN ENDP

	
KODIKAS ENDS

DEDOMENA SEGMENT  
    BUFFER DB 6 DUP(0)
    BUFFER2 DB 6 DUP(0)
    num1 db 0
    num2 db 0
    PROTROPI DB 'Eisagwgi leksis $'
    MEG DB 13,10,'O megaluteros einai o $'
    ISOI DB 'EINAI ISOI$'
    nl db 13,10,'$'

DEDOMENA ENDS   

    END MAIN 