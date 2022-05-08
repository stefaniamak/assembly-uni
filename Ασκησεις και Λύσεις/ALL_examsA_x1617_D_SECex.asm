TITLE ALL_examsA_x1617_D_SECex
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    MAIN PROC    
        MOV AX,DEDOMENA	
	    MOV DS,AX	
        
        MOV SI,0
        MOV BH,5AH      ;To Z
        MOV BL,61H      ;To a

V:        

        MOV DL,BH
        MOV AH,02H      ;Emfanisi kefalaiou
        INT 21H
 
        MOV DL,BL
        MOV AH,02H      ;Emfanisi mikrou
        INT 21H
  
        SUB DL,BH       ;Gia ton arithmo      
                
        MOV KEF,BH
        MOV MIK,BL
        
        MOV BL,DL
        CALL PSIFIA2
        
        MOV BH,KEF
        MOV BL,MIK
        
        DEC BH          ;Epomeno kefalaio
        INC BL          ;Epomeno mikro
        
        
      
        INC SI
CMP SI,26
JB V      
        
        ;Omali eksodos sto DOS
        MOV AH,4CH
        INT 21H
    MAIN ENDP

PSIFIA2 PROC
    ;Parameter: BL
                    
        MOV AL,BL           ; Metafero ton teliko arithmo sto AL
        MOV AH,0            ; Midenizo to AH
    
        MOV CL,10	        ; Metafero 10 sto CL
	    DIV CL		        ; Diero AX me CL

	    MOV DEKADA,AL       ; Metafero sti thesi mnimis DEKADA to ypolipo tis dieresis
	    MOV MONADA,AH       ; Metafero sti thesi mnimis MONADA to ypolipo tis dieresis
        
        CMP DEKADA,0
        JE NODEK1
	    
	    ;Gia tis parakato 2o -Emfaniseis-: 
            ; 1) Metafero sto DL to periexomenoo tis thesis mnimis
            ; 2) Prostheto thn ascii timi tou 0 (eite 30H eite 48)
            ; 3) Metferoume ston AH to 2 gia na emfanisoume to periexomeno tou DL
            ; 4) Kaloume to leitourgiko systima na emfanisei stin othoni to periexomeno tou DL
	    
	    MOV DL,DEKADA       
	    ADD DL,30H 	                                                            
	    MOV AH,02H 	        
	    INT 21H
	    
	    		        
NODEK1:	
	    MOV DL,MONADA       
	    ADD DL,30H	       
	    MOV AH,02H	        
	    INT 21H
	    
	    LEA DX,katwPiso
        MOV AH,09H
        INT 21H		        
	    
	    CMP DEKADA,0  
	    JE NOKENO
	     LEA DX,piso
         MOV AH,09H
         INT 21H
NOKENO:	    
    RET
    PSIFIA2 ENDP
	
KODIKAS ENDS

DEDOMENA SEGMENT  
        
    katwPiso DB 10,8,8,'$'
    piso DB 8,'$'
    EKATONTADA DB 0
    DEKADA DB 0
    MONADA DB 0
    KEF DB 0
    MIK DB 0
        
DEDOMENA ENDS   

    END MAIN 