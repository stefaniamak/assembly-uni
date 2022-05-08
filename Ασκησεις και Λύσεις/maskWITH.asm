TITLE mask_with_suproutine
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA, SS:SOROS
    MAIN PROC    
        MOV AX,DEDOMENA	
	    MOV DS,AX	

        call yporoutina  
    
        MOV AH,4CH
        INT 21H
    MAIN ENDP

    yporoutina PROC
	
  
    RET
    yporoutina ENDP	
	
KODIKAS ENDS

DEDOMENA SEGMENT  


DEDOMENA ENDS

SOROS SEGMENT STACK
    DB 256 DUP(0)
SOROS ENDS    

    END MAIN 