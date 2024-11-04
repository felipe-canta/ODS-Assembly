soma db 0
xor ax, ax

xor cx, cx
ler digito:
mov ah, 1
int 21H
sub al, '0'
mov soma, al
mov bl, soma
mov si, 8
mul si
add bx, ax
inc cx
