                                     TITLE ASKISI4
KODIKAS SEGMENT PUBLIC
ASSUME CS:KODIKAS, DS:DEDOMENA, SS:SOROS
    KYRIO PROC NEAR
                    ; OI 2 PARAKATO ENTOLES APOKATHISTOYN THN TIMH TOY DS.
	    MOV AX,DEDOMENA 
	    MOV DS,AX	
    
  	    LEA DX,PROTROPI ; BAZOYME TH DIEYTHINSI MNIMIS TOY PROTROPI STON DX
	    MOV AH,09H	    ; METAFEROYME STON AH TO 9 GIA NA MPOROYME NA EMFANISOYME TO PROTROPI
	    INT 21H	        ; KALOYME TO LEITOYRGIKO SYSTIMA NA EMFANISEI STIN OTHONI TO PROTROPI

	    MOV SI,0	; Eisagoume arxiki timi ston SI pou ton xrisimopoio san deikti mnimis
    B2:	
        MOV AH,01H  ; Eisagoume xarakthra apo to plhktrologio me parallhlh emfanish
	    INT 21H		; H ASCII timh tou xarakthra apothikeuetai ston AL

	    CMP AL,'#'	; Elegxoume an patithike to # 
	    JE KLISI	; An NAI phgaine stin etiketa "KLISI"
    
	    MOV BUFFER[SI],AL; Metaferoume to xaraktira sti mnimi sti thesi "Buffer+timi tou SI"
	    INC SI		; Afksanoume ton deikti mnimis kata ena

        CMP SI,80	; Sygkrinoume an exei symplirothi o apetoumenos arithmos
	    JB B2		; an OXI pane sto "B2" gia ton epomeno xaraktira
    KLISI: 
        CALL YPO1   ; KALOYME TIN YPOROUTINA YPO1
                    ; OI 2 EPOMENES ENTOLES TERMATIZOYN TO PROGRAMMA KAI EPISTREFOYN STO LEITOYRGIKO
        MOV AH,4CH	
    	INT 21H

    KYRIO ENDP 
    
    YPO1 PROC

    	MOV CX,SI	; Dinoume arxiki timi ston metriti epanalipseon pou einai o CX
        JCXZ EXIT
        
	    MOV SI,0	; Dinoume arxiki timi ston SI pou ton xrisimopoio san deikti mnimis
        MOV BH,0

	    LEA DX,MESSAGE ; BAZOYME TH DIEYTHINSI MNIMIS TOY MESSAGE STON DX
	    MOV AH,09H	; METAFEROYME STON AH TO 9 GIA NA MPOROYME NA EMFANISOYME TO MESSAGE
	    INT 21H	    ; KALOYME TO LEITOYRGIKO SYSTIMA NA EMFANISEI STIN OTHONI TO MESSAGE
        
    	MOV AH,01H  ; Eisagoume xarakthra apo to plhktrologio me parallhlh emfanish
	    INT 21H		; H ASCII timh tou xarakthra apothikeuetai ston AL
    E2:	
        CMP AL,BUFFER[SI]; Metaferoume ena xaraktira apo ti thesi "Buffer+timi tou SI" ston DL
        JNE SKIP    ; AN DEN EINAI ISA PIGENE STIN ETIKETA SKIP
        
        INC BH      ; AN EINAI ISA AYKSISE TON METRITI BH KATA ENA
	SKIP:
	    INC SI		; Afksanoume ton deikti mnimis kata ena

	    LOOP E2	    ; Epanalambanoume ta bhmata apo "E2" mexri EDO 
         
        CMP BH,0    ; SYGKRINOYME TON METRITI ME TO 0
        JNE DISPLAY ; AN EINAI DIAFORO TOY 0 PIGENE STIN ETIKETA DISPLAY
        
        LEA DX,NONUM; BAZOYME TH DIEYTHINSI MNIMIS TOY NONUM STON DX
        MOV AH,9    ; METAFEROYME STON AH TO 9 GIA NA MPOROYME NA EMFANISOYME TO NONUM
        INT 21H     ; KALOYME TO LEITOYRGIKO SYSTIMA NA EMFANISEI STIN OTHONI TO NONUM
        
        JMP EXIT    ; PIGENE STIN ETIKETA EXIT

    DISPLAY:
        LEA DX,YPARXEI; BAZOYME TH DIEYTHINSI MNIMIS TOY YPARXEI STON DX
        MOV AH,9    ; METAFEROYME STON AH TO 9 GIA NA MPOROYME NA EMFANISOYME TO YPARXEI
        INT 21H     ; KALOYME TO LEITOYRGIKO SYSTIMA NA EMFANISEI STIN OTHONI TO YPARXEI
        
        CMP BH,9    ; SYGKRINO TO METRITI BH ME TO 9
        JA  PSIFIA2 ; AN O METRITIS BH EINAI PANO APO 9 PIGENE STIN EIKETA PSIFIA2
 
        MOV DL,BH   ; METAFERO STO DL TIN TIMI TOY METRITI
        ADD DL,48   ; PROSTHETO STO DL TIN ascii TIMI TOY 0
        MOV AH,2    ; METAFEROYME STON AH TO 2 GIA NA MPOROYME NA EMFANISOYME TO PERIEXOMENO TOY DL
        INT 21H     ; KALOYME TO LEITOYRGIKO SYSTIMA NA EMFANISEI STIN OTHONI TO PERIEXOMENO TOY DL
        
        JMP EXIT    ; PIGENE STIN ETIKETA EXIT

    PSIFIA2:                
        MOV AL,BH   ; METEFERE TIN TIMI TOY BH STON AL
        MOV AH,0    ; MIDENIZO TON AH
    
        MOV CL,10	; METAFERO TO 10 STO CL
	    DIV CL		; DIERO TON AX ME TO CL

	    MOV DEKADA,AL ; METAFERO STI THESI MNIMIS DEKADA TO PILIKO TIS DIERESIS
	    MOV MONADA,AH ; METAFERO STI THESI MNIMIS MONADA TO YPOLIPO TIS DIERESIS

	    MOV DL,DEKADA ; METAFERO STO DL TO PERIEXOMENO TIS THESIS MNIMIS DEKADA
	    ADD DL,30H 	; PROSTHETO TIN ascii TIMI TOY 0
	    MOV AH,02H 	; METAFEROYME STON AH TO 2 GIA NA EMFANISOYME TO PERIEXOMENO TOY DL
	    INT 21H		; KALOYME TO LEITOYRGIKO SYSTIMA NA EMFANISI STIN OTHONI TO PERIEXOMENO TOY DL
	
	    MOV DL,MONADA ; METAFERO STO DL TO PERIEXOMENO TIS THESIS MNIMIS MONADA
	    ADD DL,30H	; PROSTHETO TIN ascii TIMI TOY 0
	    MOV AH,02H	; METAFEROYME STON AH TO 2 GIA NA EMFANISOYME TO PERIEXOMENO TOY DL
	    INT 21H		; KALOYME TO LEITOYRGIKO SYSTIMA NA EMFANISI STIN OTHONI TO PERIEXOMENO TOY DL    
   	EXIT:    
        RET         ; EPISTROFI STIN YPOROYTINA POY TIN KALESE
    YPO1 ENDP    

KODIKAS ENDS

DEDOMENA SEGMENT
	BUFFER DB 80 DUP(0) ; Dilosi enos pinaka me onoma Buffer 20 theseon typou Byte
    PROTROPI DB 'Eisagete keimeno:  $';
	MESSAGE DB 10,13,'Eisagete ena charactira: $' ; To minima pou tha emfanistei
	NONUM DB 10,13,'Den yparxei o charaktiras. Telos programmatos$';
	YPARXEI DB 10,13,'To plithos ton emfaniseon mesa sto keimeno einai: $'
	DEKADA DB 0
	MONADA DB 0 						
DEDOMENA ENDS

SOROS SEGMENT STACK
	DB 256 DUP(0)
SOROS ENDS
	
	END KYRIO
