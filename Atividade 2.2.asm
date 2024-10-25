title ativ1.2

.model SMALL
.DATA
msg1 db 10, 13, "digite um numero entre 0 e 9:$"
msg2 db 10, 13, "Digite outro numero entre 0 e 9:$"
msg3 db 10, 13, "A soma deles eh:$"
result db 0

.CODE
main proc

; chama @data para o main
    mov ax, @DATA
    mov ds, ax

; exibe a msg1 na tela
    mov ah, 9
    lea dx, msg1
    int 21h

; le um caracter do teclado
    mov ah, 1
    int 21h
    sub al, '0'          ; converte de ASCII para número
    mov bl, al          ; armazena o primeiro número em bl

; exibe a msg2 na tela
    mov ah, 9
    lea dx, msg2
    int 21h

; le um caracter do teclado
    mov ah, 1
    int 21h
    sub al, '0'          ; converte de ASCII para número

; soma os números
    add bl, al          ; soma os dois números

; exibe a msg3 na tela
    mov ah, 9
    lea dx, msg3
    int 21h

; converte o resultado de volta para ASCII
    add bl, '0'         ; converte de número para ASCII

; exibe o resultado
    mov ah, 2
    mov dl, bl
    int 21h

; finaliza o programa
    mov ah, 4Ch
    int 21h

main endp
end main
