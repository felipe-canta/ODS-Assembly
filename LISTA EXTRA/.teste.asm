.MODEL SMALL
.STACK 100h
.DATA
msg db 'Digite um numero octal: $'
resultado_msg db 13, 10, 'Valor decimal: $'
input db 5 dup(0)   ; armazenamento para até 5 dígitos octais
.CODE
main PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Exibe a mensagem para entrada do número octal
    MOV DX, OFFSET msg
    MOV AH, 9
    INT 21h

    ; Chama a rotina de leitura do número octal
    CALL ler_octal

    ; Exibe a mensagem de resultado
    MOV DX, OFFSET resultado_msg
    MOV AH, 9
    INT 21h

    ; Imprime o número convertido armazenado em AX
    CALL imprimir_decimal

    ; Finaliza o programa
    MOV AH, 4Ch
    INT 21h
main ENDP

ler_octal PROC
    XOR BX, BX         ; zera BX para acumular o valor decimal
    MOV CX, 0          ; contador de dígitos

ler_digito:
    MOV AH, 1          ; função de leitura de um caractere
    INT 21h
    CMP AL, 13         ; verifica se é Enter
    JE fim_leitura     ; se for Enter, termina a leitura

    ; Converte de ASCII para valor numérico e valida
    SUB AL, '0'
    CMP AL, 7          ; verifica se é um dígito octal válido (0-7)
    JA erro_octal      ; se maior que 7, erro de entrada

    ; Acumula o valor decimal em BX
    MOV DX, BX         ; preserva o valor atual em DX
    SHL DX, 3          ; multiplica BX por 8 (base octal)
    ADD DX, AX         ; adiciona o valor do dígito atual
    MOV BX, DX         ; atualiza BX com o novo valor

    INC CX             ; incrementa o contador de dígitos
    CMP CX, 5          ; limita a 5 dígitos
    JE fim_leitura
    JMP ler_digito     ; continua para o próximo dígito

erro_octal:
    ; Código para tratar erro
    MOV BX, 0          ; reseta BX em caso de erro
    JMP fim_leitura

fim_leitura:
    MOV AX, BX         ; armazena o valor decimal final em AX
    RET
ler_octal ENDP

imprimir_decimal PROC
    ; Converte o número em AX para ASCII e exibe
    XOR CX, CX         ; contador para os dígitos

convert_loop:
    XOR DX, DX         ; zera DX para dividir corretamente
    MOV BX, 10
    DIV BX             ; AX = AX / 10, DX = resto
    PUSH DX            ; empilha o resto (último dígito do número)
    INC CX             ; incrementa o contador de dígitos
    CMP AX, 0
    JNE convert_loop   ; continua até que AX seja zero

print_digits:
    POP DX             ; recupera os dígitos na ordem correta
    ADD DL, '0'        ; converte para ASCII
    MOV AH, 2
    INT 21h            ; exibe o dígito
    LOOP print_digits  ; repete até que todos os dígitos sejam exibidos

    RET
imprimir_decimal ENDP

END main
