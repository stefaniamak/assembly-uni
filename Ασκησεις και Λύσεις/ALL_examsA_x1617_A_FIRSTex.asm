TITLE ALL_examsA_x1617_A_FIRSTex
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    ARXI:   
        MOV AX,DEDOMENA	
	    MOV DS,AX	
         
         
        LEA DX,PROTROPI
	    MOV AH,09H	    ; Typwnoume to mhnyma prootropis
	    INT 21H                
        
        MOV SI, 7H
        
        
V1:     MOV AH, 08H     ; Diavasma
        INT 21H
        
        CMP AL, '0'
        JE SAVE
        
        CMP AL, '1'
        JE SAVE
        
        LEA DX,BEEP
	    MOV AH,09H	    ; Typwnoume to mhnyma lathous
	    INT 21H 
        JMP V1
               
SAVE:   MOV BUFFER[SI], AL                              
        
        MOV DL,BUFFER[SI]
	    MOV AH,02H	    ; Typwnoume to periexomeno tou Buffer
	    INT 21H
        
        DEC SI 
        CMP SI,7
       JB V1
       
        LEA DX,NEXTLINE
	    MOV AH,09H	    ; Afhnw mia seira keno
	    INT 21H
        INC SI
        
        MOV BX,0
        MOV DL, BUFFER[SI]
        SUB DL,30H
        INC SI          
        MOV BL,2
                 
V2:        
        MOV AL, BUFFER[SI]
        SUB AL,30H
        MUL BL

        ADD DX, AX

        SHL BX,1

        INC SI


        
CMP SI,8
JB V2        
        ;Gia na paroume kai ta 3a psifia ksexorista:     
                      
        MOV AL,DL           ; Metafero ton teliko arithmo sto AL 
        MOV AH,0            ; Midenizo to AH
    
        MOV CL,10	        ; Metafero 10 sto CL
	    DIV CL		        ; Diero AX me CL

	    MOV MONADA,AH       ; Metafero sti thesi mnimis MONADA to ypolipo tis dieresis
	                  
	                        ; Sto AL einai (idi) apothikeumenh h ekatontada mazi me thn dekada (to piliko tis dieresis)         
        MOV AH,0            ; Ksana midenizo ton AH
    
        MOV CL,10	        ; Metafero 10 sto CL
	    DIV CL              ; Diero AX me CL
        
        MOV EKATONTADA,AL   ;Metafero stin thesi mnymis EKATONTADA to piliko tis dieresis
	    MOV DEKADA,AH       ; Metafero sti thesi mnimis DEKADA to ypolipo tis dieresis
        
        
        
        ;Gia tis parakato 3eis -Emfaniseis-: 
            ; 1) Metafero sto DL to periexomenoo tis thesis mnimis
            ; 2) Prostheto thn ascii timi tou 0 (eite 30H eite48)
            ; 3) Metferoume ston AH to 2 gia na emfanisoume to periexomeno tou DL
            ; 4) Kaloume to leitourgiko systima na emfanisei stin othoni to periexomeno tou DL
        
        MOV DL,EKATONTADA       
	    ADD DL,30H 	                                                        
	    MOV AH,02H 	            
	    INT 21H
        
	    MOV DL,DEKADA         
	    ADD DL,30H 	                                                             
	    MOV AH,02H 	           
	    INT 21H		           
	
	    MOV DL,MONADA           
	    ADD DL,30H	            
	    MOV AH,02H	            
	    INT 21H		            
	    
	    
    
FINISH: 
        ;Omali eksodos sto DOS 
        MOV AH,4CH
        INT 21H
	
KODIKAS ENDS

DEDOMENA SEGMENT  

    BUFFER   DB 8 DUP(0)
    PROTROPI DB 'Dwse enan 8psifio diadiko arithmo: $'
    BEEP     DB 7,7,7, '$'
    NEXTLINE DB 10,13, '$'
    EKATONTADA DB 0
    DEKADA DB 0
    MONADA DB 0


DEDOMENA ENDS


    END ARXI 