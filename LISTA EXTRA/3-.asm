Title Ativ3
.Model SMALL
.stack 100h
.DATA
 msg1 db 10,13, 'Digite um numero em binario: $'
  msg2 db 10,13, 'o numero eh: $'
  num db 0
.CODE
 main proc
 mov ax,@DATA
 mov ds, ax

 mov ah, 9
 mov dx, offset msg1
 int 21h

xor bx, bx
 ler:
 mov ah, 1
 int 21h
 cmp al, 0Dh
 JE fim
 sub al, '0'
 shl bx,1 
 or bx, ax
 JMP ler

 fim:
 add bl, '0'
 mov num, bl
 mov ah, 9
 mov dx, offset msg2
 int 21h
 mov dl, num
 mov ah, 2
 int 21h

 mov ah, 4Ch
 main endp
 end main