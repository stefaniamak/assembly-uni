TITLE ALL_examsA_x1617_B_SECex
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    ARXI:   
        MOV AX,DEDOMENA	
	    MOV DS,AX	

        LEA DX,PROTROPI
        MOV AH,09H
        INT 21H
        
        MOV SI,0
        
        JMP V2

V1:     
        LEA DX,LATHOS
        MOV AH,09H
        INT 21H        
        

V2:        
        MOV AH, 01H     ; Diavasma
        INT 21H
        
        CMP AL, '&'
        JE FINISH
        
        CMP AL, 32
        JE V3
        
        CMP AL, 'A'
        JB V1
        
        CMP AL, 'Z'
        JBE V3
        
        CMP AL, 'a'
        JB V1
        
        CMP AL, 'z'
        JA V1                
        
        
V3:        
        MOV BUFFER[SI],AL
        INC SI
        
        CMP SI,15
        JB V2
                
FINISH: 
        CMP SI,0
        JNE NEXT
        
        LEA DX,NOINPUT
        MOV AH,09H
        INT 21H
        JMP ENDING
        
        
        
NEXT:        
        LEA DX,NEXTLIE
        MOV AH,09H
        INT 21H
        
        MOV BH,'+'
        MOV CX,SI
        MOV SI,0
        
V4:             
        MOV DL, BUFFER[SI]
        
        CMP DL,' '
        JE space        
        
        CMP DL,'Z'
        JBE KEF
        
        CMP BUFFER[SI],'a'
        JAE MIKR
        
space:  
        MOV DL,BH  ; GIA TO SPACEEEE
        INC BH
	    JMP EMF                
        
KEF:    
        SHL DL,1
        SUB DL,97
        JMP EMF    

MIKR:
        SHR DL,1
        ADD DL,17

EMF:       
        MOV AH,02H	    
	    INT 21H
        INC SI
        
        CMP SI,CX
        JB V4

ENDING:    
        MOV AH,4CH
        INT 21H
	
KODIKAS ENDS

DEDOMENA SEGMENT  

    
    
DEDOMENA ENDS
        
        BUFFER DB 15 DUP(0)
        PROTROPI DB 'Eisagete ena keimeno (max 15 xaraktires): $'
        LATHOS DB 10,13,'YEEEEEEEEEEEEEEEET $'
        NOINPUT DB 10,13,'Den exei ginei kamia eisagwgh. LUpamai gia thn parti sas. Ksout. Esxos. Ix. $'
        NEXTLIE DB 10,13,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,'$'
        
    END ARXI 