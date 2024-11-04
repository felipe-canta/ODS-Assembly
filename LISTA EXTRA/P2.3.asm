Title Ativ3
.Model SMALL
.stack 100h
.DATA
msg1 db 10,13, 'Digite uma matriz 4x4: $'
msg2 db 10,13, 'A soma da diagonal principal da matriz eh: $'
Matriz db 0,0,0,0
       db 0,0,0,0
       db 0,0,0,0
       db 0,0,0,0
soma db 0 
.CODE
   main proc
    mov ax,@DATA
    mov ds, ax

    mov ah, 9
    mov dx, offset msg1
    int 21h

    call ler_matriz
    call soma_matriz

    mov ah, 9
    mov dx, offset msg2
    int 21h

    add soma, '0'
    mov dl, soma
    mov ah, 2
    int 21H

    mov ah, 4Ch
    int 21H
  main endp

ler_matriz proc
    mov cx, 16
    xor si, si
  ler:
    mov ah, 1
    int 21H
    sub al, '0'
    mov matriz[si], al
    inc si
    dec cx
    JNZ ler
  fim:
    ret
ler_matriz endp
 
soma_matriz proc
    xor si, si
    xor bx, bx
    xor ax, ax
    mov cx, 4
 
  somar:
   add al, matriz[si+bx]
  inc si
   add bx, 4
   dec cx
   jnz somar

  finalizar:
   mov soma, al
   xor ah, ah
   ret
soma_matriz endp
end main