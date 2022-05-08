TITLE maskHEX
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    MAIN PROC    
        MOV AX,DEDOMENA	
	    MOV DS,AX	
        
        ;Apo DEC se HEX h ALL_examsA_x1617_B_FIRSTex
        
        LEA DX,PROTROPI
        MOV AH,09H
        INT 21H
        
        CALL READHEXtoDEC      
                
        
     ;PRINT FIRST HEX (TO DEC)   
        LEA DX,APOT
        MOV AH,09H
        INT 21H
        
        MOV DH,BUFFER[1]
        MOV DL,BUFFER[0]         
        CALL PRINTHEX   ;Gia na ektiposo ton hex arithmo poy diavasame     
        
        
        
        ;GIA EMFANISI TOU ASCII TOU DEX
        MOV AH,0
        MOV AL,BUFFER[0]
        MOV BL,10H
        MUL BL
        
        ADD AL,BUFFER[1]
        
        MOV DL,AL
        MOV AH,02H
        INT 21H
        ;OUF OUF OUF TELOS THS EMFANISIS TOU ASCII TOU DEX
        
        LEA DX,eih
        MOV AH,09H
        INT 21H
        
     ;PRINT NUM   
        LEA DX,APOT
        MOV AH,09H
        INT 21H

        MOV DL,NUM
        CALL SPLITHEX   ;Gia na xoriso ton deytero hex arithmo
        CALL PRINTHEX   ;Gia na ektiposo ton deytero hex arithmo
       
        LEA DX,eih
        MOV AH,09H
        INT 21H
        
        MOV AH,4CH
        INT 21H
    MAIN ENDP

    
READHEXtoDEC PROC
        
        MOV SI,0        
        JMP V1
        
WRONG:  
        LEA DX, LATHOS
        MOV AH,09H
        INT 21H

V1:     
        MOV AH,08H
        INT 21H
        
        MOV CL,AL
        
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
;4 MSB of HEX number: DL
;4 LSB of HEX number: DH
    
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
    
    BUFFER DB 2 DUP<0>
    BUFFER2 DB 2 DUP<0> 
    N        DB 0
    NUM      DB 4AH
    AR1  DB 0
    AR2  DB 0
    DEKADA DB 0
    MONADA DB 0
    PROTROPI DB 'Eisagete ena HEX arithmo (2 psifiwn): $'
    LATHOS   DB 7,7,7,'$'
    PRAKSI   DB 10,13,'Dialekste mia mia praksi * H / : $'
    APOT     DB 10,13,'To apotelesma einai : $'
    eih      DB 'h$'
    

DEDOMENA ENDS

   
                       
                       
                       
    END MAIN 
