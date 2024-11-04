Title Ativ3
.Model SMALL
.stack 100h
.DATA
 msg1 db 10,13, 'Digite um numero: $'
  msg2 db 10,13, 'numero em hexadecimal: $'
  num dw 2 dup(0)
.CODE
 main proc
 mov ax,@DATA
 mov ds, ax
 mov ah, 9
 mov dx, offset msg1
 int 21h
 call leitura
 push dx
 mov ah, 9
 mov dx, offset msg2
 int 21h
 pop dx
 call hexa
mov ah, 4Ch
int 21h
 main endp

 leitura proc

 ler:
 mov ah, 1
 int 21h
 xor ah, ah
 mov num ,ax 
 sub num, '0'
 ret 
 leitura endp

 hexa proc
 mov ax, num
 xor ah, ah
 xor cx, cx
 xor bx, bx
 mov bx, 2
 divi:
 xor dx, dx
 div bx
 push dx
 inc cx
 cmp ax, 0
 JNE divi

 
 imprimir:
 mov ah, 2
 pop dx
 add dx, '0'
 int 21H
 loop imprimir


 hexa endp
 end main

 

