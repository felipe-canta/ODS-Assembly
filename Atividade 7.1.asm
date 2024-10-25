Title Ativ3
.Model SMALL
.DATA
 msg1 db 10,13, 'Digite o dividendo:$'
 msg2 db 10,13, 'Digite o divisor: $'
 msg3 db 10,13, 'Quociente: $'
 msg4 db 10,13, 'Resto: $'
 contador db 0
.CODE
 main proc
 mov ax,@DATA
 mov ds, ax

mov contador, 0

 mov ah, 9
 mov dx, offset msg1
 int 21h

 mov ah,1
 int 21h
 sub al,'0'
 mov bl, al

  mov ah, 9
 mov dx, offset msg2
 int 21h

 mov ah,1
 int 21h
 sub al,'0'

Divisao:
sub bl,al
cmp bl,al
inc contador
JB Quociente
loop Divisao

Quociente:
mov ah, 9
mov dx, offset msg3
int 21h
add contador, '0'
mov dl, contador
mov ah, 2
int 21h


Resto:
mov ah, 9
mov dx, offset msg4
int 21h
add bl,'0'
mov dl, bl
mov ah, 2
int 21h

mov ah, 4Ch
main endp
end main