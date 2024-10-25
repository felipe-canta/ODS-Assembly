Title Ativ3
.Model SMALL
.stack 100h
.DATA
 msg1 db 10,13, 'Digite um nome de ate 20 caracteres: $'
 msg2 db 10, 13, 'o nome eh: $'
 vetor db 20 dup(0)
 contador db 0
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
 JE msgescrever
 mov vetor[bx],al
 inc bx
 inc contador
 loop ler

msgescrever:
mov cl, contador 
xor bx, bx

mov ah, 9
 mov dx, offset msg2
 int 21h

escrever:
mov dl, vetor[bx]
inc BX
mov ah, 2
int 21h
dec cl
jnz escrever

mov ah, 4Ch
main endp
end main

