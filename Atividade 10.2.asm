Title Ativ3
.Model SMALL
.stack 100h

pula_linha MACRO ; macro pra pular linha
    push ax       ; guarda ax na pilha
    push dx       ; guarda dx na pilha
    mov ah, 02    ;
    mov dl, 10    ; código ASCII pra nova linha
    int 21h       
    pop dx        ; resgata dx da pilha
    pop ax        ; resgata ax da pilha
ENDM

.DATA
msg1 db 10, 13, 'matriz: $' ; mensagem inicial 
matriz db 0,0,0,0            ; cria matriz 4x4 
       db 0,0,0,0
       db 0,0,0,0
       db 0,0,0,0
soma db 0                    ; variável pra guardar a soma dos valores
contador db 0
.CODE
main proc
    ; inicializa o segmento de dados
    mov ax, @DATA
    mov ds, ax

    ; exibe a mensagem inicial 
    mov ah, 9
    mov dx, offset msg1
    int 21h

    ; chama as funções pra ler, imprimir e somar os valores da matriz
    call ler       ; lê os valores da matriz
    call imprimir  ; exibe os valores da matriz
    call somar     ; calcula e exibe a soma dos valores

    ; finaliza o programa
    mov ah, 4Ch
    int 21h
main endp
    
ler PROC
    xor si, si      ; zera o índice de linha (si)
    xor bx, bx      ; zera o índice de coluna (bx)
    mov ch, 4       ; define que são 4 colunas

lercoluna:
    mov cl, 4       ; define que são 4 linhas

lelinha:
    mov ah, 1       ; lê um caractere do teclado
    int 21h         

    mov matriz[si+bx], al ; joga o valor lido na matriz
    inc si          ; incrementa o índice de linha
    dec cl          ; decrementa o contador de linhas
    jnz lelinha     ; se ainda tem linha, continua lendo

    add bx, 4       ; avança pra próxima coluna
    xor si, si      ; reseta o índice de linha
    dec ch          ; decrementa o contador de colunas
    pula_linha
    jnz lercoluna   ; se ainda tem coluna, continua lendo
    ret             ; volta pro main
    
ler ENDP
    
imprimir proc
    ; exibe os valores que estão na matriz 4x4
    xor si, si      ; zera si(linhas)
    xor bx, bx      ; zera bx(colunas)
    mov ch, 4       ; define que são 4 colunas

imprimecoluna:
    mov cl, 4       ; define que são 4 linhas

escrevelinha:
    mov dl, matriz[si+bx] ; pega o valor da matriz
           ; adiciona o valor pra soma
    or dl, 30h            ; transforma em ASCII
add soma, dl   
    mov ah, 2            
    int 21h               ; exibe o caractere

    inc si                ; próximo índice de linha
    dec cl                ; decrementa o contador de linhas
    jnz escrevelinha      ; se ainda tem linha, continua

    pula_linha            ; pula linha macro
    add bx, 4             ; avança pra próxima coluna
    xor si, si            ; reseta o índice de linha
    dec ch                ; decrementa o contador de colunas
    jnz imprimecoluna     ; se ainda tem coluna, continua

    ret                   ; volta pro main
imprimir endp

somar PROC
    xor ah, ah
    mov al, soma
    xor bx, bx
    mov bx, 10
    xor cx, cx
    divi:
    cmp ax, bx
    inc cx
    JB escreverr
    xor dx, dx
    div bx
    push dx
    jmp divi

    escreverr:
    mov dl, al
    add dx, 30h
    mov ah, 2
    int 21H
    pop ax
    loop escreverr
    ret
somar ENDP
end main
