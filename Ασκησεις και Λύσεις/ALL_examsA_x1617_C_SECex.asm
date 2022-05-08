TITLE ALL_examsA_x1617_C_SECex
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    ARXI:   
        MOV AX,DEDOMENA	
	    MOV DS,AX	
        
        MOV SI,0
V:        
        CMP SYMVOLO[SI],'$'
        JE EXIT
        
        CMP SYMVOLO[SI],'!'
        JE THAV        
        CMP SYMVOLO[SI],','
        JE THAV                
        CMP SYMVOLO[SI],'.'
        JE THAV
        
        CMP SYMVOLO[SI],'A'
        JB space
        CMP SYMVOLO[SI],'z'
        JA space
        CMP SYMVOLO[SI],'Z'
        JBE GR
        CMP SYMVOLO[SI],'a'
        JAe GR
space:        
        MOV AL,DN
        INC AL
        MOV DN,AL
        JMP next
        
THAV:
        MOV AL,BN
        INC AL
        MOV BN,AL
        JMP next

GR:        
        MOV AL,CN
        INC AL
        MOV CN,AL
        
next:        
        INC SI
                
JMP V 

EXIT:
        LEA DX,A
        MOV AH,09H
        INT 21H
        
        MOV AX,0          ;A
        MOV AX,SI
        MOV AN,AL
        MOV BL,AN
        CALL PSIFIA2
         
         
        LEA DX,B
        MOV AH,09H
        INT 21H           ;B
        
        MOV BL,BN
        CALL PSIFIA2
         
         
        LEA DX,C
        MOV AH,09H
        INT 21H           ;C
        
        MOV BL,CN
        CALL PSIFIA2
         
         
        LEA DX,D
        MOV AH,09H
        INT 21H           ;D
        
        MOV BL,DN
        CALL PSIFIA2
        
        
        MOV AH,4CH
        INT 21H
	
KODIKAS ENDS

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
	    
    RET
    PSIFIA2 ENDP



DEDOMENA SEGMENT  
     
    SYMVOLO DB 'PATA EEE !$'  ;-> SAW 0 5.$ -> 83,65,87,32,48,32,53,46,36
    A DB       'To mikos tis sumvoloseiras einai: $'
    B DB 10,13,'To plithos twn sumvolwn stiksis tis sumvoloseiras einai: $'
    C DB 10,13,'To plithos grammatwn tou latinikou alfavitou ths sumvoloseiras einai: $'
    D DB 10,13,'O sunolikos arithmos twn emfanisewn tou xarakthra space einai: $'
    AN DB 0
    BN DB 0
    CN DB 0
    DN DB 0 
    
    DEKADA DB 0
    MONADA DB 0 

DEDOMENA ENDS


    END ARXI 