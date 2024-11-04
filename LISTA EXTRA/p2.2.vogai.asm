model SMALL
stack 100h
.DATA
msg1 db 10, 13, 'digite seu nome:$'
nome db 8 dup(0)
.CODE
main proc
mov ax, @DATA
mov ds, ax
mov ah, 9
mov dx, offset msg1
int 21h

call leitura
call vogais
mov ah, 4Ch
int 21h
main endp

leitura proc
mov cx, 20
xor si, si
ler:
mov ah, 1
int 21h
mov nome[si], al
inc si
loop ler
ret
leitura endp
vogais proc
mov cx, 20
xor si, si
end main


