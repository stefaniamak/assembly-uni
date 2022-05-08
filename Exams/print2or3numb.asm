TITLE printNumb
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    MAIN PROC    
        MOV AX,DEDOMENA	
	    MOV DS,AX	

        
        MOV BL,N1
        CALL PSIFIA2
        
        MOV DL,N2
        CALL PSIFIA3  
    
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
	    
    RET
    PSIFIA2 ENDP

    PSIFIA3 PROC
    ;Parameter: DL
        
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
            ; 2) Prostheto thn ascii timi tou 0 (eite 30H eite 48)
            ; 3) Metferoume ston AH to 2 gia na emfanisoume to periexomeno tou DL
            ; 4) Kaloume to leitourgiko systima na emfanisei stin othoni to periexomeno tou DL
        
        CMP EKATONTADA,0
        JE NOEK
        
        MOV DL,EKATONTADA       
	    ADD DL,30H 	                                                        
	    MOV AH,02H 	            
	    INT 21H
NOEK:        
	    CMP DEKADA,0
	    JE NODEK2
	    
	    MOV DL,DEKADA         
	    ADD DL,30H 	                                                             
	    MOV AH,02H 	           
	    INT 21H		           
NODEK2:	
	    MOV DL,MONADA           
	    ADD DL,30H	            
	    MOV AH,02H	            
	    INT 21H		            	
  
    RET
    PSIFIA3 ENDP	



	
KODIKAS ENDS

DEDOMENA SEGMENT  
    BUFFER DB 8 DUP(0)
    EKATONTADA DB 0
    DEKADA DB 0
    MONADA DB 0
    N1 DB 15
    N2 DB 234
    PROTROPI DB 'SOMETHING SOMETHING $'

DEDOMENA ENDS   

    END MAIN 