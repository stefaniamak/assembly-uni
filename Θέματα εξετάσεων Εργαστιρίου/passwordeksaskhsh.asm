TITLE mask
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    ARXI:   
        MOV AX,DEDOMENA	
	    MOV DS,AX	
OV:        
        LEA DX,MNM1
	    MOV AH,09H	; Typwnoume to mhnyma oti theloume keimeno
	    INT 21H	
	    
	    MOV SI,0	; Eisagoume arxiki timi ston SI pou ton xrisimopoio san deikti mnimis     
E1:        
        MOV AH,08H  ; Eisagoume xarakthra apo to plhktrologio me parallhlh emfanish, 08H gia na mhn emfanizetai
	    INT 21H		; H ASCII timh tou xarakthra apothikeuetai ston AL
        
        CMP AL,13
        JE CHECK
        
        MOV BUFFER[SI],AL; Metaferoume to xaraktira sti mnimi sti thesi "Buffer+timi tou SI"
	    INC SI		; Afksanoume ton deikti mnimis kata ena
        
        LEA DX,PAPAKI
	    MOV AH,09H	; Typonoume '@' sth thesh tou grammatos
	    INT 21H
           
        CMP SI,20
        JNE E1      ; Epanalambanei apo to E1 oso to SI<>20
        
CHECK: ;Na elenksei an o kwdikos einai swstos  DI      
        
        CMP SI,6
        JNE WRONG  
        
        MOV CX,6
        MOV SI,0
        
E2:      
        MOV AL,BUFFER[SI]
        MOV BL,CODE[SI]
        CMP AL,BL
        JNE WRONG
        
        INC SI        
LOOP E2              ; An den bgei apo to Loop kai gia ta 6 grammata, tote
                     ; shmainei oti o kwdikos einai swstos
                    
        ;Auto tha treksei mono an o kwdikos einai swstos
         
        LEA DX,MNMCORRECT
	    MOV AH,09H	; Emfanizoume pws o kwdikos einai swstos
	    INT 21H
        
        JMP EXIT
        
WRONG:  
        LEA DX,MNMWRONG
	    MOV AH,09H	; Emfanizoume pws o kwdikos einai lathos
	    INT 21H
        
        MOV AH,08H  ; Eisagoume xarakthra apo to plhktrologio me parallhlh emfanish, 08H gia na mhn emfanizetai
	    INT 21H		; H ASCII timh tou xarakthra apothikeuetai ston AL
        
        CMP AL,'Y'
        JNE EXIT 
        
        MOV CX,SI
        MOV SI,0
        MOV AL,0
        E3:
            MOV BUFFER[SI],AL ; Mudenizw ton buffer
	        INC SI
	    LOOP E3
        JMP OV
        
EXIT:
        MOV AH,4CH  ; Eksodos sto leitoyrgiko systhma
        INT 21H
	
KODIKAS ENDS

DEDOMENA SEGMENT  
         BUFFER   DB 20 DUP(0) ; Dilosi enos pinaka me onoma Buffer 20 theseon typou Byte
         CODE     DB 1,2,3,1,2,3
         CODELENGTH DB 6
         MNM1 DB 'Type the Password: $'
         MNMCORRECT DB 10,13,'Log In Successful',10,13,'$'
         MNMWRONG DB 10,13,'Log In Failed',10,13,'Try again? Press Y $'
         PAPAKI DB '@$' 
DEDOMENA ENDS


    END ARXI 