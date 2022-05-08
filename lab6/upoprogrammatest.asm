TITLE askisi4
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA, SS:SOROS
    MAIN PROC NEAR   
        MOV AX,DEDOMENA	
	    MOV DS,AX	    
	    

        CALL TESTYPOP
        MOV AH,4CH
        INT 21H
    MAIN ENDP

    TESTYPOP PROC NEAR
        
        LEA DX,MES      ;Emfaish munhmatos mesa apo to upoprogramma
        MOV AH,09h      
        INT 21h
        
        RET
    TESTYPOP ENDP    
    
        
	
KODIKAS ENDS

DEDOMENA SEGMENT
      
    MES DB "TO TEST HTAN EPITYXES $" 

DEDOMENA ENDS
    
    SOROS SEGMENT STACK
        DB 256 DUP(0)
    SOROS ENDS
    

    END MAIN 