TITLE HEXPRINTER

DATA SEGMENT
    number db 40h
DATA ENDS                    

SOROS SEGMENT STACK
    DB 256 DUP(0)
SOROS ENDS

CODE SEGMENT
    
ASSUME CS:CODE,DS:DATA,SS:SOROS    

main proc
    ;Apokatastasi dedomenwn
    MOV AX,DATA
    MOV DS,AX   
    
    
    mov dl, number
    call splithex
    
    call hexprint
    
    ;Omali eksodos sto DOS
    MOV AH,4CH
    INT 21H        
main endp
    
splithex proc
;Dexetai ws parametro ton DL    
    mov dh, number
    and dh, 0fh
    
    and dl, 0f0h  
    shr dl, 4
    ret
endp splithex

hexprint proc
;Dexetai ws parametro ton DX
;ston DL uparxoun ta 4 MSB tou dekaeksadikou arithmou
;ston DH uparxoun ta 4 LSB tou dekaeksadikou arithmou 
     
    cmp dl, 10
    jae letterDL
    
numberDL:                     
    add dl, '0'
    jmp doDH

letterDL:
    add dl, 'A'-10
               
doDH:
    cmp dh, 10
    jae letterDH
    
numberDH:
    add dh, '0'
    jmp print

letterDH:    
    add dh, 'A'-10
 
print: 
    mov ah, 2
    int 21h
    
    mov dl, dh
    mov ah, 2
    int 21h
    
    ret    
hexprint endp
         
CODE ENDS                  
