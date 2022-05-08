TITLE mask
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    ARXI:   
        MOV AX,DEDOMENA	
	    MOV DS,AX	



        
    
        MOV AH,4CH
        INT 21H
	
KODIKAS ENDS

DEDOMENA SEGMENT  


DEDOMENA ENDS


    END ARXI 