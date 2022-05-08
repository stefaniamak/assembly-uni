TITLE ASKISI3
KODIKAS SEGMENT PUBLIC
ASSUME CS:KODIKAS, DS:DEDOMENA
ARXH:
	    MOV AX,DEDOMENA ; Apokatastash tou DS
	    MOV DS,AX	; Apokatastash tou DS
    
  	    LEA DX,PROTROPI
	    MOV AH,09H	; Typwnoume to mhnyma
	    INT 21H	

B1:	    MOV SI,0	; Eisagoume arxiki timi ston SI pou ton xrisimopoio san deikti mnimis

B2:	    MOV AH,01H    	; Eisagoume xarakthra apo to plhktrologio me parallhlh emfanish
	    INT 21H		; H ASCII timh tou xarakthra apothikeuetai ston AL

B3:	    CMP AL,13	; Elegxoume an patithike to ENTER (opote o AL tha apoktouse thn ASCII timh 13) 
	    JE Emfanisi	; An NAI phgaine stin etiketa "Emfanisi"

B4:        CMP AL,32	; Elegxoume an patithike to SPACE (opote o AL tha apoktouse thn ASCII timh 32)
	    JE B7		; An NAI phgaine sto "B7"
        
           CMP AL,'.'  ; Elegxoume an patithike to '.'
           JE B7       ; An NAI phgaine sto "B7"
    
B5:	    CMP AL,'A'	; Sygkrinoume auto pou patithike me tin ASCII timi tou A
	    JB B2		; An einai mikroteri i ASCII timi tou pane sto "B2" gia ton epomeno xaraktira

B6:	    CMP AL,'Z'	; Sygkrinoume auto pou patithike me tin ASCII timi tou Z 
	    JBE B7		; An einai mikroteri H isi i ASCII timi tou pane sto "B7" gia apothikeysi
    
           CMP AL,'a'  ; Sygkrinoume auto pou patithike me tin ASCII timi tou a
           JB B2       ; An einai mikroteri i ASCII timi tou pane sto "B2" gia ton epomeno xaraktira
    
           CMP AL,'z'  ; Sygkrinoume auto pou patithike me tin ASCII timi tou a
           JA B2       ; An einai megaliteri i ASCII timi tou pane sto "B2" gia ton epomeno xaraktira
    
B7:	    MOV BUFFER[SI],AL; Metaferoume to xaraktira sti mnimi sti thesi "Buffer+timi tou SI"
	    INC SI		; Afksanoume ton deikti mnimis kata ena

B8:	    CMP SI,40	; Sygkrinoume an exei symplirothi o apitoumenos arithmos
	    JB B2		; an OXI pane sto "B2" gia ton epomeno xaraktira

Emfanisi:
    	    MOV CX,SI	; Dinoume arxiki timi ston metriti epanalipseon pou einai o CX
	    JCXZ TELOS	; Elegxoume an o CX den einai 0 allios phgaine stin etiketa "Telos"
	    MOV SI,0	; Dinoume arxiki timi ston SI pou ton xrisimopoio san deikti mnimis
	
	    LEA DX,MESSAGE
	    MOV AH,09H	; Typwnoume to mhnyma
	    INT 21H	

E2:	    MOV DL,BUFFER[SI]; Metaferoume ena xaraktira apo ti thesi "Buffer+timi tou SI" ston DL

	    CMP DL,32	; Sygkrinoume an O DL exei timi tou SPACE
	    JE E4		; An einai to keno pane sto "E4"
 
           CMP DL,'.'  ; Sygkrinoume an O DL exei timi tou '.'
           JE E4       ; An einai i . pane sto "E4"
	    CMP DL,'Z'	; Sygkrinoume auto pou patithike me tin ASCII timi tou A 
	    JA E3		; An einai megaliteri i ASCII timi tou pane sto "B2" gia ton epomeno xaraktira

           ADD DL,32   ; Metatrepoume to xaraktira apo Kefalaio se Mikro
           JMP E4      ; Prospername tin epomeni metatropi
        
E3:	    SUB DL,32	; Metatrepoume to xaraktira apo Mikro se Kefalaio

E4:	    MOV AH,02H	; Emfanizoume to periexomeno toy DL
	    INT 21H		;
	    INC SI		; Afksanoume ton deikti mnimis kata ena

E5:	    LOOP E2	    ; Epanalambanoume ta bhmata apo "E2" mexri "E4" 
        
           JMP EXIT
Telos:	
           LEA DX,NOINPUT
	    MOV AH,09H	; Typwnoume to mhnyma
	    INT 21H	
EXIT:	    
           MOV AH,4CH	; Eksodos sto leitoyrgiko systhma
    	    INT 21H

KODIKAS ENDS

DEDOMENA SEGMENT
	BUFFER   DB 40 DUP(0) ; Dilosi enos pinaka me onoma Buffer 40 theseon typou Byte
       PROTROPI DB 'Eisagete keimeno:  $';
	MESSAGE  DB 10,13,10,13,'H metatropi se mikra einai: $' ; To minima pou tha emfanistei
	NOINPUT  DB 10,13,'Den eisagate kanena charaktira. Telos programmatos$';						
DEDOMENA ENDS

	END ARXH