Title Ativ3
.Model SMALL
.stack 100h
.DATA
 msg1 db 10,13, 'Digite um numero em binario: $'
  msg2 db 10,13, 'numero em decimal: $'
  num db 0
  contador db 0
.CODE
 main proc
 mov ax,@DATA
 mov ds, ax
 mov ah, 9
 mov dx, offset msg1
 int 21h
 call leitura
  mov ah, 9
 mov dx, offset msg1
 int 21h
 call decima
 
mov ah, 4Ch
int 21h
 main endp

leitura proc
xor bx, bx
 ler:
 mov ah, 1
 int 21h
 cmp al, 0Dh
 JE fim
 decimal:
 sub al, '0'
 shl bx,1 
 xor ah, ah
 or bx, ax
 JMP ler
 ret 
leitura endp

decima proc 
 fim:
mov contador, bl
 add contador, '0'
 mov bl, contador
 mov num, bl
 mov ah, 9
 mov dx, offset msg2
 int 21h
 mov dl, num
 mov ah, 2
 int 21h
 decima endp
 
 end main