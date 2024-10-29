Title Ativ3
.Model SMALL
.stack 100h
.DATA
 msg1 db 10,13, 'Digite um nome de ate 20 caracteres: $'
 msg2 db 10, 13, 'a quantidade de "a" contidos nesse nome eh: $'
 vetor db 20 dup(0)
 letraa db 0
.CODE
 main proc
 mov ax,@DATA
 mov ds, ax

 mov ah, 9
 mov dx, offset msg1
 int 21h

 mov cx, 20
 xor bx,bx

 ler:
 mov ah, 1
 int 21h
 cmp al, 0Dh
 JE msg
 mov vetor[bx],al
 inc bx 
 dec cx
 cmp al, 'a'
 JE adci
 cmp al, 'A'
 JE adci
jmp verificar

 adci:
 inc letraa

 Verificar:
cmp cx, 0
JNZ ler

 msg:
mov ah, 9
 mov dx, offset msg2
 int 21h

 escrever:
 add letraa, '0'
mov dl, letraa
mov ah, 2
int 21h

mov ah, 4Ch
main endp
end main

