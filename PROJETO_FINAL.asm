.MODEL SMALL
.STACK 100h
pulalinha MACRO
    mov ah, 02h           
    mov dl, 13        
    Int 21h               
    mov dl, 10          
    int 21h
endm
LEITURANUMERO MACRO
 loopenter:
 mov ah,01
 int 21h
 cmp al,13
 je enter1
 mov bl,al
 jmp loopenter
 enter1:
endm
TRANSFORMAEMHEXA MACRO
    xor cx,cx           ;ZERA CONTADOR
    mov AX,bx           ;MOVE DIVIDENDO PARA AX (SERÁ O NÚMERO INSERIDO PELO USUÁRIO)
    MOV BX,16           ;DIVISOR É 16 (POIS ESTAMOS CONVERTENDO PARA A BASE 16
    @LOOP_HEXA:
        XOR DX,DX       ;Vamos armazenar o resto em DX toda vez que o loop voltar entao precisa ser sempre zerado
        DIV BX          ; AX : BX (RESTO EM DX E QUOCIENTE EM AX)
        PUSH DX         ;Guardar o valor do resto para a impressão mais tarde
        INC CX          ;incrementa mais um algarismo que será impresso
        CMP AX,0        ;Se o quociente for 0, significa que devemos parar a divisao e iniciar a impressão
        JNE @LOOP_HEXA
endm
LENDOMAISQUE9 MACRO
@LOOP_LEITURA:
        MOV AH,01
        INT 21H
        CMP AL,13
        JE @SAI_LEITURA     ;SE É ENTER ENTÃO SAI
        AND  AX, 0FH        ;TRANSFORMA EM NUMERO
        PUSH AX             ;GUARDA VALOR ANTES DA OPERACAO
        MOV AX,10           ;MOVE MULTIPLICADOR PARA AX
        MUL BX              ;FAZ AX x BX
        POP BX              ;DEVOLVE O VALOR PARA BX
        ADD BX,AX           ;ADCIONA O VALOR ANTES LIDO AGORA DO VALOR TOTAL (BX = BX + (BX x AX))
        JMP @LOOP_LEITURA
        @SAI_LEITURA:
endm
IMPRESSAODAMATRIZ MACRO
IMPRIMIRINICIAL:          ;imprimi a primiera matriz de apresentação do programa
MOV AH,02                 ;IMPRIMI
MOV DL,MATRIZINICIAL[BX][SI] 
INT 21h          
INC SI                    ;AUMENTA O VALOR DA COLUNA
DEC CX                    ;DIMINUI O CONTADOR
CMP CX,0                  ;COMPARA COM CX, SE FOR 0 ACABA
JE FIMIMPINICIAL                   ;SE IGUAL ENCERRA
CMP SI,20                  ;COMPARA COM 4 PRA VER SE É A HORA DE PULAR LINHA
JNE IMPRIMIRINICIAL              ;SE NÃO VOLTA AO LOOP
ADD BX,4                  ;SE SIM ADICIONA 4 EM BX, MUDANDO A LINHA DA MATRIZ
XOR SI,SI                 ;ZERA SI PRA VOLTARMOS NA COLUNA 0
pulalinha                 ;MACRO DE PULAR LINHA
JMP IMPRIMIRINICIAL              ;VOLTA NO LOOP
FIMIMPINICIAL:
pulalinha
endm

salvaleitura MACRO
    MOV AH,01
    INT 21H
endm
definicao1 MACRO
    XOR SI,SI                 ;ZERA SI E BX
    XOR BX,BX
    MOV CX,400                ;CX=400 POIS A MATRIZ TEM 400 CARACTERES (20X20)
endm
definicao2 MACRO        
    INC SI                    ;AUMENTA O VALOR DA COLUNA
    DEC CX
    XOR AL,AL                    ;DIMINUI O CONTADOR
    CMP CX,0                  ;COMPARA COM CX, SE FOR 0 ACABA
endm
.DATA   
MSG1 DB 'SEJA BEM VINDO AO BATALHA NAVAL$'
MSG2 DB 'DIGITE QUALQUER NUMERO E DIGITE ENTER PARA INICIAR:$'
MSG3 DB 'DIGITE A LINHA: $'
MSG4 DB 'DIGITE A COLUNA: $'

MATRIZINICIAL DB 20 DUP (20 DUP ("#"))
MATRIZUSER DB 20 DUP (20 DUP(0))

;INICIALIZAREMOS 10 MATRIZES QUE SERAO SELECIONADAS PELO USUARIO DE FORMA ALEATORIO
MATRIZ0 DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB 0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB 0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

MATRIZ1 DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 1
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 2
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 3
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 4
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 5
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 6
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 7
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 8
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 9
        DB 0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0 ; Linha 10 
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 11
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 12
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 13
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 14
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 15
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0 ; Linha 16 
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 17
        DB 0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0 ; Linha 18 
        DB 0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0 ; Linha 19
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1 ; Linha 20 

MATRIZ2 DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 1
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 2
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 3
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 4
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 5
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 6
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 7
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 8
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 9
        DB 0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0 ; Linha 10 
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 11
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 12
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 13
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0 ; Linha 14
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1 ; Linha 15 
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 16
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0 ; Linha 17 
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 18
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1 ; Linha 19 
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 20

MATRIZ3 DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 1
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 2
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 3
        DB 0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 4
        DB 0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 5
        DB 0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 6
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 7
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 8
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 9
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 10
        DB 0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 ; Linha 11
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 12
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 13
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0 ; Linha 14
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0 ; Linha 15
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 16
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 17
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 18
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 19
        DB 1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 20

MATRIZ4 DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 1
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 2
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 3
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 4
        DB 0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0 ; Linha 5
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 6
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 7
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 8
        DB 0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 9
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 10
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 11
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 12
        DB 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 13
        DB 0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 14
        DB 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 15
        DB 0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0 ; Linha 16
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 17
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 18
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 19
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 20

MATRIZ5 DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 1
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0 ; Linha 2
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 3
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 4
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 5
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 6
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 7
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 8
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 9
        DB 0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0 ; Linha 10
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 11
        DB 0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0 ; Linha 12
        DB 0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0 ; Linha 13
        DB 0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0 ; Linha 14
        DB 0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0 ; Linha 15
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 16
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 17
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 18
        DB 0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0 ; Linha 19
        DB 0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0 ; Linha 20

MATRIZ6 DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0 ; Linha 1
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1 ; Linha 2
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0 ; Linha 3
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 4
        DB 0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 5
        DB 0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 6
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 7
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 8
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 9
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 10
        DB 0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 ; Linha 11
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 12
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 13
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 14
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 15
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 16
        DB 0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0 ; Linha 17
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 18
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 19
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 20

MATRIZ7 DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 1
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 2
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 3
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 4
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 5
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 6
        DB 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0 ; Linha 7
        DB 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0 ; Linha 8
        DB 0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 9
        DB 0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 10
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 11
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 12
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 13
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 14
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 15
        DB 0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0 ; Linha 16
        DB 0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0 ; Linha 17
        DB 0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0 ; Linha 18
        DB 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 19
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 20

MATRIZ8 DB 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 1
        DB 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 2
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 3
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 4
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 5
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 6
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0 ; Linha 7
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0 ; Linha 8
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0 ; Linha 9
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 10
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 11
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 12
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 13
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 14
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 15
        DB 0,0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0 ; Linha 16
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 17
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 18
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 19
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 20

MATRIZ9 DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 1
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 2
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 3
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 4
        DB 0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 ; Linha 5
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 6
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 7
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 8
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 ; Linha 9
        DB 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1 ; Linha 10
        DB 0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1 ; Linha 11
        DB 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 12
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 13
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 14
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 15
        DB 0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 16
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 17
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 18
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 19
        DB 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 ; Linha 20
.CODE
MAIN PROC
MOV AX,@DATA
MOV DS,AX
MOV AH,09                 ;IMPRIMI A MENSEGM DE BOAS VINDAS AO JOGO
LEA DX,MSG1
INT 21H
pulalinha
XOR SI,SI                 ;INICIALIZA SI E BX
XOR BX,BX
;COMEÇARA A IMPRIMIR A MATRIZ DE VIZUALIZAÇÃO DO USUARIO
MOV CX,400                ;CX=400 POIS A MATRIZ TEM 400 CARACTERES (20X20)
IMPRESSAODAMATRIZ
pulalinha
MOV AH,09
LEA DX,MSG2               ;IMPRIMI A MENSAGEM PARA O USUARIO DIGITAR UM NUMERO, QUE DEFINIRA A MATRIZ QUE O PC UTILIZARA
INT 21H
LEITURANUMERO
pop ax
CALL TRANSFERENCIADEMATRIZ                   ;agora para seleção de qual modelo de matriz sera usado dentre as 10, comparamos BL
CALL JOGANDO
MOV AH, 4CH
INT 21H
MAIN ENDP











TRANSFERENCIADEMATRIZ PROC
CMP BL, '0'
JE ZEROMATRIZ
CMP BL, '1'
JE UMMATRIZ
CMP BL, '2'
JE DOISMATRIZ
JNE PROXIMOSNUM1

ZEROMATRIZ:
    definicao1
TRANSFERIRZERO:
    MOV AL, MATRIZ0[BX][SI]
    MOV MATRIZUSER[BX][SI], AL
    definicao2
    JE PROXIMOSNUM1         ; SE IGUAL ENCERRA
    CMP SI, 20                ; COMPARA COM 20 PARA VER SE É A HORA DE PULAR LINHA
    JNE TRANSFERIRZERO       ; SE NÃO VOLTA AO LOOP
    ADD BX, 4                 ; SE SIM, ADICIONA 4 EM BX, MUDANDO A LINHA DA MATRIZ
    XOR SI, SI                ; ZERA SI PRA VOLTARMOS NA COLUNA 0
    JMP TRANSFERIRZERO        ; VOLTA NO LOOP
    JMP FIMT 

; Rotina para o número 1
UMMATRIZ:
    definicao1
TRANSFERIRUM:
    MOV AL, MATRIZ1[BX][SI]
    MOV MATRIZUSER[BX][SI], AL
    definicao2
    JE PROXIMOSNUM1                ; SE IGUAL ENCERRA
    CMP SI, 20                ; COMPARA COM 20
    JNE TRANSFERIRUM         ; SE NÃO VOLTA AO LOOP
    ADD BX, 4                 ; SE SIM, ADICIONA 4 EM BX
    XOR SI, SI                ; ZERA SI
    JMP TRANSFERIRUM          ; VOLTA NO LOOP
    JMP FIMT 

; Rotina para o número 2
DOISMATRIZ:
    definicao1
TRANSFERIRDOIS:
    MOV AL, MATRIZ2[BX][SI]
    MOV MATRIZUSER[BX][SI], AL
    definicao2
    JE PROXIMOSNUM1        ; SE IGUAL ENCERRA
    CMP SI, 20                ; COMPARA COM 20
    JNE TRANSFERIRDOIS       ; SE NÃO VOLTA AO LOOP
    ADD BX, 4                 ; SE SIM, ADICIONA 4 EM BX
    XOR SI, SI                ; ZERA SI
    JMP TRANSFERIRDOIS        ; VOLTA NO LOOP
    JMP FIMT 

PROXIMOSNUM1:
CMP BL, '3'
JE TRESMATRIZ
CMP BL, '4'
JE QUATROMATRIZ
CMP BL, '5'
JE CINCOMATRIZ
JNE PROXIMOSNUM2
; Rotina para o número 3
TRESMATRIZ:
    definicao1
TRANSFERIRTRES:
    MOV AL, MATRIZ3[BX][SI]
    MOV MATRIZUSER[BX][SI], AL
    definicao2
    JE PROXIMOSNUM2         ; SE IGUAL ENCERRA
    CMP SI, 20                ; COMPARA COM 20
    JNE TRANSFERIRTRES       ; SE NÃO VOLTA AO LOOP
    ADD BX, 4                 ; SE SIM, ADICIONA 4 EM BX
    XOR SI, SI                ; ZERA SI
    JMP TRANSFERIRTRES        ; VOLTA NO LOOP
    JMP FIMT 

; Rotina para o número 4
QUATROMATRIZ:
    definicao1
TRANSFERIRQUATRO:
    MOV AL, MATRIZ4[BX][SI]
    MOV MATRIZUSER[BX][SI], AL
    definicao2
    JE PROXIMOSNUM2        ; SE IGUAL ENCERRA
    CMP SI, 20                ; COMPARA COM 20
    JNE TRANSFERIRQUATRO     ; SE NÃO VOLTA AO LOOP
    ADD BX, 4                 ; SE SIM, ADICIONA 4 EM BX
    XOR SI, SI                ; ZERA SI
    JMP TRANSFERIRQUATRO      ; VOLTA NO LOOP
    JMP FIMT 

; Rotina para o número 5
CINCOMATRIZ:
    definicao1
TRANSFERIRCINCO:
    MOV AL, MATRIZ5[BX][SI]
    MOV MATRIZUSER[BX][SI], AL
    definicao2
    JE PROXIMOSNUM2        ; SE IGUAL ENCERRA
    CMP SI, 20                ; COMPARA COM 20
    JNE TRANSFERIRCINCO      ; SE NÃO VOLTA AO LOOP
    ADD BX, 4                 ; SE SIM, ADICIONA 4 EM BX
    XOR SI, SI                ; ZERA SI
    JMP TRANSFERIRCINCO       ; VOLTA NO LOOP
    JMP FIMT 

PROXIMOSNUM2:
CMP BL, '6'
JE SEISMATRIZ
CMP BL, '7'
JE SETEMATRIZ
CMP BL, '8'
JE OITOMATRIZ
CMP BL, '9'
JE NOVEMATRIZ
JMP FIMT
; Rotina para o número 6
SEISMATRIZ:
    definicao1
TRANSFERIRSEIS:
    MOV AL, MATRIZ6[BX][SI]
    MOV MATRIZUSER[BX][SI], AL
    definicao2
    JE FIMT         ; SE IGUAL ENCERRA
    CMP SI, 20                ; COMPARA COM 20
    JNE TRANSFERIRSEIS       ; SE NÃO VOLTA AO LOOP
    ADD BX, 4                 ; SE SIM, ADICIONA 4 EM BX
    XOR SI, SI                ; ZERA SI
    JMP TRANSFERIRSEIS        ; VOLTA NO LOOP 

; Rotina para o número 7
SETEMATRIZ:
    definicao1
TRANSFERIRSETE:
    MOV AL, MATRIZ7[BX][SI]
    MOV MATRIZUSER[BX][SI], AL
    definicao2
    JE FIMT         ; SE IGUAL ENCERRA
    CMP SI, 20                ; COMPARA COM 20
    JNE TRANSFERIRSETE       ; SE NÃO VOLTA AO LOOP
    ADD BX, 4                 ; SE SIM, ADICIONA 4 EM BX
    XOR SI, SI                ; ZERA SI
    JMP TRANSFERIRSETE        ; VOLTA NO LOOP 

; Rotina para o número 8
OITOMATRIZ:
    definicao1
TRANSFERIROITO:
    MOV AL, MATRIZ8[BX][SI]
    MOV MATRIZUSER[BX][SI], AL
    definicao2
    JE FIMT         ; SE IGUAL ENCERRA
    CMP SI, 20                ; COMPARA COM 20
    JNE TRANSFERIROITO       ; SE NÃO VOLTA AO LOOP
    ADD BX, 4                 ; SE SIM, ADICIONA 4 EM BX
    XOR SI, SI                ; ZERA SI
    JMP TRANSFERIROITO        ; VOLTA NO LOOP 

; Rotina para o número 9
NOVEMATRIZ:
    definicao1
TRANSFERIRNOVE:
    MOV AL, MATRIZ9[BX][SI]
    MOV MATRIZUSER[BX][SI], AL
    definicao2
    JE FIMT         ; SE IGUAL ENCERRA
    CMP SI, 20                ; COMPARA COM 20
    JNE TRANSFERIRNOVE       ; SE NÃO VOLTA AO LOOP
    ADD BX, 4                 ; SE SIM, ADICIONA 4 EM BX
    XOR SI, SI                ; ZERA SI
    JMP TRANSFERIRNOVE        ; VOLTA NO LOOP 
FIMT:
RET
TRANSFERENCIADEMATRIZ ENDP

JOGANDO PROC
    XOR CX,CX
REPETE:
leituralinha:
    XOR BX,BX
    MOV AH,09
    LEA DX,MSG3
    INT 21H
    LENDOMAISQUE9
    MOV AL,BL
    MOV BL,20
    MUL BL                    ;PRECISO MULTIPLICAR POR 20 POIS AS COLUNAS VARIAM DE 20 EM 20
    XOR BX,BX
    MOV BX,AX
leituracoluna:
    XOR SI,SI
    MOV AH,09
    LEA DX, MSG4
    INT 21H
    XOR AX,AX
    XOR DX,DX
    @LOOP_LEITURA1:
        MOV AH,01
        INT 21H
        CMP AL,13
        JE @SAI_LEITURA1     ;SE É ENTER ENTÃO SAI
        AND  AX, 0FH        ;TRANSFORMA EM NUMERO
        PUSH AX             ;GUARDA VALOR ANTES DA OPERACAO
        MOV AX,10           ;MOVE MULTIPLICADOR PARA AX
        MUL DX              ;FAZ AX x BX
        POP DX              ;DEVOLVE O VALOR PARA BX
        ADD DX,AX           ;ADCIONA O VALOR ANTES LIDO AGORA DO VALOR TOTAL (BX = BX + (BX x AX))
        JMP @LOOP_LEITURA1
        @SAI_LEITURA1:
    MOV SI,DX
comparajogo: 
xor dx, dx
    CMP MATRIZUSER[BX][SI],1 ;COMPARA O VALOR DA POSIÇÃO DIGITADA PELO USUARIO COM NOSSA MATRIZ DO PROGRAMA, SE ELA FOR 1, SIGNIFICA QUE ACERTOU A POSIÇÃO DA EMBARCAÇÃO
    JNE ZERO               ;SE NÃO FOR 1, COMEÇA DE NOVO A PEDIR POSIÇÃO
    INC dX                 ;CX SERÁ USADO COMO NOSSO CONTADOR, POIS TEMOS 13 POSIÇÕES QUE SÃO EMBARCAÇÕES ASSIM QUE ATINGIR TODAS ENCERRA
    MOV MATRIZINICIAL[BX][SI],'X'
    CMP dX,13
    JE FINALIZACAO
    JMP IMPRIMIRINICIAL1
    ZERO:
    MOV MATRIZINICIAL[BX][SI],'O'
    IMPRIMIRINICIAL1:          ;imprimi a primiera matriz de apresentação do programa
xor bx, bx
xor si, si
mov cx, 400
PRINT_LOOP:
MOV AH,02                 ;IMPRIMI
MOV DL,MATRIZINICIAL[BX][SI] 
INT 21h          
INC SI                    ;AUMENTA O VALOR DA COLUNA
DEC cX                    ;DIMINUI O CONTADOR
CMP cX,0                  ;COMPARA COM CX, SE FOR 0 ACABA
JE repete                   ;SE IGUAL ENCERRA
CMP SI,20                  ;COMPARA COM 4 PRA VER SE É A HORA DE PULAR LINHA
JNE PRINT_LOOP             ;SE NÃO VOLTA AO LOOP
ADD BX,20                  ;SE SIM ADICIONA 4 EM BX, MUDANDO A LINHA DA MATRIZ
XOR SI,SI                 ;ZERA SI PRA VOLTARMOS NA COLUNA 0
pulalinha                 ;MACRO DE PULAR LINHA
JMP PRINT_LOOP            ;VOLTA NO LOOP
FIMIMPINICIAL1:
pulalinha
FINALIZACAO:
RET
JOGANDO ENDP

END MAIN
