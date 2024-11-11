IMPRIMIRINICIAL1:
    XOR BX, BX            ; Inicia na linha 0
    XOR SI, SI            ; Inicia na coluna 0
    MOV CX, 400           ; Total de elementos na matriz (20x20)

LOOP_IMPRESSAO:
    MOV AH, 02h           ; Função de impressão de caractere
    MOV DL, MATRIZINICIAL[BX][SI] ; Carrega o valor da matriz na posição atual
    INT 21h               ; Imprime o caractere

    INC SI                ; Move para a próxima coluna
    DEC CX                ; Decrementa o contador de elementos
    CMP CX, 0             ; Verifica se todos os elementos foram impressos
    JE FIM_IMPRESSAO      ; Se sim, termina a impressão

    CMP SI, 20            ; Verifica se chegou ao fim da linha
    JNE LOOP_IMPRESSAO    ; Se não, continua o loop

    ; Ao fim de uma linha, move para a próxima
    ADD BX, 4             ; Avança para a próxima linha
    XOR SI, SI            ; Reseta SI para a coluna inicial
    pulalinha             ; Pula para a linha seguinte
    JMP LOOP_IMPRESSAO    ; Continua o loop de impressão

FIM_IMPRESSAO:
    pulalinha
    RET
