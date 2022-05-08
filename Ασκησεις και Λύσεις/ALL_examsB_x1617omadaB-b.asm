TITLE ALL_examsB_x1617omadaB-b
KODIKAS SEGMENT PUBLIC
ASSUME CS:KODIKAS, DS:DEDOMENA
ARXH:
	    MOV AX,DEDOMENA 
	    MOV DS,AX	
    
  	    LEA DX,PROTROPI
	    MOV AH,09H	
	    INT 21H	  
	    
	    MOV SI,0
	    
V1:     MOV AH,01H
        INT 21H
        
        CMP AL,40H
        JE ELEGXOS
               
        CMP AL,'A'	 
	    JB V1	

	    CMP AL,'Z'	 
	    JBE SAVE		
    
        CMP AL,'a'  
        JB V1       
    
        CMP AL,'z'  
        JA V1   	    
	    
	    
SAVE:   MOV BUFFER[SI],AL
         
        INC SI
        
        CMP SI,10
        JE ELEGXOS
        
        JMP V1 	    
	    
ELEGXOS: MOV CX,SI
         JCXZ TELOS	    
	    
	     MOV SI,0 
	     
	     LEA DX,MESSAGE
	     MOV AH,09H
	     INT 21H
	     
V2:      MOV DL,BUFFER[SI]	     
	            
	     MOV AH,0
	     MOV AL,DL
	     MOV BL,2
	     
	     DIV BL
	     
	     CMP AH,0
	     JE ARTIOS
	               
	               
	     SHR DL,2
	     
	     ADD DL,32
	     
	     MOV AH,02H
	     INT 21H
	     
	     INC SI	      	               

V3:      LOOP V2 

         JMP EXIT
	              
	              
ARTIOS:  ADD DL,16
         SHR DL,1
         
         MOV AH,02H
         INT 21H
         
         INC SI
         
         JMP V3 	     
	     
	            
	    
TELOS:  LEA DX,NOINPUT
        MOV AH,09H
        INT 21H	    
	    
	    
	    
EXIT:   MOV AH,4CH	
    	INT 21H

KODIKAS ENDS

DEDOMENA SEGMENT
	BUFFER   DB 10 DUP(0) 
    PROTROPI DB 'Eisagete mia leksi mexri 10 grammata("@" gia telos):  $';
	MESSAGE  DB 10,13,10,13,'H Kryptografimeni leksi einai: $' 
	NOINPUT  DB 10,13,'Den eisagate kanena charaktira. Telos programmatos$';						
DEDOMENA ENDS

	END ARXH 	    
	    