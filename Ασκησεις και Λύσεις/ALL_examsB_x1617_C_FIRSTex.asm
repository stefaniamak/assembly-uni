TITLE mymaskwithYP10diko
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    MAIN PROC    
        MOV AX,DEDOMENA	
	    MOV DS,AX	

        LEA DX,PROTROPI
	    MOV AH,09H	    ; Typwnoume to mhnyma prootropis
	    INT 21H
        
        JMP READ
WRONG:        
        LEA DX,LATHOS
	    MOV AH,09H	    ; Typwnoume to mhnyma lathous
	    INT 21H 
	   
READ:   	   
        
        MOV AH, 08H     ; Diavasma kai 01h gia paralhlh emfanish
        INT 21H

        CMP AL, '0'
        JB WRONG        ;Enas elenxos
        
        CMP AL, '9'
        JA WRONG
        
        MOV BH,0
        MOV BL,AL ;Gia to ypoprogramma
        
        MOV DL,AL
        MOV AH,02H      ;Emfanisi eisagwgis
        INT 21H
 
        
        CALL YP
        MOV CX,AX
        
        LEA DX,APOT
	    MOV AH,09H	    ; 
	    INT 21H
        
        MOV DL,CH 
        
        CALL SPLITHEX
        CALL PRINTHEX 
        
        MOV DL,CL
        CALL SPLITHEX
        CALL PRINTHEX
          
        LEA DX,eih
	    MOV AH,09H	    ; 
	    INT 21H
        
        ;Omali eksodos sto DOS
        MOV AH,4CH
        INT 21H
    MAIN ENDP




    YP PROC
	    
	    MOV BH,0
	    SUB BL,30H
	    MOV DL,BL
	    
	    MOV AH,0
	    MOV AL,DL
	    MUL BL
	    
	    MOV BX,AX
	    MOV AL,DL
	    MUL BL
	
  
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
    BUFFER DB 8 DUP(0)
    PROTROPI DB 'Eisagete ena arithmo 0-9 : $'
    LATHOS DB 7,10,13,"WRONG!",10,13,"$" 
    APOT DB 10,13,"O arithmos ypsomenos ^3 sto 16adiko einai : $"
    eih DB 'h$'

DEDOMENA ENDS   

    END MAIN 