Title recomeco
.Model SMALL
.DATA
msg1 db 10, 13, "Digite um caracter:$"
msg2 db 10, 13, "o caracter digitado eh:$"
.CODE
main proc

;chama o @data para o main
mov ax,@DATA 
mov ds,ax

;escrever a msg 1 na tela
mov ah, 9
Lea dx, msg1 
int 21h

;le um caracter do teclado
mov ah, 1 
int 21h

;move ele de al para bl
mov bl, al

;escreve a msg2 na tela
mov ah, 9
Lea dx, msg2
int 21h

;exibe o caracter contido na tela
mov ah,2
mov dl, bl
int 21h

main ENDP
end main
