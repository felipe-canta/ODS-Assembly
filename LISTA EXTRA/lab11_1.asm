model SMALL
.DATA
msg db 10, 13, 'digite um numero que sera convertido: $' ; Solicita número ao usuário
msg1 db 10,13, 'Digite o tipo de numero q deseja ', 10, 13, 'binario = 1',10, 13,'octal = 2',10, 13,'hexadecimal = 3',10,13,'-> $' ; Instruções para a escolha da base
msg2 db 10,13, 'numero digitado em binario: $'
msg3 db 10,13, 'numero digitado em octal: $'
msg4 db 10,13, 'numero digitado em hexadecimal: $'

.CODE
main proc
    mov ax,@DATA
    mov ds, ax         ; Inicializa segmento de dados

    ; Solicita ao usuário o número a ser convertido
    mov ah, 9
    mov dx, offset msg
    int 21h

loopleitura:
    mov ah, 1           ; Lê caractere do usuário
    int 21h
    cmp al, 13          ; Se tecla Enter, termina a leitura
    je sair
    
    and ax, 0FH         ; Converte caractere em número
    push ax             ; Armazena o número na pilha
    mov ax, 10          ; Multiplica por 10 para acumular valor decimal
    mul bx              ; AX = AX * BX
    pop bx              ; Recupera número anterior
    add bx, ax          ; Adiciona ao acumulador
    jmp loopleitura

sair:
    ; Solicita ao usuário o tipo de conversão
    mov ah, 09
    lea dx, msg1
    int 21h

ler1:
    mov ah, 1           ; Lê a escolha da base do usuário
    int 21h
    cmp al, '1'         ; Se 1, converte para binário
    je bin
    cmp al, '2'         ; Se 2, converte para octal
    je octa
    cmp al, '3'         ; Se 3, converte para hexadecimal
    je hexa

bin:
    mov ah, 09
    lea dx, msg2        ; Exibe mensagem de conversão para binário
    int 21h
    call binleitura     ; Procedimento de conversão binária
    jmp finall

octa:
    mov ah, 09
    lea dx, msg3        ; Exibe mensagem de conversão para octal
    int 21h
    call octaleitura    ; Procedimento de conversão octal
    jmp finall

hexa:
    mov ah, 09
    lea dx, msg4        ; Exibe mensagem de conversão para hexadecimal
    int 21h
    call hexaleitura    ; Procedimento de conversão hexadecimal
    jmp finall

finall:
    mov ah, 4Ch
    int 21h             ; Termina o programa
main endp

; Procedimento para conversão binária
binleitura PROC
    ; Salva registradores na pilha para uso do procedimento
    push ax
    push bx
    push cx
    push dx

    xor cx, cx
    mov ax, bx
    mov bx, 2           ; Divide número por 2 para obter binário
loopbin:
    xor dx, dx
    div bx              ; Divide AX por BX 
    push dx             ; Armazena o dígito binário
    inc cx
    cmp ax, 0
    jne loopbin

    ; Imprime os dígitos binários armazenados na pilha
    mov ah, 02H
imprimirbin:
    pop dx
    cmp dx, 9
    ja letra2
    or dx, 30h
    jmp pulaletra1
; adiciona para transfomar em letra
letra2:
    add dx, 55D

pulaletra1:
    int 21H
    loop imprimirbin

    ; Recupera os valores salvos na pilha
    pop dx
    pop cx
    pop bx
    pop ax
    ret
binleitura ENDP

; Procedimento para conversão octal
octaleitura PROC
    push ax
    push bx
    push cx
    push dx

    xor cx, cx
    mov ax, bx
    mov bx, 8           ; Divide por 8 para obter octal
loop_octa:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne loop_octa

    ; Imprime os dígitos octais
    mov ah, 02H
imprimirocta:
    pop dx
    cmp dx, 9
    ja letra1
    or dx, 30h
    jmp pulaletra
; adiciona para transfomar em letra
letra1:
    add dx, 55D

pulaletra:
    int 21H
    loop imprimirocta

    pop dx
    pop cx
    pop bx
    pop ax
    ret
octaleitura ENDP

; Procedimento para conversão hexadecimal
hexaleitura PROC
    push ax
    push bx
    push cx
    push dx

    xor cx, cx
    mov ax, bx
    mov bx, 16          ; Divide por 16 para obter hexadecimal
loop_hexa:
    xor dx, dx
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne loop_hexa

    ; Imprime os dígitos hexadecimais
    mov ah, 02H
imprime_hexa:
    pop dx
    cmp dx, 9
    ja letra
    or dx, 30h
    jmp pula_letra
 ; adiciona para transfomar em letra
letra:
    add dx, 55D

pula_letra:
    int 21H
    loop imprime_hexa

    pop dx
    pop cx
    pop bx
    pop ax
    ret
hexaleitura ENDP

end main
