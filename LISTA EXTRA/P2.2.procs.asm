.MODEL SMALL
.STACK 100h
.DATA
    msg1 db 10, 13, 'Digite um nome de ate 10 caracteres: $'
    msg2 db 10, 13, 'As iniciais do nome sao: $'
    nome db 10 dup(0)
.CODE
main PROC
 mov ax, @DATA
 mov ds, ax
 
 mov ah, 9
 mov dx, offset msg1
 int 21h

 call ler_nome

 call escrever_nome

 mov ah, 4Ch
 int 21h
 main endp 

 ler_nome proc
  
 xor si, si
 mov ah, 1
 int 21h

 mov nome[si], al
 inc si
 mov cx, 10

  ler:
 int 21h 
 cmp al, 20h
 JE inicial
 dec cx
 JNZ ler
 JMP fim

  inicial:
 mov ah, 1 
 int 21h
 mov nome[si], al
 inc si
 dec cx
 JNZ ler

 fim:
 ret
 ler_nome endp

escrever_nome proc
  mov ax, @DATA
 mov ds, ax

 mov ah,9
 mov dx, offset msg2
 int 21h
 xor si, si

 escrever:
 mov dl, nome[si]
 mov ah, 2
 int 21h
 inc si
 cmp si, 10
 JE final
 JMP escrever

 final:
 ret 
 escrever_nome endp
 end main
 
 
