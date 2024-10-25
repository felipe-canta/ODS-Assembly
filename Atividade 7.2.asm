title Ativ7.2
.model SMALL
.stack 100h
.DATA
 msg1 db 10,13, 'Digite o multiplicando:$'
 msg2 db 10,13, 'Digite o multiplicador: $'
 msg3 db 10,13, 'produto: $'
 produto db ?

.CODE
main proc
mov ax, @DATA
mov ds,ax

mov ah, 9
mov dx, offset msg1
int 21h

mov ah,1
int 21h
sub al, '0'
mov bl, al

mov ah, 9
mov dx, offset msg2
int 21h

mov ah,1
int 21h
sub al, '0'
mov cl, al
xor al, al ; zera para usar como acumulador

multip:
add al, bl
dec cl
jnz multip

fim:
add al, '0'
mov produto, al

mov ah,9
mov dx, offset msg3
int 21h

mov dl, produto
mov ah,2
int 21h

mov ah, 4Ch
int 21h
main endp
end main