Title Ativ3
.Model SMALL
.stack 100h
pula_linha MACRO
    push ax          ; salva ax na pilha
    push dx          ; salva dx na pilha
    mov ah, 02       
    mov dl, 10       ; código ASCII pra nova linha
    int 21h          
    pop dx           ; restaura dx
    pop ax           ; restaura ax
ENDM
.DATA
msg1 db 10, 13, 'matriz:', 13, 10, ' $' ; mensagem 
matriz db 1,2,3,4                        ; define uma matriz 4x4 
       db 4,3,2,1
       db 5,6,7,8
       db 8,7,6,5
.CODE
main proc
    ; Configura o segmento de dados
    mov ax, @DATA
    mov ds, ax
    ; Exibe a mensagem "matriz:"
    mov ah, 9
    mov dx, offset msg1
    int 21h
    ; Chama o procedimento pra mostrar a matriz
    call imprimir
    ; Finaliza o programa
    mov ah, 4Ch
    int 21h
main endp
    
imprimir proc
    ; Mostra os valores da matriz na tela
    xor si, si        ; zera si(linhas)
    xor bx, bx        ; zera bx(colunas)
    mov ch, 4         ; define 4 colunas

imprimecoluna:
    mov cl, 4         ; define 4 linhas

escrevelinha:
    mov dl, matriz[si+bx] ; pega o valor da matriz na posição (si+bx)
    or dl, 30h            ; transforma o valor em ASCII
    mov ah, 2             ; função pra exibir caractere
    int 21h              
    inc si                ; próximo índice de linha
    dec cl                ; decrementa o contador de linhas
    jnz escrevelinha      ; se ainda tem linha, continua
    pula_linha            ; pula pra próxima linha na saída
    add bx, 4             ; vai pra próxima coluna
    xor si, si            ; reseta o índice de linha
    dec ch                ; decrementa o contador de colunas
    jnz imprimecoluna     ; se ainda tem coluna, continua
    ret                   ; volta pra main
imprimir endp
end main
