title Ativ7.2
.model SMALL
.stack 100h
.DATA
 msg1 db 10,13, 'Digite o multiplicando:$'
 msg2 db 10,13, 'Digite o multiplicador: $'
 msg3 db 10,13, 'produto: $'

.CODE
main proc
    ; Inicialização do segmento de dados
    mov ax, @DATA
    mov ds, ax

    ; Mensagem para o multiplicando
    mov ah, 9
    mov dx, offset msg1
    int 21h

    ; Leitura do multiplicando
    mov ah, 1
    int 21h
    sub al, '0'       ; Converte de ASCII para valor numérico
    mov bl, al        ; Armazena o multiplicando em BL

    ; Mensagem para o multiplicador
    mov ah, 9
    mov dx, offset msg2
    int 21h

    ; Leitura do multiplicador
    mov ah, 1
    int 21h
    sub al, '0'       ; Converte de ASCII para valor numérico
    mov cl, al        ; Armazena o multiplicador em CL

    ; Loop de multiplicação usando soma repetida
    xor al, al        ; Zera AL para usá-lo como acumulador
multip:
    add al, bl        ; Soma o multiplicando ao acumulador
    dec cl            ; Decrementa o contador
    jnz multip        ; Continua o loop enquanto CL não for zero

    ; Mostra a mensagem "produto:"
    mov ah, 9
    mov dx, offset msg3
    int 21h

    ; Exibe o resultado
    add al, '0'       ; Converte o resultado para ASCII
    mov dl, al        ; Move o resultado convertido para DL
    mov ah, 2         ; Função para exibir um caractere
    int 21h

    ; Finaliza o programa
    mov ah, 4Ch
    int 21h
main endp
end main
