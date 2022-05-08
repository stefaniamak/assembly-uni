TITLE mask_with_suproutine
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA, SS:SOROS
    MAIN PROC    
        MOV AX,DEDOMENA	
	    MOV DS,AX	


        LEA DX,PROTROPI
        MOV AH, 09H        ; Emfanisi munimatos PROTROPIS
        INT 21H
        
        MOV SI, 0

          
          
V1:     MOV AH,01H         ; Anagnosi keimenou, apothikeuete sto AL
        INT 21H
                 
        MOV BUFFER[SI], AL
        INC SI
        
        
        CMP AL, 60        ; Elenxo an exei patithei to '<'
        JE V2
        CMP SI,50          ; Elenxo an exei gemisei o BUFFER
        JB V1
        
        
V2:     
        MOV CX,SI
        
        LEA DX,REPL
	    MOV AH,09H
	    INT 21H
	
	    MOV AH,01H
	    INT 21H
	    
	    MOV BH,AL
	    
	    MOV SI,0
        
        CALL CHAR_REPLACE  ; Kalo thn CHAR_REPLACE
        
        MOV AH,4CH
        INT 21H
    MAIN ENDP
    
    
    
    CHAR_REPLACE PROC


                        ;Anazitisi ston pinaka BUFFER gia to gramma
		
V3:
        CMP BUFFER[SI],BH
        JE YP
    	
    	CMP SI,CX
    	INC SI
    	
    	JB V3
    	
    	
                        ;An den exei paei sto YP mexri na teleiwsei o elenxos tou pinaka, tote den yparxei o xaraktiras ston pinaka.
    	
    	LEA DX,DENYPAR
    	MOV AH,09H
    	INT 21H
    	
    	RET
	
                        ;Vrethike, erwtisi kai eisagwgi gia thn antikatastasi

YP:
        LEA DX,YPARXEI
        MOV AH,09H
        INT 21H
        
        MOV BL,AL
        ADD BL,30H
        
        MOV AH,01H
        INT 21H
        
        MOV SI,0 
                        ;Antikatastasi ston BUFFER 
        
ANT:    
        
        CMP BUFFER[SI],BH
        JNE V4
        
        MOV BUFFER[SI],AL
                 
V4:     
        INC SI
        CMP SI,CX
        JB ANT
        
                        ;Emfanisi
        
        MOV SI,0                
     
        LEA DX,TELOS
        MOV AH,09H
        INT 21H
        
V5:        
        MOV DL,BUFFER[SI]
        MOV AH,02H
        INT 21H
        
        INC SI
        
        CMP SI,CX
        JB V5            
  
        RET
    CHAR_REPLACE ENDP	
	
KODIKAS ENDS







DEDOMENA SEGMENT  
    
    BUFFER   DB 50 DUP(0)
    PROTROPI DB       'Plhkrologise ena keimeno me MAX 50 xarakthres (termatise thn eisagwgi pliktrologontas "<": $'   
    REPL     DB 10,13,'Eisagete xaraktira gia anazitisi:  $'
    YPARXEI  DB 10,13,'Yparxei! Replace with: $'
    DENYPAR  DB 10,13,'Den uparxei autos o xaraktiras. $'
    TELOS    DB 10,13,'The new string is: $'


DEDOMENA ENDS    

    END MAIN 