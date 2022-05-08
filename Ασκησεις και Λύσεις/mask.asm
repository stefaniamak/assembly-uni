TITLE mask
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    ARXI:   
        MOV AX,DEDOMENA	
	    MOV DS,AX	
        
        LEA DX,MINIMA     ;zhtaei n dwsei arithmo
        MOV AH,9
        INT 21H
        
        MOV AH,01H    	; Eisagoume xarakthra apo to plhktrologio me parallhlh emfanish, 08H gia na mhn emfanizetai
	    INT 21H		    ; H ASCII timh tou xarakthra apothikeuetai ston AL
        

        
    
        MOV AH,4CH
        INT 21H
	
KODIKAS ENDS

DEDOMENA SEGMENT  
        
        MNMPROTROPIS DB 'Give me a number between 2-9: $'

DEDOMENA ENDS


    END ARXI 