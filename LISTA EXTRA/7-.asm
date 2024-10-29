Title Ativ3
.Model SMALL
.stack 100h
.DATA
msg1 db 10,13, 'Digite 4 numeros: $'
msg2 db 10,13, 'inversao: $'
vetor db 4 dup(0)
.CODE
   main proc
    mov ax,@DATA
    mov ds, ax

    mov ah, 9
    mov dx, offset msg1
    int 21h

    call leitura
    call inverter
    xor si, si
    mov cx, 4

    mov ah, 9
    mov dx, offset msg2
    int 21h

    escrever:
    mov dl, vetor[si]
    mov ah, 2
    int 21h
    inc si
    dec cx
    jnz escrever

    mov ah, 4Ch
    int 21h 
main endp

leitura proc
  mov cx, 4
  xor si, si
 ler:
  mov ah, 1
  int 21h
  mov vetor[si], al
  inc si
  loop ler
 fim:
  ret
 leitura endp

inverter proc
  mov cx, 4
  xor si, si
  inv:
  mov bl, vetor[si]
  push bx
  inc si
  loop inverter 

  mov cx, 4
  xor si, si

  invertido:
  pop bx
  mov vetor[si], bl
  inc si
  loop invertido

  final:
  ret
  inverter endp
  end main