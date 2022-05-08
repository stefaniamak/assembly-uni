;Makrygiannaki Stefania

TITLE mask
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    ARXI:   
        MOV AX,DEDOMENA	
	    MOV DS,AX	
        
        LEA DX,MNMPROTROPIS     ; zhtaei n dwsei arithmo
        MOV AH,9
        INT 21H  
        
        JMP INSERT
        
ERROR:
        LEA DX,MES_LATHOS      ; Emfaish munhma lathous
        MOV AH,09h      
        INT 21h
  
INSERT:        
        MOV AH,08H    	; Eisagoume xarakthra apo to plhktrologio me parallhlh emfanish, 08H gia na mhn emfanizetai
	    INT 21H		    ; H ASCII timh tou xarakthra apothikeuetai ston AL
        
        CMP AL,'2'
        JB ERROR
        
        CMP AL,'9'
        JA ERROR
        
        MOV DL, AL      
	    MOV AH, 02h     ;Emfanish ths ekxorisis  
	    INT 21h
        
        MUL DL          ; AX=AL*DL 
        
        
        CMP AX,65       
        JB NOTA         ; An den einai gramma, pane sto NOTA
            ADD AX,32   ; Metatrepoume to xaraktira apo Kefalaio se Mikro
            
            LEA DX,MNM1 
            MOV AH,9h    ; Grafei oti einai Gramma
            INT 21H

            MOV DX, AX
                
	        MOV AH, 02h ;Emfanish tou ASCII ekxorisis  
	        INT 21h
            
            JMP EXIT
NOTA:
        CMP AX,31
        JA NOTB         ; An den einai sumbolo h arithmos, pane sto NOTB
        
        LEA DX,MNM2 
        MOV AH,9h    ; Grafei oti einai Arithmos h Symvolo
        INT 21H
        
        MOV DX, AX 
        ADD DX, 30H     
	    MOV AH, 02h  ;Emfanish tou ASCII ekxorisis  
	    INT 21h
        
        JMP EXIT      
NOTB:   

        LEA DX,MNM3 
        MOV AH,9    ; Grafei oti den einai ektyposimos xaraktiras
        INT 21H

     
EXIT:        
        MOV AH,4CH
        INT 21H
	
KODIKAS ENDS

DEDOMENA SEGMENT  
        
        MNMPROTROPIS DB 'Grapse mia timi sta plaisia 2-9: $'
        MES_LATHOS: DB 10, 13,'ERROR eisagogi', 10, 13,'$'
        MNM1 DB 10, 13,'Einai gramma: $'
        MNM2 DB 10, 13,'Einai sumbolo h arithmos: $'
        MNM3 DB 10, 13,'Den einai ektyposimos xaraktiras: $'

DEDOMENA ENDS


    END ARXI 