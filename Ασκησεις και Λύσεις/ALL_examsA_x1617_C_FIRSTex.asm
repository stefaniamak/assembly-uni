TITLE ALL_examsA_x1617_C_DIRSTex
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA, SS:SOROS
    MAIN PROC    
        MOV AX,DEDOMENA	
	    MOV DS,AX	
        
        LEA DX,PROTROPI
        MOV AH,09H       ;PROTROPI
        INT 21H
        
        MOV CX,2
        MOV SI,0
        JMP V1
        
LATHOS:
        LEA DX,WRONG
        MOV AH,09H       
        INT 21H
        
        
V1:
        MOV AH,08H
        INT 21H
        
        CMP AL,'A'
        JB LATHOS
        
        CMP AL,'Z'
        JA LATHOS        
        
        MOV BUFFER[SI],AL
        INC SI
        
        MOV DL,AL
        MOV AH,02H	   ;Emfanisi sostoy grammatos 
	    INT 21H
        
LOOP V1
        
        MOV BL,BUFFER[0]
        MOV BH,BUFFER[1]
        
        MOV DX,BX                
        CALL YP  
        
        MOV AR1,AH
        MOV AR2,AL
        
        LEA DX,ENDINGS
        MOV AH,09H       
        INT 21H
        
        MOV DL,AR1
        CALL SPLITHEX
        CALL PRINTHEX
        
            MOV AH, 2
            INT 21H
    
            MOV DL, DH
            MOV DH, 2
            INT 21H
        
        MOV DL,AR2
        CALL SPLITHEX
        CALL PRINTHEX
            
            MOV AH, 2
            INT 21H
    
            MOV DL, DH
            MOV DH, 2
            INT 21H
            
        LEA DX,eih
        MOV AH,09H       
        INT 21H
    
        MOV AH,4CH
        INT 21H
    MAIN ENDP




    YP PROC
    
        MOV AL,DL
        ADD AL,DH        
        MUL AL	
  
    RET
    YP ENDP	



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
        JMP ex
    
letDH:    
        ADD DH, 'A'-10
     
ex: 
        
        
        RET    
    PRINTHEX ENDP


	
KODIKAS ENDS

DEDOMENA SEGMENT  
    
    AR1 DB 0
    AR2 DB 0
    PROTROPI DB 'Na dwthoun 2 kefalaia grammata: $'
    WRONG DB 10,13,'Lathos eisagwgi, prospathiste ksana: $'
    ENDINGS DB 10,13,'Apotelesma: $'
    eih DB 'h$' 
    BUFFER DB 2 DUP<0>
     

DEDOMENA ENDS   

    END MAIN 