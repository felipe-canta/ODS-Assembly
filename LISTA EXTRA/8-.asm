Title Ativ3
.Model SMALL
.stack 100h
.DATA
msg1 db 10,13, 'Digite 8 numeros: $'
msg2 db 10,13, 'impares: $'
msg3 db 10,13, 'pares: $'
vetor db 8 dup(0)
par db 0
impar db 0
.CODE
   main proc
    mov ax,@DATA
    mov ds, ax

    mov ah, 9
    mov dx, offset msg1
    int 21h
    call leitura
    call teste

    mov ah, 9
    mov dx, offset msg2
    int 21h
    add impar, '0'
    mov dl, impar
    mov ah, 2
    int 21h

    mov ah, 9
    mov dx, offset msg3
    int 21h
    add par, '0'
    mov dl, par
    mov ah, 2
    int 21h


    mov ah, 4Ch
    int 21h
    main endp

    leitura proc
  mov cx, 8
  xor si, si
 ler:
  mov ah, 1
  int 21h
  sub al, '0'
  mov vetor[si], al
  inc si
  loop ler
  ret
 leitura endp

   teste proc
   xor di, di
   xor bl, bl
   mov cx, 8
   xor si, si
   testar:
   mov al, vetor[si]
   inc si
   test al, 1
   JNZ impares
   Jz pares
   
impares:
inc impar
dec cx
jnz testar
jmp fim

pares:
inc par
dec cx
jnz testar

fim:
ret
teste endp
end main