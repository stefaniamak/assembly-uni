TITLE ask3
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    ARXI:   
        MOV AX,DEDOMENA	
	    MOV DS,AX 
	    
	    Buffer db 40 dup (0) ; Dhlwsh prosorinhs mnhmhs
	    MOV CX, 40	
	    LEA bx
	    
        JMP SWSTO               
LATHOS:
        LEA DX,MES_LATHOS      ;Emfaish munhma lathous
        MOV AH,09h      
        INT 21h
SWSTO:        
        LEA DX,MES      ;Emfaish arxhkou munhmatos
        MOV AH,09h      
        INT 21h
        
        MOV ah, 01h     ; Klhsh tou DOS gia eisagwgh xarakthra apo to plhktrologio
                        ; autos o xarakthras apothikeuetai sto AL
        INT 21h         ; diakoph tou DOS
        
        CMP al, 13      ; Elenxw an einai Enter
        JE EINAIENTER   ; An einai equal na pas sto EINAIENTER
        
        CMP al, 32      ; Elenxw an einai Space
        JE EISAGWGH     ; An einai pane sthn EISAGWGH
        
        CMP al, 65      ; Elenxw an einai mikrotero apo to A [se ASCII]
        JB LATHOS       ; An einai pane sto LATHOS
        
        CMP al, 90      ; Elenxw me to 90
        JB EISAGWGH     ; An einai mikrotero, pane sto EISAGWSH
        
        CMP al, 122
        JA LATHOS
        
        CMP al, 97
        JA EISAGWGH
        
        LEA DX,MES_TEST   ;TEST
        MOV AH,09h      
        INT 21h 
        
EISAGWGH:  

        LEA DX,MES_TEST2    ;TEST
        MOV AH,09h      
        INT 21h 
        
        MOV [bx], al
        INC bx 
        DEC CX
        
        LOOP SWSTO

EINAIENTER: 
        
        CMP CX, 40
        JNE OXIADIO
            LEA DX,MES_EINAIENTER      ;Emfaish arxhkou munhmatos OTI DEN EGINE KAMIA PLHKTTROLOGISH
            MOV AH,09h      
            INT 21h        
        OXIADIO: 
            MOV CX, BX
            EPANAL:
                mov dl, [bx]
                inc bx

    
        MOV AH,4CH
        INT 21H
	
KODIKAS ENDS

DEDOMENA SEGMENT  
    
       PINAKAS DB 40 dup(0)
    
       MES DB 'Na ginei pliktrologish', 10, 13,' $' 
       MES_EINAIENTER DB 'Den exei ginei kamia plhktrologish grammatos', 10, 13,' $' 
       MES_TEST DB "This is a test $" 
       MES_TEST2 DB "This is the 2nd test $"
       
       MES_LATHOS: DB 'ERROR input', 10, 13,'$'

DEDOMENA ENDS


    END ARXI        
    
    
    
    
    
    
        LEA DX,MES_TEST  
        MOV AH,09h      
        INT 21h   
        
        
