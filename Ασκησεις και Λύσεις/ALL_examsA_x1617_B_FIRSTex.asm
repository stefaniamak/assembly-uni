TITLE ALL_examsA_x1617_B_FIRSTex
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    MAIN PROC    
        MOV AX,DEDOMENA	
	    MOV DS,AX	

        LEA DX,PROTROPI
        MOV AH,09H
        INT 21H
        
        JMP V1
        
WRONG:  
        LEA DX, LATHOS
        MOV AH,09H
        INT 21H

V1:     
        MOV AH,08H
        INT 21H
        
        CMP AL,'0'
        JB WRONG
        CMP AL,'7'
        JA WRONG
        
        MOV N,AL
        MOV DL,N
        MOV AH,02H
        INT 21H
        
        LEA DX, PRAKSI
        MOV AH,09H
        INT 21H         
        
        MOV AH,01H
        INT 21H
        
        MOV BL,NUM

        MOV BH,AL

        CALL PRAKSIyp  

                
        
        LEA DX,APOT
        MOV AH,09H
        INT 21H
        
        MOV DL,AR1      
        CALL SPLITHEX   ;Gia na xoriso ton proto hex arithmo     
        CALL PRINTHEX   ;Gia na ektiposo ton proto hex arithmo
        
        MOV DL,AR2
        CALL SPLITHEX   ;Gia na xoriso ton deytero hex arithmo
        CALL PRINTHEX   ;Gia na ektiposo ton deytero hex arithmo
        
        LEA DX,eih
        MOV AH,09H
        INT 21H
        
        MOV AH,4CH
        INT 21H
    MAIN ENDP




PRAKSIyp PROC
	    
	    MOV CL,N
	    SUB CL,30H
	    
	    CMP BH,'*'
	    JE DIESI	    
	    
	    MOV BH,0	    
	    SHR BL,CL	; /
	    JMP skip   	    
DIESI:     
        MOV BH,0
        SHL BX,CL	; * 
        
skip:
        MOV AR1,BH
        MOV AR2,BL
        
        
    RET
PRAKSIyp ENDP
    
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
    
    N        DB 0
    NUM      DB 4AH
    AR1  DB 0
    AR2  DB 0
    DEKADA DB 0
    MONADA DB 0
    PROTROPI DB 'Eisagete ena arithmo 0-7: $'
    LATHOS   DB 10,13,'Lathos isagwgh, skanaprospathiste: $'
    PRAKSI   DB 10,13,'Dialekste mia mia praksi * H / : $'
    APOT     DB 10,13,'To apotelesma einai : $'
    eih      DB 'h$'
    

DEDOMENA ENDS

   
                       
                       
                       
    END MAIN 
    
    
    
    
    
    MOV AX,0
        
        LEA DX,APOT
        MOV AH,09H
        INT 21H
        
        MOV AL,BH           ; Metafero ton teliko arithmo sto AL 
        MOV AH,0            ; Midenizo to AH
    
        MOV CL,10H	        ; Metafero 10 sto CL
	    DIV CL		        ; Diero AX me CL

	    MOV DEKADA,AL
	    MOV MONADA,AH       ; Metafero sti thesi mnimis MONADA to ypolipo tis dieresis
	                 
        
        MOV DL,DEKADA
        ADD DL,30H
        MOV AH,02H
        INT 21H
        
        MOV DL,MONADA
        ADD DL,30H
        MOV AH,02H
        INT 21H
        
        MOV AX,0
        
        MOV AL,BL           ; Metafero ton teliko arithmo sto AL 
        MOV AH,0            ; Midenizo to AH
    
        MOV CL,10	        ; Metafero 10 sto CL
	    DIV CL		        ; Diero AX me CL

	    MOV DEKADA,AL
	    MOV MONADA,AH       ; Metafero sti thesi mnimis MONADA to ypolipo tis dieresis
	                 
        
        MOV DL,DEKADA
        ADD DL,30H
        MOV AH,02H
        INT 21H
        
        MOV DL,MONADA
        ADD DL,30H
        MOV AH,02H
        INT 21H       
        
        
        ;2
        
        
        
        
        
        SHR BX,1
        
        MOV DL,BH
        MOV AH,02H
        INT 21H
        
        MOV BH,0
        SHL BX,1
        
        MOV DL,BH
        MOV AH,02H
        INT 21H
        
        MOV BX,0
        MOV BL,AR2
        SHL BX,1
        
        MOV DL,BH
        MOV AH,02H
        INT 21H
        
        MOV BH,0
        SHL BX,1
        
        MOV DL,BH
        MOV AH,02H
        INT 21H 
        
        ;H
        
        MOV AL,BL
        AND AL,0FH
        MOV AR2,AL
        
        AND BL,0F0H
        SHR BL,4
        MOV AR1,BL
        
        MOV DL,AR1
        ADD DL,30H
        MOV AH,2
        INT 21H
        
        MOV DL,AR2
        ADD DL,30H
        MOV AH,2
        INT 21H