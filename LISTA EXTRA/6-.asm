Title Ativ3
.Model SMALL
.stack 100h
.DATA
msg1 db 10,13, 'Digite 8 numeros: $'
msg2 db 10,13, 'A soma entre eles eh: $'
vetor db 20 dup(0)
soma db 0 
.CODE
   main proc
    mov ax,@DATA
    mov ds, ax

    mov ah, 9
    mov dx, offset msg1
    int 21h

    call leitura

    mov ah, 9
    mov dx, offset msg2
    int 21h
    call somar
    

    mov ah, 4Ch
    int 21h
main endp

leitura proc
  mov cx, 20
  xor si, si
ler:
  mov ah, 1
  int 21h
  sub al, '0'
  mov vetor[si], al
  mov bl, vetor[si]
  add soma, bl
  inc si
  dec cx
  jnz ler
fim:
ret
leitura endp

somar proc
 xor cx, cx
 xor dx, dx
 xor ah, ah
 mov al, soma
 mov bx, 10
divi:
 cmp ax, bx
 inc cx
 JBE escrever
 div bx
 push dx
 jmp divi
escrever:
 mov dl, al
 add dl, '0'
 mov ah, 2
 int 21h
 pop ax
 loop escrever
  somar endp
end main
 
  

