TITLE mymaskfor0and1
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    MAIN PROC    
        MOV AX,DEDOMENA	
	    MOV DS,AX	

        LEA DX,PROTROPI
	    MOV AH,09H	    ; Typwnoume to mhnyma prootropis
	    INT 21H
        
        ;Apo ALL_examsA_x1617_A_FIRSTex
        
        call YP2diko
        
        MOV NUM,DL
        
        LEA DX,APOT
	    MOV AH,09H	    ; Typwnoume to mhnyma apotelesma
	    INT 21H 
        
        MOV DH,0
        MOV DL,NUM
        call PSIFIA3
        
        ;Omali eksodos sto DOS
        MOV AH,4CH
        INT 21H
                
    MAIN ENDP




    YP2diko PROC
	    MOV SI, 7H      ; Ksekinaw apo to MSB kai teleiwnw me to LSB
        
        
V1:     MOV AH, 08H     ; Diavasma
        INT 21H
        
        CMP AL, '0'
        JE SAVE
                        ; Elenxw an einai 0 h 1
        CMP AL, '1'
        JE SAVE
        
        LEA DX,BEEP
	    MOV AH,09H	    ; Typwnoume to mhnyma lathous
	    INT 21H 
        JMP V1
               
SAVE:   MOV BUFFER[SI], AL   ; Apothikeyetai h swsti timi                           
        
        MOV DL,BUFFER[SI]
	    MOV AH,02H	    ; Typwnoume to periexomeno tou Buffer, diladi ton arithmo 0 h 1 pou molis pliktologisame
	    INT 21H          
                        
        DEC SI          ; Meiwnw to SI
        CMP SI,7        
       JB V1
       
        LEA DX,NEXTLINE
	    MOV AH,09H	    ; Afhnw mia seira keno
	    INT 21H
        INC SI
        
        MOV BX,0           ;Mydenizw ton BX
        

; Xrisimopoiw ton DX gia thn apothikeysh tou telikou arithmoy
 
        MOV DL, BUFFER[SI] ; Metaferw kateythian thn prwti timi sto DL, afou BUFFER[0]*2^0=BUFFER[0]*1 
        SUB DL,30H         ; Afairw thn ascii tou '0' gia na parw ton arithmo
        INC SI             ; Afksanw to SI
        MOV BL,2           ; Xrisimopoiw to BL gia to 2^N (opou N=0,1,2,3...)
                 
V2:        
        MOV AL, BUFFER[SI] ; Metaferw tin timi tou BUFFER[SI] ston AL
        SUB AL,30H         ; Afairw thn ascii tou '0' gia na parw ton arithmo
        MUL BL             ; BL * AL = AX | Opou BL to 2^N, AL to 0 h 1, kai AX to apotelesma

        ADD DX, AX         ; Prosthetw to apotelesma AX ston teliko arithmo

        SHL BX,1           ; Kanw *2 ton BX, gia na parw thn "epomeni timi" tou 2^N

        INC SI
        
    CMP SI,8
    JB V2      
  
    RET
    YP2diko ENDP	

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
    BUFFER   DB 8 DUP(0)
    NUM      DB 0
    PROTROPI DB 'Dwse enan 8psifio diadiko arithmo: $'
    APOT     DB 10,13,'The number is: $'
    BEEP     DB 7,7,7, '$'
    NEXTLINE DB 10,13, '$'
    EKATONTADA DB 0
    DEKADA DB 0
    MONADA DB 0

DEDOMENA ENDS   

    END MAIN 