Title Ativ3
.Model SMALL
.DATA
 msg1 db 10,13, 'Digite um caracter:$'
 msg2 db 10,13, 'O caracter digitado eh um caracter especial: $'
 msg3 db 10,13, 'O caracter digitado eh um numero: $'
 msg4 db 10,13, 'O caracter digitado eh uma letra: $'
.CODE
 main proc
 mov ax,@DATA
 mov ds, ax

 mov ah,9
 lea dx, msg1
 int 21h

 mov ah,1 
 int 21h

 mov bl, al
 
 cmp bl, '0'
JB ESPECIAL

cmp bl,'9'
JBE NUMERO

cmp bl, 'A'
JB ESPECIAL

cmp bl, 'Z'
JBE LETRA

cmp bl, 'a'
JB ESPECIAL

cmp bl, 'z'
JBE LETRA

ESPECIAL:
mov ah,9
lea dx, msg2
int 21h
mov ah,2
int 21h
JMP FIM

LETRA:
mov ah,9
lea dx, msg3
int 21h
mov ah,2
int 21h
JMP FIM

NUMERO:
mov ah,9
lea dx, msg4
int 21h
mov ah,2
int 21h
JMP FIM

Fim:
mov ah, 4Ch
int 21h
main endp
end main

