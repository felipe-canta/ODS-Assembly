Title Ativ3
.Model SMALL
.stack 100h
.DATA
msg1 db 10,13, 'Digite uma matriz 4x4: $'
msg2 db 10,13, 'A diagonal principal da matriz eh: $'
Matriz db 0,0,0,0,0
       db 0,0,0,0,0
       db 0,0,0,0,0
       db 0,0,0,0,0
principal db 5 dup(0)      
.CODE
  main proc
  mov ax,@DATA
  mov ds, ax

  mov ah, 9
  mov dx, offset msg1
  int 21h

  mov cx, 25
  xor bx, bx

 ler:
  mov ah, 1
  int 21h
  sub al, '0'
  mov Matriz[BX], al
  inc bx
  loop ler

 mov cx, 5
 xor di, di
 xor si, si

 mov ah, 9
 mov dx, offset msg2
 int 21h

 diagprincip:
  mov al, Matriz[si]
  mov principal[di], al
  add si, 6
  mov dl, principal[di]
  add dl, '0'
  mov ah,2
  int 21h
  loop diagprincip

 mov ah, 4Ch
 main endp
 end main




