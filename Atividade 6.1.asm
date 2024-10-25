Title Ativ3
.Model SMALL
.stack 100h
.DATA
 msg1 db 10,13, 'Digite um N numero de caracteres:$'
 contador db 0
.CODE
 main proc
 mov ax,@DATA
 mov ds, ax

 mov ah, 9
 mov dx, offset msg1
 int 21h

mov contador, 0

ler:
mov ah, 1
int 21h
cmp al, 0Dh
JE asterisco
inc contador
loop ler

ASTERISCO:
mov al, contador
xor ah, ah
mov cx, ax
mov dl, '*'
EScrever:
mov ah, 2
int 21h
dec cx
jnz escrever


 mov ah, 4Ch
 int 21h
 main endp
 end main