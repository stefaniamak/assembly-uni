TITLE ALL_examsB_x1617omadaA-b
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    ARXI:   
        MOV AX,DEDOMENA	
	    MOV DS,AX	

        LEA DX,PROTROPI
        MOV AH,09H
        INT 21H
        
        MOV SI,0
        
V1:     
        MOV AH,01H
        INT 21H
        
        CMP AL,'&'
        JE FIN
        
        CMP AL,32
        JE SAVE
        
        CMP AL,'A'
        JB V1
        
        CMP AL,'Z'
        JBE SAVE               
        
        JMP V1
        
                
SAVE:   
        MOV BUFFER[SI],AL
        INC SI
        
        CMP SI,15
        JB V1               
        
                
FIN:    
        MOV CX,SI
        JCXZ ZERO
         
        MOV SI,0           
                    
V2:     
        MOV DL,BUFFER[SI]
         
        CMP DL,32
        JE SPACE
        
        MOV AH,0         
        MOV AL,DL
         
        MOV BL,2         ;AX/BL
        DIV BL
         
        CMP AH,0         ;Ypolipo
        JE KEF
         
        ADD DL,20H       ;Metatropi apo kefalaia se mikra
         
        MOV BL,DL
         
        LEA DX,GRAMMI
        MOV AH,09H
        INT 21H 
         
        MOV DL,BL
         
        MOV AH,02H
        INT 21H
         
        INC SI
         
         
V3:     
        LOOP V2
         
        JMP EXIT
         
KEF:    
        MOV BL,DL
         
        ADD BL,4
         
        LEA DX,GRAMMI
        MOV AH,09H
        INT 21H
         
        MOV DL,BL
         
        MOV AH,02H
        INT 21H
         
        INC SI
         
        JMP V3
         

SPACE:   
        MOV BH,'+'
         
        LEA DX,GRAMMI
        MOV AH,09H
        INT 21H
         
        MOV DL,BH         
        MOV AH,02H
        INT 21H         
         
        INC SI
         
        JMP V3
         
         
ZERO:   
        LEA DX,NOMES
        MOV AH,09H
        INT 21H         
                                            
    
EXIT:   
        MOV AH,4CH
        INT 21H
	
KODIKAS ENDS

DEDOMENA SEGMENT
    BUFFER DB 15 DUP(0)  
    PROTROPI DB "EISAGWGH KEIMENOU(MEXRI 15 XARAKTIRES): $"
    NOMES DB 10,13,"DEN EISAGATE KEIMENO. $"
    GRAMMI DB 10,13,"$"

DEDOMENA ENDS


    END ARXI 