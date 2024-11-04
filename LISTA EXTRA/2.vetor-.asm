title veotr
.model small
.DATA
matriz db 0,0,0,0
       db 0,0,0,0
       db 0,0,0,0
       db 0,0,0,0
num db 0
.CODE
main proc
mov ax, @DATA
mov ds, ax

call leitura
call soma

mov al, num
add al, '0'
mov dl, al
mov ah,2
int 21h
mov ah, 4Ch
int 21H
main endp

leitura proc
xor si, si
xor bx, bx
mov ch, 4

coluna:
mov cl,4
ler:
mov ah, 1
int 21H
sub al, '0'
mov matriz[si+bx], al
inc si
dec cl
jnz ler
add bx, 4
xor si, si
dec ch
jnz coluna
ret
leitura endp
soma proc
xor si, si
xor bx, bx
mov ch, 4
xor al, al
impcoluna:
mov cl, 4
somar:
add al, matriz[si+bx]
inc si
dec cl
jnz somar
add bx, 4
xor si, si
dec ch
jnz impcoluna
mov num, al
ret
soma endp
end main