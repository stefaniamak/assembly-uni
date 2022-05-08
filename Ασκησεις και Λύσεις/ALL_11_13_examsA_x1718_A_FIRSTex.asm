TITLE mymaskwithYP10diko
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    MAIN PROC    
        MOV AX,DEDOMENA	
	    MOV DS,AX	    
        
        CALL READHEXtoDEC
        
        LEA DX,MSG1
	    MOV AH,09H	    ; Typwnoume to mhnyma prootropis
	    INT 21H
	    
	    MOV DL,BUFFER2[0]
        MOV AH,02H
        INT 21H
        
        MOV DL,BUFFER2[1]
        MOV AH,02H
        INT 21H
	    
	    LEA DX,MSG2
	    MOV AH,09H	    ; Typwnoume to mhnyma prootropis
	    INT 21H
        
        
        MOV DH,BUFFER[1]
        MOV DL,BUFFER[0]
        
        MOV AL,10H
        MUL DL
        
        ADD AL,DH
        
        MOV DL,AL        
        MOV AH,02H
        INT 21H  
        
        ;Omali eksodos sto DOS
        MOV AH,4CH
        INT 21H
    MAIN ENDP




    YP PROC
	
  
    RET
    YP ENDP	

READHEXtoDEC PROC
        
        MOV SI,0        
        JMP V1
        
WRONG:  
        LEA DX,LATHOS
        MOV AH,09H
        INT 21H

V1:     
        LEA DX,PROTROPI
	    MOV AH,09H	    ; Typwnoume to mhnyma prootropis
	    INT 21H

        
        MOV AH,08H
        INT 21H
        
        MOV CL,AL
        MOV BUFFER2[SI],AL
        
        CMP AL,'0'
         JB WRONG
         CMP AL,'9'
        JBE NUMBER
         CMP AL,'F'
         JA WRONG
        CMP AL,'A'
         JB WRONG        
         SUB AL,'A'-10
         JMP RIGHT
NUMBER: 
        SUB AL,30H

RIGHT:        
        MOV BUFFER[SI],AL
        MOV DL,CL
        MOV AH,02H
        INT 21H        
        
        INC SI        
        CMP SI,2
        JB V1
        
        RET
ENDP READHEXtoDEC

	
KODIKAS ENDS

DEDOMENA SEGMENT  
    BUFFER DB 8 DUP(0)
    BUFFER2 DB 2 DUP(0)
    PROTROPI DB 13,10,'Eisagete ena arithmo 0-9 A-F : $'
    MSG1 DB 13,10,'H ASCII tou $' 
    MSG2 DB ' einai to: $'
    LATHOS DB 7,10,13,"WRONG!$"

DEDOMENA ENDS   

    END MAIN        
    