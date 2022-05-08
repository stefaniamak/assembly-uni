TITLE everything
KODIKAS SEGMENT
    ASSUME CS:KODIKAS, DS:DEDOMENA
    ARXI:   
        MOV AX,DEDOMENA	
	    MOV DS,AX	
        
;AX Ergasies eisodou/eksodou        , diorthwseis dekadikwn, pollaplasiasmoi, diaireseis.
;BX Deikths gia emmeso tropo prosdiorismou dieuthinsewn mnhmhs (indirect addressing).
;CX Metriths eite entolwn epanalhpsewn eite entolwn peristrofwn metaforas.
;DX Epektash tou AX apo 16 bits se 32 bits gia pollaplasiasmous kai diaireseis, emmeso tropo prosdiorismou dieuthunshw eisodou eksodou.
        
        
;1o lab;
        ADD AX, N               ;Prosthaitw to N sto AX
        SUB AX, N               ;Afairw to N apo to AX
        INC AX                  ;AX+1
        DEC AX                  ;AX-1
        
        MOV AL,10
        MOV DL,15               ;DX=AL*DL=150
        MUL DL
        
        MOV AX,115
        MOV DL,10               ;AX=AL/DL, ah=5, al=11
        MUL DL

    ;Gia na parw to prwto psifio kai meta to deutero;

        MOV AX, BX              ;AX/BL = ARITHMOS/10
        MOV BL, 10              ;Pairnw ksexorista ta psifia
        DIV BL                  ;Sto AL einai to prwto kai sto AH to deutero
                                ;Einai to upoleipo.
     ;Emfanish Arithmou;
        MOV DL, AL              
        ADD DL, 30H             ;Emfanish tou prwtou psifiou
        MOV AH, 02H
        int 21h
        
        MOV DL, BL              ;Emfanish tou deuterou psifiou
        ADD DL, 30H
        MOV AH, 02H
        int 21h


;lab2 IFs;
        CMP AL, '0'       ;elenxei an 0<=ah<=9
        JB NOTVALID
        CMP AL, '9'
        JA NOTVALID
NOTVALID:
        ;Tha erhtei edw        


;Anagnwsh apo to plhktrologio gia 4 fores;
        LEA DX,ANAGNWSH
	    MOV AH,09H	; Typwnoume to mhnyma oti theloume keimeno
	    INT 21H	

B1:	    MOV SI,0	; Eisagoume arxiki timi ston SI pou ton xrisimopoio san deikti mnimis

B2:	    MOV AH,01H    	; Eisagoume xarakthra apo to plhktrologio me parallhlh emfanish, 08H gia na mhn emfanizetai
	    INT 21H		; H ASCII timh tou xarakthra apothikeuetai ston AL
        
B7:	    MOV BUFFER[SI],AL; Metaferoume to xaraktira sti mnimi sti thesi "Buffer+timi tou SI"
	    INC SI		; Afksanoume ton deikti mnimis kata ena

B8:	    CMP SI,4	; Sygkrinoume an exei symplirothi o apitoumenos arithmos
	    JB B2		; an OXI pane sto "B2" gia ton epomeno xaraktira
 
 
 
;LOOP;       
        MOV CX,SI	; Dinoume arxiki timi ston metriti epanalipseon pou einai o CX
        MOV SI,0
E1:     
        MOV DL,BUFFER[SI]; Metaferoume ena xaraktira apo ti thesi "Buffer+timi tou SI" ston DL

;        LEA DX,TESTLOOP
;	    MOV AH,09H	; Typwnoume to prokathorismeno mhnyma
;	    INT 21H    
	    
	    MOV AH,02H	; Emfanizoume to periexomeno toy DL
	    INT 21H		;
	    INC SI		; Afksanoume ton deikti mnimis kata ena
     
LOOP E1 ;epanalhpsh oso to CX>0   




         MOV AH,4CH	; Eksodos sto leitoyrgiko systhma
    	 INT 21H	    
KODIKAS ENDS

DEDOMENA SEGMENT  


DEDOMENA ENDS
      N DB 5
      ;Pinakas DB 23,64,77,4,109,17
      BUFFER   DB 4 DUP(0) ; Dilosi enos pinaka me onoma Buffer 20 theseon typou Byte
      ANAGNWSH DB 'Eisagete keimeno:  $';
      TESTLOOP  DB 10,13,'To loop etrekse$';
      MNM DB '',10,13,'$'
    END ARXI       
    
    
    
    
            BX BP SI DI mono autoi pairnoun []     
            
            MOV CX,SI  ;Autes oi duo einai pws an o CX einai 0, tote na paei sthn etiketa TELOS
            JCXZ TELOS  
            
            ADD DL, 32 ; prosthaitw gia na kanw ena gramma mikro (apo kefalaio)
            SUB DL, 32 ; afairw gia na kanw ena gramma kefalaio (apo mikro)
            
            ADD DL, 48 ; gia na bgrw thn ascii timh (px ascii 1, +48 mas kanei ton arithmo 1 me ascii 49)    
            
            PSIFIA2:                
        MOV AL,BH   ; METEFERE TIN TIMI TOY BH STON AL
        MOV AH,0    ; MIDENIZO TON AH
    
        MOV CL,10	; METAFERO TO 10 STO CL
	    DIV CL		; DIERO TON AX ME TO CL

	    MOV DEKADA,AL ; METAFERO STI THESI MNIMIS DEKADA TO PILIKO TIS DIERESIS
	    MOV MONADA,AH ; METAFERO STI THESI MNIMIS MONADA TO YPOLIPO TIS DIERESIS

	    MOV DL,DEKADA ; METAFERO STO DL TO PERIEXOMENO TIS THESIS MNIMIS DEKADA
	    ADD DL,30H 	; PROSTHETO TIN ascii TIMI TOY 0                                                    30H = 48
	    MOV AH,02H 	; METAFEROYME STON AH TO 2 GIA NA EMFANISOYME TO PERIEXOMENO TOY DL
	    INT 21H		; KALOYME TO LEITOYRGIKO SYSTIMA NA EMFANISI STIN OTHONI TO PERIEXOMENO TOY DL
	
	    MOV DL,MONADA ; METAFERO STO DL TO PERIEXOMENO TIS THESIS MNIMIS MONADA
	    ADD DL,30H	; PROSTHETO TIN ascii TIMI TOY 0
	    MOV AH,02H	; METAFEROYME STON AH TO 2 GIA NA EMFANISOYME TO PERIEXOMENO TOY DL
	    INT 21H		; KALOYME TO LEITOYRGIKO SYSTIMA NA EMFANISI STIN OTHONI TO PERIEXOMENO TOY DL          
	    
	    
	    
	    
	    SOS GIA DEKAEKSADIKOUS:
	        otan ksekinaei o arithmos apo gramma, prepei na balw kai to 0 sthn arxh gia na katalavei oti einai arithmos kai oxi tpt allo.           
	        
	        
	        
	        
	        
	        
	        Q: An kanw athroisma   MOV AL, NUM1	tote an NUM1+NUM2>256, tote ginete overflow h apothikeuetai sto AX?
	             
	                               ADD AL, NUM2          
	                               
	        Q2: Mporw na kanw ektupwsh apo ton allon ascii pinaka kai oxi ton 16diko ppinaka ascii                       
	                               
	                               
	                               
Olisthiseis

    SHL AX,1 
    ;h  
    MOV CL,4 
    SHL AX,CL