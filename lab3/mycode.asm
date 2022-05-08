TITLE SIMPLE_LAB3_EX1
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    ARXI:   
        MOV AX,DEDOMENA	
	    MOV DS,AX	
        
        LEA DX,MINIMA           ;Emfanizei to mnm
        MOV AH,9
        INT 21H
        
        MOV AL, N               ;N^2
        MOV DL, N
        MUL DL 
        
        MOV BX, AX              ;Adeiazw to AX gia thn epomenh praksh
        
        MOV AL, 2               ;2*N
        MOV CL, N
        MUL CL 
        
        SUB BX, AX              ;N^2 - 2*N
    
        INC BX
        
        MOV CX, BX              ;BX+1
        
        MOV AX, BX              ;AX/BL = ARITHMOS/10
        MOV BL, 10              ;Pairnw ksexorista ta psifia
        DIV BL                  ;Sto AL einai to prwto kai sto AH to deutero
        
        MOV BL, AH              ;Adeiasma tou AH
        
        MOV DL, AL              ;Emfanish tou prwtou psifiou
        ADD DL, 30H
        MOV AH, 02H
        int 21h
        
        MOV DL, BL              ;Emfanish tou deuterou psifiou
        ADD DL, 30H
        MOV AH, 02H
        int 21h
        
;       MOV DL, BL              ;Emfanish tou arithmou olou mazi
;	    ADD DL, 30h
;	    MOV AH, 02h
;	    int 21h
	    
	    
KODIKAS ENDS

DEDOMENA SEGMENT  
    N DB 5
    MINIMA DB 'TO APOTELESMA EINAI: ', 10, 13, 7, '$'
DEDOMENA ENDS


    END ARXI 