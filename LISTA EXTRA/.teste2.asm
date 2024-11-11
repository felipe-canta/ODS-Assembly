.MODEL SMALL
.STACK 100h
.DATA
; Defina uma matriz que represente "BATALHA NAVAL" em formato maior, com caracteres aumentados
; 1 representa partes preenchidas, 0 representa espaços vazios para formar letras
TITULO DB 1,1,1,1,1,1,0,1,1,1,1,0,1,0,0,1,1,1,1,0
       DB 1,0,0,0,0,0,1,0,0,0,0,1,0,1,1,0,0,0,0,1
       DB 1,1,1,1,1,1,0,0,1,1,1,1,1,0,0,1,1,1,1,0
       DB 1,0,0,0,0,0,1,0,1,0,0,0,1,0,0,0,0,0,0,1
       DB 1,0,0,0,0,0,1,0,1,1,1,1,1,0,0,1,1,1,1,0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    MOV AX, 13h       ; Modo gráfico 320x200, 256 cores
    INT 10h

    ; Posição inicial de desenho
    MOV CX, 40        ; Coluna inicial (posição horizontal)
    MOV DX, 30        ; Linha inicial (posição vertical)

    ; Loop para desenhar o título em pixels grandes
    MOV SI, OFFSET TITULO
    MOV BX, 0         ; Para contar o índice na matriz

DRAW_LOOP:
    ; Carrega o próximo valor da matriz TITULO
    MOV AL, [SI + BX]
    INC BX            ; Avança para o próximo elemento
    CMP AL, 0         ; Verifica se é um espaço ou preenchimento
    JE SKIP_PIXEL     ; Pula se for espaço (0)

    ; Função para desenhar um retângulo maior para cada ponto (para aumentar visibilidade)
    MOV AH, 0Ch       ; Função de desenho de pixel (INT 10h)
    MOV CX, 4         ; Largura de cada bloco de pixels
    MOV DX, 4         ; Altura de cada bloco de pixels
    MOV AL, 15h       ; Cor branca para pontos do título

    ; Desenha o retângulo maior
    CALL DRAW_RECTANGLE

SKIP_PIXEL:
    ADD CX, 10        ; Avança para próxima coluna
    CMP CX, 320       ; Checa o limite da linha
    JL DRAW_LOOP      ; Se não chegou ao limite, continua

    ; Move para a próxima linha na matriz do título
    ADD DX, 20
    MOV CX, 40        ; Reseta a coluna
    CMP DX, 200       ; Checa o limite da tela
    JL DRAW_LOOP      ; Se não chegou ao limite, continua

WAIT_KEY:
    MOV AH, 00h       ; Espera por uma tecla para sair
    INT 16h

    MOV AX, 3         ; Retorna ao modo de texto
    INT 10h
    MOV AH, 4Ch
    INT 21h

DRAW_RECTANGLE PROC
    PUSH CX
    PUSH DX

    MOV BH, 0         ; Página da tela
    MOV CH, 0         ; Linhas do retângulo

DRAW_ROW:
    MOV CL, 0         ; Colunas do retângulo
DRAW_COLUMN:
    MOV AL, 15h       ; Define a cor do pixel (branco)
    INT 10h           ; Desenha o pixel

    INC CX            ; Próxima coluna
    CMP CL, 4
    JL DRAW_COLUMN    ; Se não desenhou toda a largura, continua

    INC DX            ; Próxima linha
    CMP CH, 4
    JL DRAW_ROW       ; Se não desenhou toda a altura, continua

    POP DX
    POP CX
    RET
DRAW_RECTANGLE ENDP

MAIN ENDP
END MAIN
